#Preprintprocessor
using DelimitedFiles, Dates
function skipto(str,char)
	for ci in 1:length(str)
		try
			if str[ci]==char
				return ci
			end
		catch er
			#@warn("There was a problem reading $str at index $ci, previous index has: $(str[ci-1])")
		end	
	end
	return 0
end
function makelistarray(list)
	return split(list,'\n')
#-.-
	listarray=AbstractString[]
	n1=skipto(list,'\n')
	push!(listarray,list[1:n1])
	n2=skipto(list[n1+1:end],'\n')+n1
	while n2>n1
		push!(listarray,list[n1:n2])
		n1=n2
		n2=skipto(list[n1+1:end],'\n')+n1
	end
	return listarray
end

function process(pagestoprocess,pai)
	fname=pagestoprocess[pai,1]
	title=pagestoprocess[pai,2]
	text=read("$fname.txt",String)
	text=replace(text, "< " => "&lt;")
	text=replace(text, " >" => "&gt;")
	text=replace(text, "& " => "&amp;")
	text=replace(text, "’" => "'")
	codeloc=something(findfirst("\n<code>", text), 0:-1)
	while !isempty(collect(codeloc))
		codeend=something(findfirst("</code>",text[codeloc[end]:end]), 0:-1).+(codeloc[end]-1)
		codetext=text[codeloc[2]:codeend[1]]
		codetext=replace(codetext, "\n" => "<br>\n")
		#if text[codeloc[1]-1]=='\n' #some code blocks get bundled together
		#	codetext=replace(codetext, "<code><br>\n" => "<code>\n")
		#end
		codetext=replace(codetext, "	" => "&nbsp;&nbsp;")
		codetext=replace(codetext, "  " => "&nbsp;&nbsp;")
		codetext=replace(codetext, "\n" => "\n ")
		text=text[1:codeloc[1]]*codetext*text[codeend[2]:end]
		codeloc=something(findfirst("\n<code>", text[codeloc[end]:end]), 0:-1).+codeloc[end-1]
	end
	linkloc=something(findfirst("\nhttp", text), 0:-1)
	if isempty(collect(linkloc))
		linkloc=something(findfirst("\n!link:", text), 0:-1)
	end
	while !isempty(collect(linkloc))
		linkend=skipto(text[linkloc[end]:end],' ')
		lineend=skipto(text[linkloc[end]:end],'\n')
		if linkend==0 #why does it become 0..?
			linkend=lineend
		end
		linkend=min(linkend,lineend)
		linkloc=linkloc[2]:linkloc[end]+linkend-2
		link=text[linkloc]
		if text[linkloc[1]-1]=='\n' && lineend>linkend
			linktextloc=linkloc[end]+1:linkloc[4]+lineend-(link[1]=='!' ? 0 : 2)
			linktext=text[linktextloc]
			htmltext="""<a href="$link" target="_blank">$linktext</a>"""
			if link[1]=='!'
				htmltext="""<a href="$(link[7:end])">$linktext</a>"""
			end
			l=length(htmltext)
			text=text[1:linkloc[1]-1]*htmltext*text[linktextloc[end]+1:end]
		else
			htmltext="""<a href="$link" target="_blank">$link</a>"""
			if link[1]=='!'
				htmltext="""<a href="$(link[7:end])">$(link[7:end])</a>"""
			end
			l=length(htmltext)
			text=text[1:linkloc[1]-1]*htmltext*text[linkloc[end]+1:end]
		end
		linkloc=something(findfirst("\nhttp",text[linkloc[1]+l:end]), 0:-1).+(linkloc[1]+l-1)
		if isempty(collect(linkloc))
			linkloc=something(findfirst("\n!link:", text), 0:-1)
		end
	end
	hloc=something(findfirst("*", text), 0:-1)
	while !isempty(collect(hloc))
		hloc1=hloc[end]
		hn=text[hloc1+1]=='*' ? (text[hloc1+2]=='*' ? 1 : 2) : 3
		hstart=hloc1+4-hn
		lineend=skipto(text[hstart:end],'\n')
		htext=text[hstart:hstart+lineend-2]
		htmltext="<h$hn>$htext</h$hn>\n"
		text=text[1:hloc1-1]*htmltext*text[hstart+lineend-1:end]
		hloc=something(findfirst("\n*", text), 0:-1)
	end
	hloc=something(findfirst("\n#",text), 0:-1)
	while !isempty(collect(hloc))
		hloc1=hloc[1]+1
		hn=text[hloc1+1]=='#' ? (text[hloc1+2]=='#' ? 1 : 2) : 3
		hstart=hloc1+4-hn
		lineend=skipto(text[hstart:end],'\n')
		htext=text[hstart:hstart+lineend-2]
		htmltext="<h$(hn+3)>$htext</h$(hn+3)>\n"
		text=text[1:hloc1-1]*htmltext*text[hstart+lineend-1:end]
		hloc=something(findfirst("\n#",text), 0:-1)
	end
	imgloc=something(findfirst("\nimg: ",text), 0:-1)
	while !isempty(collect(imgloc))
		lineend=skipto(text[imgloc[end]:end],'\n')
		htmltext="""<img src="$(text[imgloc[end]+1:imgloc[end]+lineend-2])" alt="$(text[imgloc[end]+1:imgloc[end]+lineend-2])">"""
		text=text[1:imgloc[1]]*"\n"*htmltext*"\n"*"\n"*text[imgloc[end]+lineend-1:end]
		imgloc=something(findfirst("\nimg:",text), 0:-1)
		break
	end
	text=replace(text,"\n\n<ul>" => "\n<ul>")
	text=replace(text,"\n<ul>" => "\n\n<ul>")
	ulloc=something(findfirst("\n<ul>",text), 0:-1)
	while !isempty(collect(ulloc))
		tulloc=something(findfirst("</ul>",text[ulloc[end]:end]), 0:-1).+(ulloc[end]-1)
		list=text[ulloc[end]+2:tulloc[1]-2]
		listarray=makelistarray(list)
		htmltext=""
		for li in listarray
			htmltext*="<li>$li</li>\n"
		end
		text=text[1:ulloc[end]]*htmltext*text[tulloc[1]:end]
		ulloc=something(findfirst("\n<ul>",text[tulloc[end]:end]), 0:-1).+(tulloc[end]-1)
	end
	text=replace(text,"<easy>" => """<div class="easy">\n""")
	text=replace(text,"<green>" => """<div class="green">\n""")
	text=replace(text,"<yellow>" => """<div class="yellow">\n""")
	text=replace(text,"<red>" => """<div class="red">\n""")
	text=replace(text,"</div>" => "\n</div>")
	text*='\n'
	while occursin("\n\n\n",text)
		text=replace(text,"\n\n\n" => "\n\n")
	end
	nnloc=something(findfirst("\n\n",text), 0:-1)
	while !isempty(collect(nnloc))
		nnnloc=something(findfirst("\n\n",text[nnloc[end]:end]), 0:-1).+(nnloc[end]-1)
		if isempty(collect(nnnloc))
			break
		end
		p=text[nnloc[end]+1:nnnloc[1]-1]
		if p!="" && (p[1]!='<' || p[2]=='a')
			htmltext="<p>$p</p>"
			text=text[1:nnloc[1]]*htmltext*text[nnnloc[1]:end]
		end
		nnloc=something(findfirst("\n\n",text[nnloc[end]:end]), 0:-1).+nnloc[end].-1
	end
	medloc=something(findfirst("\nyellow:",text), 0:-1)
	while !isempty(collect(medloc))
		nloc=something(findfirst("\n",text[medloc[end]:end]), 0:-1)+medloc[end]-1
		p=text[medloc[end]+1:nloc[1]-1]
		htmltext="""<span class="yellow">$p</span>"""
		text=text[1:medloc[1]]*htmltext*text[nloc[1]:end]
		medloc=something(findfirst("\nyellow:",text[medloc[end]:end]), 0:-1)+medloc[end]-1
	end
	nav=read("nav.txt",String)
	dir=read("title.txt",String)
	dir=dir[1:end-1]
	next=""
	if size(pagestoprocess)[1]>pai
		next="""<a href="$(pagestoprocess[pai+1,1]).html" id="next">Next page.</a>\n"""
	end
	doc="""<!DOCTYPE html>
	<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>LearnLite: $dir, $title</title>
	<link rel="stylesheet" type="text/css" href="../style.css">
	</head>
	<body>
	$nav
	$text
	<br>$next<br><br>
	<footer>
	$nav
	</footer>
	<p><small>Updated on $(Dates.today()).</small></p>
	</body>
	</html>"""
	f=open("pppout/$fname.html","w")
	write(f,doc)
	close(f)
end

pagestoprocess=readdlm("pages.txt",'/')
nav="""<nav>
	<a href="../index.html">Home.</a>
"""
for pai in 1:size(pagestoprocess,1)
	global nav*="""	<a href="$(pagestoprocess[pai,1]).html">$(pagestoprocess[pai,2]).</a>\n"""
end
nav*="</nav>"
f=open("nav.txt","w")
write(f,nav)
close(f)
isdir("pppout") ? nothing : mkdir("pppout")
for pai in 1:size(pagestoprocess,1)
	process(pagestoprocess,pai)
end
rm("nav.txt")
