function parseq(section)
	questions=""
	answers=String[]
	text=readall("$(section)qraw.txt")
	text=replace(text,"- incorrect","- correct")
	#text=replace(text,"- correct"," ")
	text=replace(text,"You have used 1 of 1 submissions","12345")
	#text=replace(text,"(1 point possible)\n","\n<ul>")
	#text=replace(text,"(1/1 point)\n","\n<ul>")
	text=replace(text,"\nExplanation","</ul>\nExplanatio")
	#text=replace(text,"?\n","?\n<ul>\n")
	f=open("$(section)qrawp.txt","w")
	write(f,text)
	close(f)
	f=open("$(section)qrawp.txt")
	r=readline(f)
	while !eof(f)
		if r[1]=='Q' && r[1:9]=="Question "
			#questions=questions*"\n*Question $section."*r[10:11]*"\n"*readline(f)*"\n<ul>\n"
			questions*="\n*Question $section."*r[10:11]*"\n"
			readline(f)
			questions*=readline(f)*"<ul>\n"
			#println(questions)
			for i in 1:5
				s=readline(f)
				if contains(s,"- correct")
					#println(s,length(s))
					s=s[1:(length(s)-9)/2]*"\n"
				end
				questions*=s
			end
#			ops=readline(f)
#			ops2=replace(ops,"  ","\t")
#			ops3=readdlm(IOBuffer(ops2),'\t')
#			show(ops)
#			for opi in 1:length(ops3)
				#if ops3[opi]!="" && ops3[opi][end-2:end]=="ect" && ops3[opi][end-7:end]==" correct"
				#	l=length(ops3[opi][1:end-9])
				#	ops3[opi]=ops3[opi][1:int(l/2)]
				#end
#				questions=questions*ops3[opi]*"\n"
#			end
#			questions=questions*"</ul>\n"
		elseif r[1]=='E' && r[1:9]=="Explanati"
			readline(f)
			line=readline(f)
			ans=""
			while line=="" || line=="\n" || line[1:5]!="12345"
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
	f=open("parsedq.txt","a")
	write(f,questions)
	close(f)
	return questions,answers
end
s=7;parseq("$(s).1");parseq("$(s).2");parseq("$(s).3");parseq("$(s).4")#;parseq("$(s).5")
