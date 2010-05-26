//
//  DrippingAppDelegate.h
//  Dripping
//
//  Created by Stephen H. Gerstacker on 5/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DrippingAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
