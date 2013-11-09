//
//  BPXLGravityView.m
//  GravityBox
//
//  Created by Brandon Alexander on 6/15/13.
//  Copyright (c) 2013 Black Pixel. All rights reserved.
//

#import "BPXLGravityView.h"

@implementation BPXLGravityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetLineWidth(context, 5.0);
	
	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	
	CGPoint startingPoint = self.boxView.center;
	
	CGContextMoveToPoint(context, startingPoint.x, startingPoint.y);
	CGContextAddLineToPoint(context, self.anchorPoint.x, self.anchorPoint.y);
	
	CGContextStrokePath(context);
}

- (void) setAnchorPoint:(CGPoint)anchorPoint {
	_anchorPoint = anchorPoint;
	
	[self setNeedsDisplay];
}


@end
