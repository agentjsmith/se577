## Introduction

For this project, I chose to design a Bulletin Board System (BBS).  In the 80's
and 90's, dial-up BBSes were the primary way to meet and communicate with other
local geeks.  The rise of the Internet, and especially the World Wide Web, made
connectivity accessible and useful to the average person, but in my opinion, the
magic was lost.  Now that the Web is choking to death on its own nonsense, the
time is right for geeks to return to the BBS.

The main non-functional requirements of the system are:

  * **Security** is the single biggest concern in this system.  Users must not
    be able to affect each other in any way that is not designed.  There is
    reason to suspect that our target users will try to do so anyway.
  * **Low Run Cost** (also known as **Affordability**) is a close second.  This
    system is intended to be funded by optional donations, which means that it
    must be dirt cheap to run.
  * **Responsiveness** is important to usability.  Though many of our users will
    remember waiting for art-heavy screens to slowly trickle through their slow
    modems, this is a bit of nostalgia that we are aiming to avoid entirely.
  * **Extensibility** (also known as **Flexibility**) will allow us to explore
    what a BBS can offer now with modern resources.  The ability to quickly
    implement new functionality enables experimentation with low overhead.
  * **Operability** is the final non-functional requirement.  Related to **Low
    Run Cost**, the time required to run the system should be as low as we can
    possibly make it.

Notice that **Availability** is not on the list.  **Availability** is often a
direct tradeoff with **Low Run Cost**, which is so important in this case that
cost concerns strictly dominate those of **Availability**.  In the event of an
outage, we will encourage our loyal users to go outside for a while.

## Overview

![](embed:Context)

At the highest level, our system integrates with a payment service, for
processing user donations, as well as an external document store for persistent
state.  All state is stored in one place to improve the **Operability** of the
system.  As helpful as it might seem to use specialized storage for some use
case, that decision comes with a lifetime of upgrades, migrations, backups, and
other toil that make the system as a whole more difficult to operate.

Normal users, referred to here as "Big Nerds" in reference to the social status
of our target demographic, are considered separately from Sysops (System
Operators--the traditional title for one who runs a BBS).  This improves the
**Security** of the system by vastly reducing the attack surface available for
potential attackers.  We expect our users to be both highly technical and bored,
so **Security** is a primary concern.

## Deployment Units

![](embed:Container)

### WebAssembly Bridge

The most interesting part of the BBS's architecture is that most of the
traditional features are implemented as WebAssembly Components.  This is a win
for both **Security** and **Extensibility**.  The WebAssembly Bridge acts as a
host for these components and provides them with the services they need to
interact with users and persist data.

![](embed:WASMBridgeComponents)

While only a handful of functions are shown for readability, the possibilities
are endless.  With the **Security** guarantees and near-native performance of
WebAssembly (**Responsiveness**), most of the functionality of the BBS can be
implemented this way, and BBS owners can trade their favorite (hopefully Free and Open Source) in-house modules.  The efficiency also directly leads to **Low Run Cost** as we can run more functionality on fewer resources.

Other components shown are developed natively where WebAssembly is not a good
option.  For example, the Donation flow needs to run in a separate process
because it handles payment data.  The other native service is the Door Game
server.

### Door Game Server

Most people who enjoyed dialing into BBSes in their heyday remember the
impressive array of games available.  Those BBSes were primarily DOS-powered,
but thanks to powerful, modern hardware, we can easily and cheaply (**Low Run
Cost**) emulate a DOS environment to bring them back to life.

![](embed:DoorComponents)

We need to develop an I/O adapter to interface the old screen-based UIs with our
front-end APIs.  In further pursuit of **Low Run Cost**, emulators will be
shut down when not in active use, with their state persisted to the Document
Store.  **Security** is taken care of because the environments are entirely
emulated, so no dormant DOS viruses will make a comeback on our watch.

### Frontend

The Frontend service is the only service that directly interacts with users.

![](embed:FEComponents)

The Bouncer maintains **Security** at the door by authenticating users and
checking that their access is consistent with policy.  For example, policies
could specify how long each user was allowed to log in each day.

The dynamic Menu service keeps track of what users can run at any given time.
This allows new functions to be added instantly, and vastly improves
**Operability** by allowing functions to be taken offline temporarily.  By
versioning functions, it is even possible to upgrade a function that it in use
without disconnecting its users.

## Conclusion

Hopefully this walkthrough of the architectural high points of the BBS allowed
you to see the interesting possibilities and how they can be achieved.
