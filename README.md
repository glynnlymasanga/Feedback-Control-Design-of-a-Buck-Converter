# Feedback Control Design of a Buck Converter

<img width="6952" height="3080" alt="schematic" src="https://github.com/user-attachments/assets/a83d84d5-9b56-40e9-9da1-3a73c0c1f0fc" />

## Project Summary

Designed and evaluated closed-loop voltage controllers for a 24 V → 12 V buck converter using small-signal modeling, PLECS switching simulation and MATLAB frequency-response analysis.

The project included:

- State-space averaging
- Control-to-output transfer function derivation
- P, PI, PID and Feedforward-P controller design and tuning
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
\[
G_{vd}(s)=\frac{4.8\times10^9}{s^2+1000s+2\times10^8}
\]
Resulting system parameters:

| Parameter | Value |
|-----------|------:|
| Natural Frequency | 14,142 rad/s |
| Damping Ratio | 0.0354 |
| System Order | Second Order |


## Controllers Evaluated

### Proportional (P)
- Initial analytical controller gains: Kp = 0.042 (from |Kp·Gvd(jωc)|=1 at ωc=0.1ωn)
- Simple, but permanent non-zero steady-state error (T(0)<1 always)

### PI
- Initial analytical controller gains: Kp = 0.0399, Ki = 16.9
- For the ideal averaged model, integrator guarantees zero steady-state error unconditionally, for any Kp

### PID
- Initial analytical controller gains: Kp = 0.0367, Ki = 11.97, Kd = 1.995e-5
- Also achieves zero steady-state error
- At this design's crossover, PID is not actually faster than PI (dominant pole −159.3 vs PI's −207.6) — its real, demonstrated advantage is stability robustness, not speed

### Feedforward + P
- Improved operating point accuracy
- No change in closed-loop dynamics

## Key Results at analytical controller gains 

| Controller | SS Error | Settling Time | Worst-case Phase Margin (design point) |
|------------|------------|---------------|----------|
| Open Loop | 0.46V | ~8ms | - |
| P | 6.00V | ~8ms | 5.70° |
| PI | 0V | ~19.3ms | 4.66° |
| PID | 0V | ~25.1ms | 89.52° |

### The Central Finding: Phase Margin

<img width="1029" height="1148" alt="image" src="https://github.com/user-attachments/assets/7a5f2515-cdfd-49ef-8118-7c9fafd3b469" />

A full-spectrum stability check (MATLAB margin() / allmargin(), not just a single-point magnitude calculation) reveals a result the pole locations alone don't show:

P and PI, despite having reasonable-looking closed-loop poles, are both very close to instability once the entire frequency response is checked — the plant's resonance peak creates an unintended second 0dB crossing that a single-frequency design check cannot see. PID is the only one of the three that is genuinely robust, because its derivative-driven phase lead persists far enough in frequency to rescue that unintended crossing — not because it's faster.

Checking the same three controllers with a much higher Kp (Kp=11, exploring the gain/steady-state-error tradeoff) makes this worse for P and PI (margin collapses to ~0.25°) while PID degrades only modestly (~23.8°) — though these particular high-gain crossovers land outside the averaged small-signal model's usual validity range (ωc < ωsw/10), a limitation discussed explicitly in the report.

### Best Result

Among the analytical controller designs, the PID controller achieved the largest phase margin (89.5°) while maintaining zero steady-state error, demonstrating the best robustness to resonance-induced crossover effects.

PID Controller:

- Kp = 0.0367
- Ki = 11.97
- Kd = 1.995e-5

Performance:

- Zero steady-state error, all closed-loop poles real and stable (−159.3, −3,890, −92,735)
- Phase margin = 89.52° across every 0dB crossing, fully within the averaged model's valid frequency range (all crossings below ωsw/10)
- Tradeoff: slowest settling of the three controllers (~25 ms) — genuinely robust, not fast

## Repository Structure

```text
Feedback-Control-of-a-Buck-Converter/
│
├── simulations/
│   ├── matlab/
|   |   └── BodePlotFeedbackControl.m
│   │
│   └── plecs/
│       └── BuckConverterFeedbackControl.plecs
│
├── docs/
│   └── FeedbackConrolOfABuck.pdf
│
├── images/
│   ├── bodeplot.jpg
│   ├── loadstep.jpg
│   └── linestep.jpg
│
└── README.md
```
## Tools

- PLECS
- MATLAB
- Control Systems Theory and Small-Signal Modeling
- Frequency Response Analysis
