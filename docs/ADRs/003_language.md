# ADR 003: Language Choices
Arguably, the exact choice of programming language for each component is not an
architectural decision.  However, we must filter the list of candidate languages
in order to ensure the system achieves its goals of **Security**, **Low Run
Cost**, and **Extensibility**.

## Decision 
To meet all of these intersecting needs, we will write all core system components in
Go or Rust.

We will write components that are expected to be extensible, as well as the extensions, in Rust.

Small utilities and services outside the critical path may use the Best Tool Available, in
cases that Rust may not be suitable.

## Rationale 

### Security
In order to meet our goal of **Security**, only memory-safe languages may be
considered.

### Low Run Costs
To keep the costs of running the system low, all components that need to scale
must be written in a language that can be compiled to native code.

### Chosen: Go
Go is memory safe and compiles to native code.  All that it is missing for full approval is a mature and supported WebAssembly integration.  It is appropriate to use for all components that do not integrate with WebAssembly. 

### Chosen: Rust for Extension
To make sure that our components can be extended using WebAssembly Components, system components that can be extended, must be developed in a
language with a mature and supported method of embedding WebAssembly Components. 

Any extensions to components must be developed in a language with a mature and
supported method of being compiled to a WebAssembly Component.

The only language that supports these requirements as of today, while being memory safe and compiling to native code, is Rust.

## Status
Proposed

## Consequences
Whenever
choosing a language, somebody will be angry that their favorite is not on the
list.  However, Go and Rust are both popular languages, and are different enough to leave room for choice.

There are not as many programmers with experience in Rust as there are in
some other languages.  It also takes much longer to learn than some of the other
alternatives.  However, we are willing to accept this tradeoff to
improve the system's quality.

Using Go where extensibility is not required will mitigate this.  The learning curve for Go is much more friendly and programmers can become productive in it quickly.  We anticipate that most components will not involve WebAssembly, so the majority of the team will have the option to work in Go.

The interoperability between Go and Rust, while not perfect, is operable and sufficient to our purposes.  Most integration will be by inter-process communication, but we can link them together in a single binary if needed.

## Follow Up

The WebAssembly Components ecosystem is under active and rapid development.  As soon as an implementation for Go is mature and supported, this ADR should be updated to allow Go for all system components.
