v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 -20 0 20 {lab=out}
N -60 -50 -40 -50 {lab=in}
N -60 -40 -60 50 {lab=in}
N -60 50 -40 50 {lab=in}
N -60 -50 -60 -40 {lab=in}
N -80 -0 -60 0 {lab=in}
N -0 -100 -0 -80 {lab=VDD}
N -0 80 0 100 {lab=#net1}
N -0 50 10 50 {lab=#net1}
N 10 50 10 80 {lab=#net1}
N 0 80 10 80 {lab=#net1}
N 0 -50 10 -50 {lab=VDD}
N 10 -80 10 -50 {lab=VDD}
N 0 -80 10 -80 {lab=VDD}
N 0 0 80 0 {lab=out}
C {sky130_fd_pr/nfet_01v8.sym} -20 50 0 0 {name=M2
L=0.15
W=1  
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -20 -50 0 0 {name=M11
L=0.15
W=1
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {devices/ipin.sym} -80 0 0 0 {name=p1 lab=in}
C {devices/opin.sym} 80 0 0 0 {name=p2 lab=out}
C {devices/iopin.sym} 0 -100 3 0 {name=p3 lab=VDD}
C {devices/iopin.sym} 0 100 1 0 {name=p4 lab=VSS}
