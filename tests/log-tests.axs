(***********************************************************
    AMX LOG LIBRARY
    TESTS
    
    
    Website: https://github.com/amclain/amx-lib-log
    
    
    This file tests the library's functionality.
************************************************************)

PROGRAM_NAME='log-tests'
(***********************************************************)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(*                    INCLUDES GO BELOW                    *)
(***********************************************************)

#include 'amx-test-suite'

(***********************************************************)
(*           DEVICE NUMBER DEFINITIONS GO BELOW            *)
(***********************************************************)
DEFINE_DEVICE

dvLogConsole = 33000:1:0;  // Override console output device for testing.

#include 'amx-lib-log'

(***********************************************************)
(*                TEST DEFINITIONS GO BELOW                *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

define_function testSuiteRun()
{
    logSetLevel(LOG_LEVEL_INFO);
    
    testPrint();
    testSetDisablePrependSeverity();
}

define_function testPrint()
{
    char data[255];
    
    data = 'print data';
    print(LOG_LEVEL_INFO, data);
    assertEventString(dvLogConsole, "'INFO: ', data", 'Print log item.');
}

define_function testSetDisablePrependSeverity()
{
    char data[255];
    
    data = 'severity data false';
    logSetDisablePrependSeverity(false);
    print(LOG_LEVEL_INFO, data);
    assertEventString(dvLogConsole, "'INFO: ', data", 'Disable prepend severity set false.');
    
    data = 'severity data true';
    logSetDisablePrependSeverity(true);
    print(LOG_LEVEL_INFO, data);
    assertEventString(dvLogConsole, data, 'Disable prepend severity set true.');
}

(***********************************************************)
(*                   THE EVENTS GO BELOW                   *)
(***********************************************************)
DEFINE_EVENT

data_event[dvLogConsole]
{
    string:
    {
        testSuiteEvent e;
        
        e.device = data.device;
        e.str    = data.text;
        e.type   = TEST_SUITE_EVENT_STRING;
        
        testSuiteEventTriggered(e);
    }
}

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*          DO NOT PUT ANY CODE BELOW THIS COMMENT         *)
(***********************************************************)
