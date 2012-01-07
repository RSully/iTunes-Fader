//
//  RCAppDelegate.h
//  iTunesFader
//
//  Created by Ryan Sullivan on 1/7/12.
//  Copyright (c) 2012 Freelance Web Developer. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SPMediaKeyTap.h"

@interface RCAppDelegate : NSObject <NSApplicationDelegate> {
    SPMediaKeyTap *keyTap;
}

@end
