eq1=@equ s^2=Δx^2+Δy^2
eq2=@equ s^2=Δx´^2+Δy´^2
eq3=@equ s^2=-(c*Δt)^2+Δx^2+Δy^2+Δz^2
eq4=@equ s^2=-(c*Δt´)^2+Δx´^2+Δy´^2+Δz´^2
eq5=@equ xμ=Tensor([c*t,x,y,z],μ,0,1)
eq6=@equ c=1
eq7=@equ xi=Tensor([x,y,z],i,0,1)
eq8=@equ ημν=Tensor(diagm([-1,1,1,1]),0,[μ,ν],2)
eq9=@equ s^2=ημν*Δxμ*Δxν
eq10=@equ xμ´=xμ+aμ
eq11=@equ xμ´=Tensor(Λ,μ´,ν,2)*Tensor([c*t,x,y,z],ν,0,1)
eq12=@equ x´=Λ*x
eq13=@equ Transpose(Δx)*η*Δx=Transpose(Δx)*Transpose(Λ)*η*Λ*Δx
eq14=@equ η=Transpose(Λ)*η*Λ
eq15=@equ Tensor(η,0,[ρ,σ],2)=Tensor(Λ,μ´,ρ,2)*Tensor(Λ,ν´,σ,2)*Tensor(η,0,[μ´,ν´],2)
eq16=@equ Mat(eye(3))=Transpose(Mat(R))*Mat(eye(3))*Mat(R)
eq17=@equ Tensor(Λ,μ´,ν,2)=Tensor([1 0 0 0;0 cos(θ) sin(θ) 0;0 -sin(θ) cos(θ) 0;0 0 0 1])
eq18=@equ Tensor(Λ,μ´,ν,2)=Tensor([cosh(ϕ) -sinh(ϕ) 0 0;-sinh(ϕ) cosh(ϕ) 0 0;0 0 1 0;0 0 0 1])
eq19=@equs(t´=t*cosh(ϕ)-x*sinh(ϕ), x´=-t*sinh(ϕ)+x*cosh(ϕ))
eq20=EquationChain([:v,:x/:t,sinh(:ϕ)/cosh(:ϕ),tanh(:ϕ)])
eq21=@equs(t´=γ*(t-v*x), x´=γ*(x-v*t))
gamma=@equ γ=1/Sqrt(1-v^2)
eq22=@equ (a+b)*Vec(V+W)=(a+b)*Vec(V)+(a+b)*Vec(W)
eq23=@equ A=Tensor(A,μ,0,1)*Tensor(ê,0,μ,2)
eq24=@equ Tensor(V,μ,0,1)=Der(Tensor(x,μ,0,1),λ)
eq25=@equ Tensor(V,μ´,0,1)=Tensor(Λ,μ´,ν,2)*Tensor(V,ν,0,1)
eq26=EquationChain(:V, Tensor(:V,:ν´,0,1)*Tensor(:ê,0,:ν´,2), Tensor(:Λ,:ν´,:μ,2)*Tensor(:V,:μ,0,1)*Tensor(:ê,0,:ν´,2))
eq27=@equ Tensor(ê,0,μ,2)=Tensor(Λ,ν´,μ,2)*Tensor(ê,0,ν´,2)
eq28=@equ Tensor(1/Λ,ν´,μ,2)=Tensor(Λ,μ,ν´,2)
eq29=@equs(Tensor(Λ,μ,ν´,2)*Tensor(Λ,σ´,μ,2)=Delta(σ´,ν´), Tensor(Λ,μ,ν´,2)*Tensor(Λ,ν´,ρ,2)=Delta(μ,ρ))
eq30=@equ Tensor(ê,0,ν´,2))=Tensor(Λ,μ,ν´,2)*Tensor(ê,0,μ,2)

eq31=@equ a*ω*V+b*ω*W=Real

eq33=@equ Ten(θ,Up(n))*Ten(ê,m)=Delta(n,m)
eq34=@equ ω=Ten(ω,m)*Ten(θ,Up(m))
eq35=@equ Ten(ω,m)*Ten(V,Up(n))*Ten(θ,Up(n))*Ten(ê,m)=Ten(ω,m)*Ten(V,Up(m))

eq37=@equ Ten(ω,m´)=Ten(Λ,[m´,Up(n)])*Ten(ω,n)
V=[1,2,3];ω=[1 2 3]

eq40=@equ D(phi)=Der(phi,Ten(x,Up(mu)))*Ten(θ,Up(m))
eq41=@equc(Der(phi,Ten(x,Up(mu´)))=Der(Ten(x,m)=Ten(Λ,[m´,Up(m)])*Der(phi,Ten(x,Up(m)))
