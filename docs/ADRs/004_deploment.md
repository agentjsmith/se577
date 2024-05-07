# ADR 004: Deployment
As the BBS will be composed of multiple services working together, we must
consider carefully how those services will be deployed.  There are many possible
deployment styles to choose from, ranging from bare metal in racks to
fully-managed SaaS.  We must take into consideration 

## Decision 
We will use the Kubernetes API to orchestrate our services.

We will deploy to the public cloud that gives us the cheapest managed
Kubernetes environment.

## Rationale 

### Chosen: Kubernetes API
Using the Kubernetes API allows us maximum **Flexibility** by decoupling our
software from the environment that it will be living in.  This also makes
migration in the future much easier if our requirements change.

### Rejected: Bare Metal
Do you know how long the backorder is for server-class hardware right now?
Depending on long-term capacity planning and racking more servers to scale,
would prevent us from reaching our **Flexibility** or **Scalability** goals.
Paying for hardware 24x7 that will not be in use at first runs afoul of our
**Low Run Cost** goal.  If we need to experience the "new compute" smell, we will
have to go sniff the towers at Microcenter, because we will not be ordering any.

### Rejected: Internal Cloud
The internal cloud is a lot like Taco Bell.  It can fill you up cheaply, and
tastes pretty good when you are drunk, but it is no substitute for the real
thing. While it is much more flexible and programmable than bare metal, we must also
reject the use of our internal cloud for this project.  The internal cloud can
not provide the instant and infinite scalability that the public cloud can.  The
medium-term planning process involved is still too slow to provide the
**Flexibility**, **Scalability**, and **Low Run Cost** that a new product needs.

### Chosen: Public Cloud
All major public cloud providers will give us the **Flexibility** and
**Scalability** we need.  Since we will pay only for the compute that we are
using, we can achieve a **Low Run Cost** much more easily.  Letting a cloud
provider manage the Kubernetes environment makes the system more **Operable** by
letting us focus on our own code.

## Status
Accepted

## Consequences
We will be able to chase the cloud provider that can provide the lowest price,
so our **Low Run Cost** objective is more reachable.

We will have to carefully monitor our cloud spend to maintain **Low Run Cost**.

We will have the **Flexibility** to deploy test environments locally or on the internal cloud
if necessary.  This will improve the **Debuggability** and **Supportability** of
the system.

The Kubernetes API can be complicated and we will need to set aside time to
educate our developers and set up their development tools.
