# Vending Machine FPGA Project

A vending machine implementation on FPGA using Verilog HDL. The system supports product selection, payment processing, change calculation, and inventory management.

## Project Structure

The project consists of 4 main Verilog modules:

### 1. `all_together.v` (Main Control Module)
Implements core vending machine logic.  
**Features**:
- Product selection and pricing  
- Payment processing  
- Change calculation  
- Inventory management  
- Display control  
- State machine-based control flow  

### 2. `smg4.v` (Seven-Segment Display Module)
Manages 8-digit seven-segment display.  
**Features**:
- Dynamic scanning display  
- Digit-to-segment conversion  
- Display refresh control  
- Timer-based scanning  

### 3. `key_filter4.v` (Key Debounce Module)
Handles button input processing.  
**Features**:
- Hardware debouncing for 6 buttons  
- 2ms stabilization delay  
- Clean signal output  
- Noise filtering  

### 4. `light4.v` (LED Control Module)
Controls LED indicators.  
**Features**:
- State-based LED patterns  
- LED flow effects  
- Timer-based blinking  
- System status indication  

## Hardware Requirements
- FPGA Development Board  
- 8-digit Seven-Segment Display  
- Push Buttons  
- LED Array  
- Clock Source  

## Pin Assignment
Pin assignments are defined in `all_together_ys.xdc` for:
- Clock  
- Reset  
- Buttons  
- LEDs  
- Seven-segment display  

## Authors
- **Xiang Guo**  
- **Shuxin Wang**  
