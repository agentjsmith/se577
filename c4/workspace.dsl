workspace "GeekBBS" {

    model {
        # Cast of Characters
        user = person "Big Nerd" "The primary users of the BBS will be giant nerds."
        sysop = person "System Operator" "Maintain and operate the BBS"

        # External Systems
        paymentSvc = softwareSystem "Payment Service" "Processes donation payments." "Existing System"

        docDBSvc = softwareSystem "Document Store" "Stores all persistent state." "Existing System,Database"

        bbs = softwareSystem "BBS" "A Bulletin Board System, similar in functionality to those that dominated the online world in the '80s and '90s, but with modern architecture and performance" {
            fe = container "Front End" "The part of the system responsible for user interaction"{
                mux  = component "Multiplexer" "Handles user SSH sessions and performs input and output on behalf of other system components"
                bouncer = component "Bouncer" "Checks ID at the door and enforces policy"
                menu = component "Menu" "Provides a menu of all functions that are currently available.  Functions are versioned for hot upgrade."

                mux -> bouncer "Authenticates and Authorizes Users Sessions with"
            }   

            auth =     container "Authenticator" "Identifies and Valiadates users from their SSH keys"
            wasmbridge = container "WebAssembly Bridge" {
                wasmIO = component "Screen I/O Component" "A WASM Component that provides input and output from user sessions"
                wasmStorage = component "Storage Component" "A WASM Component that provides persistent key/value storage"
                wasmHost = component "WASM Host" "The main process in which all the WASM Components will run"

                wasmIO -> wasmHost "Runs in"
                wasmStorage -> wasmHost "Runs in"
            }
            doors =    container "Door Game Server" "Runs all of the classic door games that our users remember playing in their younger days"{
                doormenu = component "Door Game Menu" "Maintains a list of available door games and communicates them to the main menu"
                doorsvr = component "Door Server" "Orchestrates and controls the other components"
                doorio = component "IO Adapter" "Adapts the Emulator's terminal I/O to our session multiplexer"
                dosemu =  component "DOS Emulator" "One DOS Emulator process per active game.  State is suspended to storage when not in use."

                doorsvr -> dosemu "Invokes and Manages"
                doorsvr -> doormenu "Provides list of door games to"
                dosemu -> doorio "Interacts with Users through"
            }

            sysopPanel = container "System Operation UI" "Completely separate from user-accessible components for maximum security"

            sysop -> sysopPanel "Administers the System in"

            bouncer -> auth "Offloads Authentication to"

            donation = container "Donation Flow" "Provides the UI for a user to donate by credit card without leaving the terminal"
            donation -> paymentSvc "Processes Payments through"
            donation -> mux "Interacts with Users through"

            doorsvr -> docdbSvc "Suspends Process State to"
            wasmStorage -> docdbSvc "Stores Plugin State in"
            wasmIO -> mux "Interacts with Users through"
            doorIO -> mux "Interacts with Users through"

            # The BBS screen implementations
            profile =  container "User Profile" "Allows users to edit and display their custom profile, and view other users profiles."
            forum =    container "Forum" "Asynchronous, threaded, public messaging, separated into broad topic fora." 
            mail =     container "Mail" "Asynchronous, private messaging." 
            chat =     container "Chat" "Real-time chat."

            profile -> wasmHost "Runs as a Component in"
            forum -> wasmHost "Runs as a Component in"
            mail -> wasmHost "Runs as a Component in"
            chat -> wasmHost "Runs as a Component in"
            
            donation   -> menu "Registers with"
            wasmbridge -> menu "Registers WASM components with"
            doormenu   -> menu "Registers Door Games with"

            # What the people doing?
            user -> mux "SSHes into"
        
        }   

    }

    views {
        systemContext bbs "Context" {
            include *
            autolayout
        }

        container bbs "Container" {
            include *
        }

        component fe "FEComponents" {
            include *
        }

        component doors "DoorComponents" {
            include *
            autolayout lr
        }   

        component wasmbridge "WASMBridgeComponents" {
            include *
        }

        styles {
            element "Person" {
                shape person
            }

            element "Database" {
                shape Cylinder
            }

            element "Existing System" {
                background #999999
                color #ffffff
            }
        }
        
        theme default
    }

    configuration {
        scope softwaresystem
    }

    !docs "md"

}
