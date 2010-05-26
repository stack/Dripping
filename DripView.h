//
//  DripView.h
//  Dripping
//
//  Created by Stephen H. Gerstacker on 5/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DripView : NSView {
	int count;
	NSMutableDictionary *drawStringAttributes;
	BOOL running;
	NSMutableArray *times;
}

@property (assign) int count;
@property (retain) NSMutableDictionary *drawStringAttributes;
@property (assign,getter=isRunning) BOOL running;
@property (retain) NSMutableArray *times;

@end
