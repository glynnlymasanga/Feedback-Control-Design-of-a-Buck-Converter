# Feedback Control Design of a Buck Converter

<img width="979" height="311" alt="image" src="https://github.com/user-attachments/assets/37904e10-5e08-4503-8b4a-c8beecd382c0" />

## Project Summary

Designed and evaluated closed-loop voltage controllers for a 24 V → 12 V buck converter using small-signal modeling and PLECS simulation.

The project included:

- State-space averaging
- Control-to-output transfer function derivation
- P, PI, PID and Feedforward-P controller design
- Pole and stability analysis
- Bode plot analysis
- Load and line disturbance testing

## Converter Specifications

| Parameter | Value |
|------------|---------|
| Input Voltage | 24 V |
| Output Voltage | 12 V |
| Switching Frequency | 200 kHz |
| Inductor | 50 µH |
| Capacitor | 100 µF |
| Load | 10 Ω |

## Plant Model

Small-signal control-to-output transfer function:
Gvd(s) = 10^8 / (s² + 10³s + 2×10⁸)

Natural frequency:
ζ = 0.035

## Controllers Evaluated

### Proportional (P)
- Simple implementation
- Reduced error
- Non-zero steady-state error

### PI
- Zero steady-state error
- Improved disturbance rejection

### PID
- Fastest response
- Best transient performance
- Highest bandwidth

### Feedforward + P
- Improved operating point accuracy
- No change in closed-loop dynamics

## Key Results

| Controller | SS Error | Settling Time |
|------------|------------|---------------|
| Open Loop | High | 5–6 ms |
| P | Reduced | < 1 ms |
| PI | Zero | ~1.7 ms |
| PID | Zero | < 1 ms |

### Best Result

PID Controller:

- Kp = 1.76
- Ki = 575
- Kd = 0.00096

Performance:

- Zero steady-state error
- <1 ms settling time
- Strong load and line regulation

## Tools

- PLECS
- MATLAB
- Control Systems Theory
- Small-Signal Modeling
- Frequency Response Analysis
