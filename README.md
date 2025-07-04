# 5-STAGE-PIPELINED-MIPS-PROCESSOR-WITH-CUSTOM-DATA-FORWARD-UNIT



This project implements a **5-stage pipelined MIPS processor** using **Verilog HDL** and simulates it for functional verification. It includes a **custom data forwarding unit** to resolve data hazards, improve instruction throughput, and maintain pipeline efficiency. The design is verified through comprehensive simulation using testbench inputs and waveform analysis.

---

## 📌 Overview

The design follows the standard MIPS pipeline architecture with the following stages:

1. **IF (Instruction Fetch)**
2. **ID (Instruction Decode & Register Fetch)**
3. **EX (Execute/ALU Operations)**
4. **MEM (Memory Access)**
5. **WB (Write Back)**

To handle data hazards caused by instruction dependencies, a **custom forwarding unit** is added. This reduces the number of stalls caused by RAW (Read After Write) hazards and improves overall performance.

---

## 🧠 Key Features

- Modular Verilog design for each pipeline stage
- Implements core MIPS instructions (R-type, I-type, load, store, branch)
- **Hazard detection unit** to identify load-use conditions
- **Data forwarding unit** to reduce execution delays
- Instruction-level simulation using `testbench.v`

---

## 📁 Project Structure

| File/Module        | Description                                     |
|--------------------|-------------------------------------------------|
| `top.v`            | Top module integrating all 5 stages             |
| `alu.v`            | ALU for arithmetic and logic operations         |
| `control_unit.v`   | Control signal generation for pipeline stages   |
| `hazard_unit.v`    | Detects data hazards and controls stalls        |
| `forward_unit.v`   | Implements custom data forwarding logic         |
| `register_file.v`  | 32-register general purpose storage             |
| `instr_mem.v`      | Instruction memory (hardcoded test programs)    |
| `data_mem.v`       | Memory used for lw/sw instructions              |
| `testbench.v`      | Simulation testbench for verifying functionality|
| `waveform.png`     | Output waveform from simulation                 |
| `schematic.png`    | RTL schematic of processor architecture         |

---

## 🔁 Pipeline Flow

### Stages
- **IF**: Fetch instruction from instruction memory
- **ID**: Decode instruction, read operands from register file
- **EX**: Perform ALU operation or branch calculation
- **MEM**: Access data memory (load/store)
- **WB**: Write result back to register file

![FINAL_MIPS](https://github.com/user-attachments/assets/0f29517d-3768-4587-8a4a-3fc67de1150b)


### Custom Forwarding
- Resolves data hazards between EX, MEM, WB stages
- Avoids unnecessary stalls by forwarding operand values directly
- Hazard Unit still controls pipeline flush or stall during load-use cases

---

## 🧪 Simulation and Testing

- Test programs are written in MIPS assembly and converted to binary (hex) format
- Instructions are loaded into `instr_mem.v`
- `testbench.v` runs the processor with realistic instruction sequences
- Output verified using **Vivado Simulator**
- Results validated via `waveform.png` and internal signal traces

---

## 🛠 Tools Used

- **Vivado Simulator** (for waveform)
- **Verilog HDL**

---

## 📷 Diagrams

### 🔧 RTL Schematic
<img width="958" alt="SCHEMATIC" src="https://github.com/user-attachments/assets/808cfda6-3420-4872-b058-21a775875375" />


### 📈 Sample Output Waveform

<img width="946" alt="OUTPUT_WAVEFORM_1" src="https://github.com/user-attachments/assets/990cb98c-5d5e-4e66-92dd-4a40b4f6b32b" />


<img width="960" alt="OUTPUT_WAVEFORM_2" src="https://github.com/user-attachments/assets/69dc4690-8a79-4ac0-82da-e45258275e5e" />


<img width="949" alt="OUTPUT_WAVEFORM_3" src="https://github.com/user-attachments/assets/28eb3b8c-0e03-4a04-b875-a012a537abc2" />


<img width="960" alt="OUTPUT_WAVEFORM_4" src="https://github.com/user-attachments/assets/704c368c-1556-40e1-81fe-4e1728e90ef5" />


---

## ✅ Future Enhancements

- Branch prediction logic for reducing control hazards
- Integration with cache memory for realistic performance evaluation
- Support for multiplication, division, and syscall operations

---

## 👩‍💻 Author

- **Harshitha A**  
  Developed by HARSHITHA ARUNACHALA Undergraduate Student, B.E. Electronics and Communication Engineering (ECE)
  GitHub: [@HARSHITHA292003](https://github.com/HARSHITHA292003)

---

