#coursecompiler
using DelimitedFiles

function process(fname,title)
	text=read("$fname",String)
	pages=""
	ta=split(text,"\n\n")
	nl=false
	for t in ta
		if length(t)<5
			continue
		end
		t=replace(t,"\n" => "\n\n")
		tit=split(t,':')[1]
		fn=replace(lowercase(tit)," "=>"")
		t="***"*t
		if nl
			pages*="\n"
		end
		pages*=fn*"/"*tit
		f=open(fn*".txt","w")
		write(f,t)
		close(f)
		nl=true
	end
	f=open("pages.txt","w")
	write(f,pages)
	close(f)
end

files=["Matthew.txt"]
for fi in 1:size(files,1)
	process(files[fi],files[fi])
end

