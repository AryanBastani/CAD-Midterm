alias clc ".main clear"

clc
exec vlib work
vmap work work

set TB					"tb"
set hdl_path			"../src/hdl"
set inc_path			"../src/inc"

set run_time			"-all"

#============================ Add verilog files  ===============================

vlog 	+acc -incr -source  +define+SIM 	$hdl_path/adder_7bit.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/adder_8bit.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/adder_12bit.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/buffer_1_4.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/buffer_4_16.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/circuit.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/controller.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counetr_2bit.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter_4bit.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/datapath.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/filter_buffer.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mac.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/memory.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/multiplier_8bit.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux_1bit_2_1.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux_2bit_2_1.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux_2bit_4_1.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux_7bit_2_1.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux_7bit_3_1.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux_32bit_2_1.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/pc.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/reg_7bit.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/reg_8bit.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/reg_12bit.v
vlog 	+acc -incr -source  +define+SIM 	$hdl_path/table_buffer.v


vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM ./tb/tb.v
onerror {break}

#================================ simulation ====================================

vsim	-voptargs=+acc -debugDB $TB

#======================= adding signals to wave window ==========================

add wave -hex -group 	 	{TB}				sim:/$TB/*
add wave -hex -group 	 	{top}				sim:/$TB/perm/*
add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================

configure wave -signalnamewidth 2

#====================================== run =====================================

run $run_time