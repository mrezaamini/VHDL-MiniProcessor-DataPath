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
<br></br>
<p align="center">
<img src="" alt="datapath and functions" width="350" />
</p>


- come[0..3]: 4-bit input, each floor has it's own button and this signal shows us which floor's button in the building is pushed.
- cf[0..3]: 4-bit input, shows us pushed buttons inside the elevator.
- switch[0..3]: 4-bit input, there is a switch in each floor that turns 1 whenever the elevator reaches to that specific floor.
- motor-up: 1-bit output, 1 when elevator is moving up.
- motor-down: 1-bit output, 1 when elevator is moving down.
- current-floor: in this implementation is 4-bit output that shows which floor is elevator in (for showing it inside the cabin).
- move-state: 1-bit output, 1 when elevator is moving and 0 when it stops.

## TEST:
The main test is with a simple testbench that initiates a clock (clk) and changes inputs over time.
In Addition, there's another testbench in the "text file testbench" folder that contains testbench, supporting package, and input text file. (for further information about this testbench click [here](https://mrezaamini.github.io/Elevator-controller-FSM/). )
Tests are done with modelSim simulator. 
Test Example:
<br></br>
<p align="center">
<img src="https://github.com/mrezaamini/Elevator-controller-FSM/blob/main/assets/test.png" alt="test"/>
</p>

## Support + Feedback

Include information on how to get support.
- easily contact me with [email](aminiamini433@yahoo.fr)

## Thank You

Thanks for paying attention, and hope this contest was usefull for you!

## License
Link to [LICENSE](LICENSE) doc.