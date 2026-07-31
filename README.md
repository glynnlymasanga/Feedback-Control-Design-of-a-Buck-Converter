# Feedback Control Design of a Buck Converter

<img width="979" height="311" alt="image" src="https://github.com/user-attachments/assets/37904e10-5e08-4503-8b4a-c8beecd382c0" />

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
Gvd(s) = 4.8x10^9 / (s² + 10³s + 2×10⁸)

Natural frequency:
ζ = 0.0354

## Controllers Evaluated

### Proportional (P)
- Design point: Kp = 0.042 (from |Kp·Gvd(jωc)|=1 at ωc=0.1ωn)
- Simple, but permanent non-zero steady-state error (T(0)<1 always)

### PI
- Design point: Kp = 0.0399, Ki = 16.9
- Integrator guarantees zero steady-state error unconditionally, for any Kp

### PID
- Design point: Kp = 0.0367, Ki = 11.97, Kd = 1.995e-5
- Also achieves zero steady-state error
- At this design's crossover, PID is not actually faster than PI (dominant pole −159.3 vs PI's −207.6) — its real, demonstrated advantage is stability robustness, not speed

### Feedforward + P
- Improved operating point accuracy
- No change in closed-loop dynamics

## Key Results at analytical controller gains 

| Controller | SS Error | Settling Time |
|------------|------------|---------------|
| Open Loop | 0.46V | ~8ms |
| P | 6.00V | ~8ms |
| PI | 0V | ~19.3ms |
| PID | 0V | ~25.1ms |

### The Central Finding: Phase Margin

A full-spectrum stability check (MATLAB margin() / allmargin(), not just a single-point magnitude calculation) reveals a result the pole locations alone don't show:
Controller | Worst-case Phase Margin (design point) |
P | 5.70° |
PI | 4.66° |
PID | 89.52° |

P and PI, despite having reasonable-looking closed-loop poles, are both very close to instability once the entire frequency response is checked — the plant's resonance peak creates an unintended second 0dB crossing that a single-frequency design check cannot see. PID is the only one of the three that is genuinely robust, because its derivative-driven phase lead persists far enough in frequency to rescue that unintended crossing — not because it's faster.

Checking the same three controllers with a much higher Kp (Kp=11, exploring the gain/steady-state-error tradeoff) makes this worse for P and PI (margin collapses to ~0.25°) while PID degrades only modestly (~23.8°) — though these particular high-gain crossovers land outside the averaged small-signal model's usual validity range (ωc < ωsw/10), a limitation discussed explicitly in the report.

### Best Result

PID Controller:

- Kp = 0.0367
- Ki = 11.97
- Kd = 1.995e-5

Performance:

- Zero steady-state error, all closed-loop poles real and stable (−159.3, −3,890, −92,735)
- Phase margin = 89.52° across every 0dB crossing, fully within the averaged model's valid frequency range (all crossings below ωsw/10)
- Tradeoff: slowest settling of the three controllers (~25 ms) — genuinely robust, not fast
## Repository Contents
report/ — full written report (derivation, all controller designs, PLECS results, stability analysis)
plecs/ — PLECS simulation models
matlab/ — Bode plot and stability margin analysis scripts

## Tools

- PLECS
- MATLAB
- Control Systems Theory and Small-Signal Modeling
- Frequency Response Analysis
