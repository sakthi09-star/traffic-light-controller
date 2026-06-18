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




