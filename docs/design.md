# Traffic Light Controller — Design

## Overview

A digital traffic light controller designed in Verilog HDL for two traffic lights
at an intersection.

## Design

The controller is based on a finite-state machine (FSM) with a separate timing
module. It supports Standby and Regular operating modes and controls the traffic
light sequence according to the project specification.

## Architecture

The design consists of two main modules:

- **FSM** — controls the traffic light states and transitions.
- **Timer** — handles the required timing for each state.

The modules are designed separately to keep state control and timing logic
independent.

## Status

Work in progress.