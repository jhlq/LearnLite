#qraw=readall("1.3qraw.txt")

#section="1.3"
function parseq(section)
	questions=""
	answers=String[]
	f=open("$(section)qraw.txt")
	r=readline(f)
	while !eof(f)
		if r[1]=='Q' && r[1:9]=="QUESTION "
			questions=questions*"\n*Question $section."*r[10:11]*"\n"*readline(f)*"\n<ul>\n"
			#println(questions)
			readline(f)
			ops=readline(f)
			ops2=replace(ops,"  ","\t")
			ops3=readdlm(IOBuffer(ops2),'\t')
			#show(ops3)
			for opi in 1:length(ops3)
				if ops3[opi]!="" && ops3[opi][end-2:end]=="ect" && ops3[opi][end-7:end]==" correct"
					l=length(ops3[opi][1:end-9])
					ops3[opi]=ops3[opi][1:int(l/2)]
				end
				questions=questions*ops3[opi]*"\n"
			end
			questions=questions*"</ul>\n"
		elseif r[1]=='E' && r[1:9]=="EXPLANATI"
			readline(f)
			line=readline(f)
			ans=""
			while line=="" || line=="\n" || line[1:5]!=" HIDE"
				ans*=line
				line=readline(f)
				#show(line)
			end
			push!(answers,ans)
		end
		r=readline(f)
	end
	close(f)
	for ai in 1:length(answers)
		f=open("$(section)a$(ai).txt","w")
		write(f,answers[ai])
		close(f)
	end 
#	f=open("$(section)q.txt","w")
#	write(f,questions)
#	close(f)
	f=open("w1parsedq.txt","a")
	write(f,questions)
	close(f)
	return questions,answers
end
parseq("1.2");parseq("1.3");parseq("1.4");parseq("1.5")
