@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 93be891396484d2d957b68996a45257d -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Alu_tb_behav xil_defaultlib.Alu_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
