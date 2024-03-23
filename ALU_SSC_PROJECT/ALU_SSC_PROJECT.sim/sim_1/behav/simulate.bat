@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim Alu_tb_behav -key {Behavioral:sim_1:Functional:Alu_tb} -tclbatch Alu_tb.tcl -view C:/Users/Dana Pode/ALU_SSC_PROJECT/Alu_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
