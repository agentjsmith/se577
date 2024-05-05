# ADR 005: Authentication 
Since the BBS will be a multi-user system, it is important to authenticate users
securely to prevent impersonation, vandalism, and theft of private data.  There
are several popular authentication methods that could apply in this case, each
with its own headaches.  We could adapt almost any to work with the SSHv2
protocol, but careful consideration must be given to the options.

## Decision 
We will use only native SSH Public Key authentication.

We will associate an SSH Public Key with an account by using Trust on First Use
(TOFU).  When an unknown key is presented to the login daemon, the user will be
placed into the new user sign-up flow.  Upon completion, the newly created user
account will be associated with the key used.

We will allow logged in users to add and remove public keys from their accounts.

## Rationale 

### Rejected: Password Authentication
Despite the fact that my calendar reports the year is 2024, password
authentication is still the most common and seen as the default method for most
services.  May our descendants forgive us!  Passwords come with the burden of
being:

    * Forgettable: requiring us to develop a password-recovery method
    * Guessable: requiring us to enforce annoying entropy requirements
    * Resuable: opening our users to password stuffing attacks
    * Difficult to type, especially given entropy requirements

With these only a few of the glaring deficiencies of password authentication, we
reject it as an option.

### Rejected: OAuth2 Authentication
OAuth2 would allow us to outsource responsibility for authenticating users to a
third party.  However, each user would always be tied to the third party that
the chose at sign up time.  In addition, the third parties we chose would have
the ability to cut us off from a large portion of our users on a whim.  We deem
this risk unacceptable and reject OAuth2 as an option.

### Chosen: Public Key Authentication
The SSHv2 protocol that we are using has native support for public key
authentication.  This method is widely used and widely known by our target
audience.  Many different clients on many different platforms support this
method.  We will use SSH Public Key Authentication as our sole method of user
authentication.  We will allow our users to add additional public keys to their
account and manage those once logged in.

## Status
Accepted

## Consequences
If a user loses access to their private SSH key, they will lose access to their
account.  This is partially mitigated by the ability to add additional public
keys to one's account.

If a user's physical device is stolen or compromised, the security of their BBS
account will be fully dependent on the quality of their key passphrase and other
security measures they have taken.  We will have no control over nor awareness
of such measures, other than suggesting good practices.  We are comfortable with
this.

Usernames do not have to be fixed at the time of account creation, since a
public key serves as both an identity and an authenticator.
