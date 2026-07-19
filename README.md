# AMBA APB Master/Slave Bus Protocol Implementation

A fully synthesizable, high-efficiency AMBA APB (Advanced Peripheral Bus) Master and Slave IP core implemented in Verilog HDL. This design accurately models the low-power, unpipelined synchronous bus protocol commonly used to connect low-bandwidth peripherals to the main system interconnect in modern SoC architectures.

## Key Technical Features
* **Standard FSM State Machine:** Implements strict APB protocol state transitions including `IDLE`, `SETUP`, and `ACCESS` phases.
* * **Parameterized Bus Widths:** Configurable address bus (`ADDR_WIDTH`) and data bus (`DATA_WIDTH`) to support flexible system integration.
* * **Robust Handshake Protocol:** Fully supports hardware handshaking signals including `PSEL`, `PENABLE`, `PWRITE`, `PWDATA`, `PRDATA`, and custom `PREADY` for wait-state insertion.
* * **Multi-Peripheral Control:** Complete decoding and selection logic built into the Master to independently drive multiple peripheral targets.
* * **Clean Timing Alignment:** Fully synchronous design with all control and data signals sampled on the rising edge of `PCLK`, guaranteeing zero combinational loops.
       
* ## Core Modules & Signals
* * **APB Master:** Initiates transfer cycles, controls address decoding, and manages strobe generation.
* * **APB Slave (Peripheral Interface):** Monitors selection lines, samples inputs during write cycles, and drives output data during read cycles based on memory mapping.
           
* ## Simulation & Verification
* * **HDL Language:** Verilog HDL
* * **Simulation Tool:** ModelSim SE
* * **Testbench Methodology:** Comprehensive behavioral testbench verifying continuous back-to-back write/read operations, random wait-state delays via `PREADY`, and error-case scenarios across multiple parameterized slave targets.
