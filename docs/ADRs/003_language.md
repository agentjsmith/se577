# ADR 003: Language Choices
Arguably, the exact choice of programming language for each component is not an
architectural decision.  However, we must filter the list of candidate languages
in order to ensure the system achieves its goals of **Security**, **Low Run
Cost**, and **Extensibility**.

## Decision 
To meet all of these intersecting needs, we will write all core system components in
Rust.

Small utilities and services outside the critical path may use the Best Tool Available, in
cases that Rust may not be suitable.

## Rationale 

### Security
In order to meet our goal of **Security**, only memory-safe languages may be
considered.

### Extensibility
To make sure that our components can be extended using WebAssembly Components
(see also ADR 004), components that can be extended, must be developed in a
language with a mature and supported method of embedding WebAssembly Components. 

Any extensions to components must be developed in a language with a mature and
supported method of being compiled to a WebAssembly Component.

### Low Run Costs
To keep the costs of running the system low, all components that need to scale
must be written in a language that can be compiled to native code.

### Chosen: Rust

The only language that supports all of these requirements as of today is Rust.

## Status
Proposed

## Consequences
The Go fans on the team will not talk to me for at least a week.  Whenever
choosing a language, somebody will be angry that their favorite is not on the
list.  However, Rust is commonly voted the "Most Loved" language in the Stack
Overflow survey, so we hope that they will come to enjoy it.

There are not as many programmers with experience in Rust as there are in
some other languages.  It also takes much longer to learn than some of the other
alternatives.  However, we are willing to accept this tradeoff to
improve the system's quality.
