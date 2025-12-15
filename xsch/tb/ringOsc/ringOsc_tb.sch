v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 100 0 140 0 {lab=out}
N -120 10 -100 10 {lab=GND}
N -120 10 -120 30 {lab=GND}
N -180 -20 -100 -20 {lab=#net1}
C {ip/ringOsc/ringOsc.sym} 0 0 0 0 {name=x1}
C {devices/noconn.sym} 140 0 2 0 {name=l1}
C {devices/lab_pin.sym} 120 0 1 0 {name=p1 sig_type=std_logic lab=out}
C {devices/gnd.sym} -120 30 0 0 {name=l2 lab=GND}
C {devices/vsource.sym} -180 10 0 0 {name=V1 value=1.8 savecurrent=false}
C {devices/gnd.sym} -180 40 0 0 {name=l3 lab=GND}
C {devices/code.sym} 200 -50 0 0 {name=SIM only_toplevel=false value="

.control

tran 0.1p 10n

wrdata FILE.csv v(out)

.endc
.saveall
"}
C {sky130_fd_pr/corner.sym} 330 -50 0 0 {name=CORNER only_toplevel=false corner=tt}
