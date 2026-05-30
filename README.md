# FPGA Password Lock System V3

## Overview

FPGA Password Lock System V3 is a digital access control system implemented on the Intel MAX10 DE10-Lite FPGA development board. The project uses a Finite State Machine (FSM) to manage password creation, password verification, lockout timing, and user feedback.

Version 3 focuses on improving hardware reliability through proper button debouncing, one-clock-cycle input pulses, failed-attempt tracking, and lockout delay management.

---

## Features

* User-configurable 4-bit password
* Password verification using a Finite State Machine (FSM)
* Debounced push-button input
* Single-clock enter pulse generation
* Failed-attempt counter
* Variable lockout delay after incorrect attempts
* Seven-segment display output
* LED state indication
* Active-low reset support
* Modular Verilog design

---

## Hardware Platform

**Board:** Intel MAX10 DE10-Lite

**Clock Frequency:** 50 MHz

**Language:** Verilog HDL

**Development Environment:** Intel Quartus Prime Lite

---

## Resource Utilization

The following results were obtained from Intel Quartus Prime Lite after synthesizing the design for the Intel MAX10 DE10-Lite FPGA (10M50DAF484C7G).

| Resource | Usage |
|-----------|--------|
| Logic Elements (LEs) | 209 / 49,760 (< 1%) |
| Registers | 89 |
| I/O Pins | 31 / 360 (9%) |
| Memory Bits | 0 / 1,677,312 (0%) |
| Embedded 9-bit Multipliers | 4 / 288 (1%) |
| PLLs | 0 / 4 (0%) |

### Design Notes

The design uses less than 1% of the available logic resources on the MAX10 FPGA, leaving significant room for future expansion. Planned V4 features such as a solenoid driver, PWM-based power management, display interfaces, and additional security features can be added without significant resource constraints.

## FSM States

| State   | Description                                   |
| ------- | --------------------------------------------- |
| S_IDLE  | Waiting for user interaction                  |
| S_SET   | Set a new password                            |
| S_INPUT | Enter password attempt                        |
| S_CHK   | Compare entered password with stored password |
| S_BLK   | Access denied and lockout active              |
| S_UNBLK | Access granted                                |

---

## Inputs

| Signal  | Description      |
| ------- | ---------------- |
| KEY[0]  | Active-low reset |
| KEY[1]  | Enter button     |
| SW[3:0] | Password input   |
| SW[9]   | Mode select      |

### Mode Select

| SW[9] | Mode                        |
| ----- | --------------------------- |
| 0     | Password Entry Mode         |
| 1     | Password Configuration Mode |

---

## Outputs

| Signal  | Description            |
| ------- | ---------------------- |
| LEDR[0] | S_IDLE                 |
| LEDR[1] | S_SET                  |
| LEDR[2] | S_INPUT                |
| LEDR[3] | S_CHK                  |
| LEDR[8] | S_BLK                  |
| LEDR[9] | S_UNBLK                |
| HEX0    | Failed-attempt display |

---

## Module Structure

### password_lock_top.v

Top-level integration module.

Responsibilities:

* FPGA I/O mapping
* Module integration
* Clock and reset distribution

### password_fsm.v

Main control FSM.

Responsibilities:

* Password storage
* Password verification
* Lockout handling
* Failed-attempt management

### debounce.v

Button debounce module.

Responsibilities:

* Samples button input every 20 ms
* Removes switch bounce
* Generates a single-clock pulse on button press

### count_down.v

Variable lockout timer.

Responsibilities:

* Generates lockout delays
* Increases delay duration based on failed attempts

### hexdisplay.v

Seven-segment display driver.

Responsibilities:

* Displays failed-attempt count

---

## Project Structure

```text
FPGA-Password-Lock-V3/
├── src/
│   ├── password_lock_top.v
│   ├── password_fsm.v
│   ├── count_down.v
│   ├── debounce.v
│   └── hexdisplay.v
├── tb/
│   └── password_fsm_tb.v
├── README.md
```

---

## Version Improvements

### V1
https://github.com/DarkCyril/FPGA-Password-Lock-V1
* Initial password lock implementation
* Basic FSM functionality

### V2
https://github.com/DarkCyril/FPGA-Password-Lock-V2
* Modularized project architecture
* Improved code organization

### V3

* Added hardware button debouncing
* Added one-clock-cycle enter pulse generation
* Added failed-attempt counter
* Added variable lockout timer
* Added seven-segment display support
* Improved hardware stability on FPGA

---

## Future Development (V4)

The next version of the project will transition from a simulated lock system to a physical electronic locking mechanism.

### Planned Features

#### Solenoid-Based Door Lock

A high-current solenoid lock will be controlled using FPGA-generated control signals and an external driver circuit.

#### PWM Hold-Power Control

Traditional solenoids consume significant power when continuously energized. V4 will implement Pulse Width Modulation (PWM) to reduce power consumption after the lock has actuated.

Proposed operation:

1. Apply 100% duty cycle briefly to actuate the solenoid.
2. Transition to a lower-duty-cycle PWM hold state.
3. Maintain lock position while significantly reducing power consumption and heat generation.
4. Release power completely when the unlock timer expires.

Benefits:

* Reduced power consumption
* Lower heat generation
* Increased solenoid lifespan
* Improved overall system efficiency

#### Additional Enhancements

* MOSFET-based solenoid driver circuit
* Flyback diode protection
* Multi-digit password support
* LCD/OLED status display
* UART debugging interface

---

## Author

Juan Colon

California State University, Los Angeles

