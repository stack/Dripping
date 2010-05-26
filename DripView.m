//
//  DripView.m
//  Dripping
//
//  Created by Stephen H. Gerstacker on 5/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DripView.h"

@implementation DripView

@synthesize count, drawStringAttributes, running, times;

- (BOOL)acceptsFirstResponder {
	return YES;
}

- (void)dealloc {
	self.count = 0;
	self.drawStringAttributes = nil;
	self.running = NO;
	self.times = nil;
	
	[super dealloc];
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		// Set the defaults
        self.count = 10;
		self.running = NO;
		self.times = [NSMutableArray arrayWithCapacity:10];
		
		// Prepare the font rendering attributes
		NSFont *font = [[NSFontManager sharedFontManager] fontWithFamily:@"Monaco" traits:NSBoldFontMask weight:9 size:24];
		self.drawStringAttributes = [NSMutableDictionary dictionary];
		[self.drawStringAttributes setValue:[NSColor blackColor] forKey:NSForegroundColorAttributeName];
		[self.drawStringAttributes setValue:font forKey:NSFontAttributeName];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	NSString *text = nil;
	
	if (self.isRunning) {
		text = [NSString stringWithFormat:@"%d", self.count];
	} else if (self.count == 0) {
		NSTimeInterval average = 0;
		for (int i = 0; i < 10; i++) {
			NSDate *one = [self.times objectAtIndex:i];
			NSDate *two = [self.times objectAtIndex:i+1];
			average += [two timeIntervalSinceDate:one];
		}
		
		average = average / 10.0;
		NSTimeInterval bps = 1.0/average;
		
		text = [NSString stringWithFormat:@"BPM: %0.2f", bps * 60.0];
	} else {
		text = [NSString stringWithString:@"Press Space to Begin"];
	}
	
	if (text != nil) {
		// Set up the font
		
		
		// Calculate the sizes
		NSSize textSize = [text sizeWithAttributes:self.drawStringAttributes];
		NSPoint centerPoint;
		centerPoint.x = (dirtyRect.size.width / 2) - (textSize.width / 2);
		centerPoint.y = (dirtyRect.size.height / 2) - (textSize.height / 2);
		
		// Draw the string
		[text drawAtPoint:centerPoint withAttributes:self.drawStringAttributes];
	}
}

- (void)keyDown:(NSEvent *)theEvent {
	if ([theEvent keyCode] == 49) { // Space was pressed
		
		if (!self.isRunning && self.count == 10) {
			self.running = YES;
			[self.times addObject:[NSDate date]];
			[self setNeedsDisplay:YES];
			return;
		}
		
		if (self.isRunning && self.count != 0) {
			[self.times addObject:[NSDate date]];
			self.count -= 1;
			if (self.count == 0) {
				self.running = NO;
			}
			[self setNeedsDisplay:YES];
			return;
		}
	} else if ([theEvent keyCode] == 53) {
		self.running = NO;
		self.count = 10;
		[self.times removeAllObjects];
		[self setNeedsDisplay:YES];
	}
}

@end
