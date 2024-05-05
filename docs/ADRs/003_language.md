# ADR 003: Language Choices
Arguably, the exact choice of programming language for each component is not an
architectural decision.  However, we must filter the list of candidate languages
in order to ensure the system achieves its goals of **Security**, **Low Run
Cost**, and **Extensibility**.

## Decision 
To meet all of these intersecting needs, we will write all system components in
Rust.

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

### Rejected: Multiple Languages

Two languages as of now fit the bill: Go and Rust.

Many programmers only like one of Go or Rust.  The languages have quite
different priorities and values, some of which prove controversial. Leaving both
options open may lead to wasting a lot of time in arguments.  In addition, if
team members are only comfortable with one language, they may only be able to
work on half of the system, which would wreck our efficiency.

### Chosen: Go

Thus, finding programmers with experience in both languages would be too
difficult and we must arbitrarily pick one.  Since the system will be
interacting with many users simultaneously, we will choose Go because of its
superior concurrency support.

## Status
Proposed

## Consequences
Whenever choosing a language, somebody will be angry that their favorite is not
on the list.

There are not as many programmers with experience in Go as there are in
some other languages.  However, we are willing to accept this tradeoff to
improve the system's quality.

Go is slightly less efficient with memory allocation and runtime size than Rust.
This will negatively impact our **Low Run Cost**.  However, the ease of learning
Go vs. Rust should offset this additional cost by improving our time to market.
