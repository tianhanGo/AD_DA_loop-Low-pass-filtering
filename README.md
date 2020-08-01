# AD_DA_loop-Low-pass-filtering
AD_DA_loop— Low pass filtering
2020年新工科联盟-Xilinx暑期学校（Summer School）项目。



项⽬概要：

本项目实现了在FPGA内部进行的FIR低通滤波器设计，可以滤除100KHz以外的带外噪声信号。并对使用**Xilinx FIR IP核**与**自行设计的****FIR滤波器算法**进行使用**资源对比分析**，结论是：自行设计的FIR低通滤波器算法可以利用LUT资源换取DSP资源的消耗，从而大大节省片上的DSP资源。



工具版本：Vivado 2018.3

FPGA板卡：SEA-S7

小组成员：田 晗、罗志彬

Sourcecode：FPGA源码

ExecutableFiles：本⽬录存放可直接下载到板卡使⽤的FPGA 比特流文件



说明：

本项目有两个版本：

AD_DA_low_filter_V1：使用xilinx的FIR IP核

AD_DA_low_filter_V2：自己设计的FIR算法，不使用FIR IP核。