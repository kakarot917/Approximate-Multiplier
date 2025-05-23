# 4x4 Approximate Multiplier

## Overview

This project implements a 4x4-bit **approximate multiplier** in Verilog, designed to reduce hardware area and power consumption while maintaining high computational accuracy (Mean Relative Error, MRE < 15%). The design is suited for error-tolerant applications such as image processing and neural networks.

A testbench is provided to evaluate the mean relative error (MRE) across all possible input combinations.

---

## Approximation Technique

The multiplier uses a hybrid approach:

- **Lower-part OR Adder (LOA):**  
  The two least significant output bits are generated using OR gates instead of full adders. This reduces logic complexity and power consumption with minimal impact on overall accuracy.

- **Segmented Accurate Addition:**  
  For more significant bits, a segmented accurate adder is used. This balances the trade-off between accuracy and hardware savings.

- **No Carry Propagation from LSBs:**  
  Carries from the lower bits are not propagated to higher bits, further simplifying the design and reducing power.

This combination is inspired by techniques such as BIC/LOA and speculative adders, as discussed in recent literature on approximate arithmetic circuits.

---

## Files

- `approx_mult4x4.v`  
  Verilog module implementing the 4x4 approximate multiplier.

- `multiplier_tb.v`  
  Testbench that exhaustively tests all input combinations and computes the mean relative error (MRE).

- `eda_playground_log.txt`  
  Output log from EDA Playground, showing simulation results and MRE.

---

## How It Works

1. **Multiplier Module:**  
   - Inputs: 4-bit operands `A` and `B`
   - Output: 8-bit approximate product `result`
   - Uses a mix of OR logic and accurate addition for different output bits.

2. **Testbench:**  
   - Loops through all 256 combinations of A and B.
   - Compares the approximate result to the exact product.
   - Calculates and prints the mean relative error (MRE).

---

## Power and Utilization Information

**Note:**  
Due to the limitations of using a Mac and the online EDA Playground environment, **power consumption and FPGA resource utilization (LUTs, IOBs, etc.) could not be measured directly**. These metrics typically require FPGA vendor tools such as Xilinx Vivado or Intel Quartus, which are not natively supported on macOS and are not available on EDA Playground.

- **Why not available?**
  - EDA Playground supports simulation only, not synthesis or implementation.
  - Power and utilization reports require mapping the design to a specific FPGA device, which is not possible in this setup.

**What is provided instead:**  
- The attached `eda_playground_log.txt` contains simulation results and the computed mean relative error, demonstrating the functional correctness and approximation quality of the design.


