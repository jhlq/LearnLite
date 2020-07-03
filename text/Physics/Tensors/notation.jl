using Equations
ex=Ten([1,2,3],:i)*Ten([90,80,70],:i)
	inds=indsin(ex,Ten)
	it1=inds[1][2] #loop over terms
	termi=it1[1][1]
	indices=Array[]
	for i in it1
		push!(indices,Any[])
		pushall!(indices[i],ex[termi][i].indices)
	end
	ii=[0,0]
	for i in 1:length(indices)
		b=false
		for j in 1:length(indices)
			if i==j
				continue
			elseif indices[i]==indices[j]
				ii[1]=it1[i]
				ii[2]=it1[j]
				b=true
				break
			end
		end
		if b
			break
		end
	end
	if ii[1]!=0
		if isa(ex[termi][ii[1]].indices,Array)
			#handle
		else
			l=length(ex[termi][ii[1]].x)
			nx=0
			for i in 1:l
				nx+=ex[termi][ii[1]].x[i]*ex[termi][ii[2]].x[i]
				#println(nx)
			end
			ex[termi][ii[1]]=nx
			ex[termi][ii[2]]=1
		end
		simplify(ex)
	end
