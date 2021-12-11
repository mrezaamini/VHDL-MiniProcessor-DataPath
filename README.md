# 32-bit Integer Unit Data Path & Controller (VHDL)
In this project, I implemented a simple 32-bit Integer Unit Data Path & Controller using VHDL and finite state machines. It's a good example to see how you can implement finite state machines and use them to make contollers in processors with datapath in VHDL. 

## Table of Contents
- [Description](#description)
- [Test](#test)
- [Support + Feedback](#support--feedback)
- [Thank You](#thank-you)
- [License](#license)

## Description:
This simple 32-bit Integer Unit consists of four 32-bit registers (A, B, C, D), an ALU, 32x64 SRAM, 32-bit accumulator and a general 32-bit bus. This mini-processor can perform 11 different functions. You can see data path and functions in the image bellow:
<p align="center">
<img src="https://github.com/mrezaamini/VHDL-MiniProcessor-DataPath/blob/main/datapath-functions.png" alt="datapath and functions" width="500" />
</p>

For a better understanding of how this unit works, you can see signal quantifications bellow:
<p align="center">
<img src="https://github.com/mrezaamini/VHDL-MiniProcessor-DataPath/blob/main/report.png" alt="signal quantifications" width="500" />
</p>

- ld_cw[4..0]: load signal control word that each bit specifies if we are loading data to a specific register or not.
- bus_sel[1..0]: shows which data we want to send through the bus.
- memAdr[5..0]: 6-bit that specifies input address for the SRAM (note: in functions that uses registers as the address we only use 6 LSBs of them for this part).
- aluFunc[2..0]: specifies the function of the ALU.

## Test:
intUnit_pack contains a package that help us with reading input files for testbench, and testbench reads from myinput.txt and starts the test. This test is done with ModelSim simulator and simulation time is 1000 ns. (you can run and observe SRAM in modelsim : windows > memory space).

Test Example:
<p align="center">
<img src="https://github.com/mrezaamini/VHDL-MiniProcessor-DataPath/blob/main/result.png" alt="test"/>
</p>

## Support + Feedback

Include information on how to get support.
- easily contact me with [email](aminiamini433@yahoo.fr)

## Thank You

Thanks for paying attention, and hope it was usefull for you!

## License
Link to [LICENSE](LICENSE) doc.