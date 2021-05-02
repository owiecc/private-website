---
layout: article
title:  Operational amplifier
excerpt: An operational amplifieris a high-gain electronic voltage amplifier with a differential input and a single-ended output.
author: Szymon Bęczkowski
category: electronics
tags: [components, basics]
---

An operational amplifier (often op-amp or opamp) is a DC-coupled high-gain electronic voltage amplifier with a differential input and, usually, a single-ended output <span class="marginnote">"Understanding Single-Ended, Pseudo-Differential and Fully-Differential ADC Inputs" Maxim Application Note 1108</span>. In this configuration, an op-amp produces an output potential (relative to circuit ground) that is typically hundreds of thousands of times larger than the potential difference between its input terminals. Operational amplifiers had their origins in analog computers, where they were used to perform mathematical operations in many linear, non-linear, and frequency-dependent circuits.

The popularity of the op-amp as a building block in analog circuits is due to its versatility. By using negative feedback, the characteristics of an op-amp circuit, its gain, input and output impedance, bandwidth etc. are determined by external components and have little dependence on temperature coefficients or engineering tolerance in the op-amp itself.

Op-amps are among the most widely used electronic devices today, being used in a vast array of consumer, industrial, and scientific devices. Many standard IC op-amps cost only a few cents in moderate production volume; however, some integrated or hybrid operational amplifiers with special performance specifications may cost over US$100 in small quantities. Op-amps may be packaged as components or used as elements of more complex integrated circuits.

The op-amp is one type of differential amplifier. Other types of differential amplifier include the fully differential amplifier (similar to the op-amp, but with two outputs), the instrumentation amplifier (usually built from three op-amps), the isolation amplifier (similar to the instrumentation amplifier, but with tolerance to common-mode voltages that would destroy an ordinary op-amp), and negative-feedback amplifier (usually built from one or more op-amps and a resistive feedback network).

## Operation

The amplifier's differential inputs consist of a non-inverting input (+) with voltage V+ and an inverting input (–) with voltage V−; ideally the op-amp amplifies only the difference in voltage between the two, which is called the differential input voltage. The output voltage of the op-amp Vout is given by the equation

/// equation here ///

where AOL is the open-loop gain of the amplifier (the term "open-loop" refers to the absence of a feedback loop from the output to the input).
