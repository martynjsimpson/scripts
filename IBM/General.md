# General IBM

## Start up/ Shutdown
Restart
    
    PWRDWNSYS *RESTART *YES

To bring up in restricted state set
    
    CHGIPLA STRRSTD(*YES)

## Connecting via HMC
When the paritions are in a restricted state the only way to connect is via the HMC. (Note you should always use Shared sessions in-case you lcok yourself out)

In Client Access Session

1. Communication --> 
1. Change system name to IP of HMC --> 
1. Properties --> 
1. User ID signon information --> 
1. "Use HMC 5250 Console Settings" --> 
1. Port number: 2300 --> 
1. OK --> 
1. Select Language 22 --> 
1. Enter HMC Credentials --> 
1. Select system (physical box) --> 
1. Select Parition and put a 2 next to it --> 
1. If this is a new session decide on a key (one time use for this continuous session)/ If there is an existing session enter the key you entered earlier 

## Killing your own screwed job/ task
1. Shift Esc (or right click Pad 1 --> SysRq) --> 
1. Enter 2 at the bottom of the screen or leave it blank and hit enter to see all options.

## View System Status (Show Jobs, Storage etc)
    WRKSYSSTS