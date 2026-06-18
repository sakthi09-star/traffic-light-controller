# traffic-light-controller
This project implements a Finite State Machine (FSM)-based Traffic Light Controller using Verilog HDL. The design simulates a realistic two-road traffic system (North-South and East-West) with proper timing control for green, yellow, and red lights.

## 📌 Project Overview

The system controls traffic lights for two directions:
   North–South (NS)
  East–West (EW)

Only one direction is allowed to move at a time while the other remains stopped. The controller cycles through states in a timed sequence using a clock-driven FSM.



## ⚙️ Features

- FSM-based design (Moore model)
- Synchronous reset support
- Clock-driven state transitions
- Separate Red, Yellow, Green outputs for both directions
- Simulation-friendly Verilog design (Icarus Verilog compatible)
- Waveform generation using VCD dump



## 🧠 FSM Working Principle

The controller cycles through states such as:
- NS Green / EW Red
- NS Yellow / EW Red
- NS Red / EW Green
- NS Red / EW Yellow

Each state is held for a fixed number of clock cycles before transitioning to the next state.

Block Diagram
          ┌──────────────┐
          │  NS GREEN    │
          │  EW RED      │
          └──────┬───────┘
                 │ (counter done)
                 ▼
          ┌──────────────┐
          │  NS YELLOW   │
          │  EW RED      │
          └──────┬───────┘
                 │ (counter done)
                 ▼
          ┌──────────────┐
          │  EW GREEN    │
          │  NS RED      │
          └──────┬───────┘
                 │ (counter done)
                 ▼
          ┌──────────────┐
          │  EW YELLOW   │
          │  NS RED      │
          └──────┬───────┘
                 │ (counter done)
                 ▼
          ┌──────────────┐
          │  NS GREEN    │
          │  EW RED      │
          └──────────────┘
🔹 Design Architecture
1. Moore FSM (Finite State Machine)

This project is designed using a Moore Finite State Machine, where the outputs depend only on the current state and not directly on the inputs.

Each state represents a specific traffic signal condition:

NS Green / EW Red
NS Yellow / EW Red
EW Green / NS Red
EW Yellow / NS Red

In a Moore FSM:

Outputs are generated based on the current state only
State transitions occur on the clock edge
Outputs remain stable within each state, avoiding glitches

This makes the design reliable and suitable for real-world traffic control systems.

2. State Encoding

The FSM states are represented using a binary encoding scheme stored in a state register.

Typical encoding used:

State	Encoding
NS Green	00
NS Yellow	01
EW Green	10
EW Yellow	11

The state register updates on every positive clock edge based on the next-state logic.

3. Timing Method (Counter-Based Design)

State transitions are controlled using a synchronous counter.

Working:

A counter increments on every clock cycle
Each state is held for a fixed number of clock cycles
When the counter reaches a predefined limit:
Counter resets to zero
FSM transitions to the next state

This ensures accurate timing control for each traffic signal phase.

Advantages:

Precise timing control
Fully synchronous design
Easy to modify signal durations by changing counter values
🔁 Overall System Flow

Clock → Counter → FSM State Register → Output Logic (NS/EW Signals)




