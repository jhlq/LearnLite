r=10 #micrometers
A=4pi*r^2 #meter squared, surface area of a sphere
C=10 #pF
V=0.1 #volt
Q=C*V #pC
e=1.6e-19 #coulumb, elementary charge
N=Q*1e-12/e #number of particles
NA=6e23 #1/mol Avogadro constant


R=8.3144621 #J/(mol*K)
F= 96485.3329 #s A / mol
z=1
T=310.15
cQ=5/150 #quotient of concentration outside divided by ion concentration inside

Eca=R*T/(z*F)*log(cQ)
