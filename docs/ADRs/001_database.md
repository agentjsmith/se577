# ADR 001: State Storage 
There are a huge number of data storage methods in the world.  The choice of
which to use has an early and large impact on the rest of the system.  Our
primary goals are **Flexibility**, **Security**, **Responsiveness** and **Low Run Cost**, so we
must use those factors to reduce the search space.

## Decision 
We will use the managed document storage platform of whichever public cloud
provider is cheapest (see ADR 004 for more discussion of cloud issues).

## Rationale 
### Rejected: Self-hosting data storage 
We do not have the time or expertise to host the data storage, backup solutions,
disaster recovery, and so on.  Hiring a DBA at this stage would be extremely
premature and would compromise our goal of **Low Run Cost**.  Therefore we
eliminate any self-managed data storage platform at this time.

### Rejected: Relational DBMS
Our goal of **Flexibility** requires that new components can come online with a
minimum of fuss.  A pre-defined schema would become a bottleneck for change in
the system.

An RDBMS would also compromise our **Responsiveness** goal, because the shared
resources and locking will cause disparate parts of the system to become
synchronous, even where that is not intended.  A central RDBMS is where
beautiful architectural dreams go to die at the hands of resource contention.

### Rejected: Storage Bingo
One possible solution is to allow each component to use the data storage method
that works best for it.  This would be a boon to our **Flexibility** and
**Responsiveness**.  I call this approach Storage Bingo because one ends up
installing every database they've ever heard of, and sometimes a few new ones.
This is a serious detriment to the **Operability** of the system, not to mention
the **Mental Health** of its operators, and the redundancy also works against
**Low Run Cost**.

### Chosen: Central Document Store
All major public cloud providers offer a managed document storage service.
These are cheap enough and provide all of the amenities that one would expect.
Though centralizing the data storage is not ideal, and some components may be
more difficult to implement, life is unfair.

## Status
Accepted

## Consequences
Without a schema, it is up to our discipline and tooling to ensure the data does
not turn into a huge mess.

The indexing and searching options of managed document stores are often less
robust than what an RDBMS could provide.

Centralizing data storage means that a breach in one component could potentially
compromise the data of all components, leading to a worse **Security** posture.
Access controls must be carefully applied.
