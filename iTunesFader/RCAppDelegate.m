//
//  RCAppDelegate.m
//  iTunesFader
//
//  Created by Ryan Sullivan on 1/7/12.
//  Copyright (c) 2012 Freelance Web Developer. All rights reserved.
//

#import "RCAppDelegate.h"

@implementation RCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    keyTap = [[SPMediaKeyTap alloc] initWithDelegate:self];
    
	if([SPMediaKeyTap usesGlobalMediaKeyTap])
		[keyTap startWatchingMediaKeys];
	else {
		NSLog(@"Media key monitoring disabled");
        abort();
    }
}

-(void)mediaKeyTap:(SPMediaKeyTap*)keyTap receivedMediaKeyEvent:(NSEvent*)event
{
    NSAssert([event type] == NSSystemDefined && [event subtype] == SPSystemDefinedEventMediaKeys, @"Unexpected NSEvent in mediaKeyTap:receivedMediaKeyEvent:");
    
	int keyCode = (([event data1] & 0xFFFF0000) >> 16);
	int keyFlags = ([event data1] & 0x0000FFFF);
	BOOL keyIsPressed = (((keyFlags & 0xFF00) >> 8)) == 0xA;
	//int keyRepeat = (keyFlags & 0x1);
	
	if (keyIsPressed) {
		switch (keyCode) {
			case NX_KEYTYPE_PLAY:
                {
                    NSDictionary *err1 = nil;
                    NSDictionary *err2 = nil;
                    
                    NSURL *scriptURL = [[NSBundle mainBundle] URLForResource:@"iTunesFader" withExtension:@"scpt"];
                    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:scriptURL error:&err1];
                    
                    NSAppleEventDescriptor *ret = [script executeAndReturnError:&err2];
                    NSLog(@"Result: %@", ret);
                    
                    [script release];
                }
				break;
			case NX_KEYTYPE_FAST:
				break;
			case NX_KEYTYPE_REWIND:
				break;
			default:
				break;
                // More cases defined in hidsystem/ev_keymap.h
		}
	}
}

@end
