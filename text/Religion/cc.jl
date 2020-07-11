#Preprintprocessor
#coursecompiler
using DelimitedFiles
function skipto(str,char)
	for ci in 1:length(str)
		#print(str[ci])
		try
			if str[ci]==char
				return ci
			end
		catch er
			#error("There was a problem reading this at index $ci: $(str[ci-1])")
		end	
	end
	return 0
end
function makelistarray(list)
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

function process(fname,title)
	text=read("$fname.txt",String)
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
		if p[1]!='<'
			htmltext="<p>$p</p>"
			text=text[1:nnloc[1]]*htmltext*text[nnnloc[1]:end]
		end
		nnloc=something(findfirst("\n\n",text[nnloc[end]:end]), 0:-1).+nnloc[end].-1
	end

	f=open("$fname.html","w")
	write(f,doc)
	close(f)
#	print(text)
end

pagestoprocess=readdlm("pages.txt",'/')
for pi in 1:size(pagestoprocess,1)
	process(pagestoprocess[pi,1],pagestoprocess[pi,2])
end

