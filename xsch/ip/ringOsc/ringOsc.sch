v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -100 0 -60 0 {lab=#net1}
N 100 0 140 0 {lab=#net2}
N 300 0 320 0 {lab=out}
N 320 0 320 100 {lab=out}
N -280 100 320 100 {lab=out}
N -280 0 -280 80 {lab=out}
N -280 -0 -260 0 {lab=out}
N -280 80 -280 100 {lab=out}
N 320 0 340 0 {lab=out}
C {ip/inv/inv.sym} -200 0 0 0 {name=x1}
C {ip/inv/inv.sym} 0 0 0 0 {name=x2}
C {ip/inv/inv.sym} 200 0 0 0 {name=x3}
C {devices/lab_pin.sym} -200 -40 1 0 {name=p1 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 0 -40 1 0 {name=p2 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 200 -40 1 0 {name=p3 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} -200 40 3 0 {name=p4 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 0 40 3 0 {name=p5 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 200 40 3 0 {name=p6 sig_type=std_logic lab=VSS}
C {devices/opin.sym} 340 0 0 0 {name=p7 lab=out}
C {devices/iopin.sym} -340 -110 2 0 {name=p8 lab=VDD}
C {devices/iopin.sym} -340 -90 2 0 {name=p9 lab=VSS}
