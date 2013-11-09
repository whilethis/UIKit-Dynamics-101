//
//  BPXLCradleView.m
//  Newton's Cradle
//
//  Created by Brandon Alexander on 11/5/13.
//  Copyright (c) 2013 Black PIxel. All rights reserved.
//

#import "BPXLCradleView.h"

@interface BPXLCradleView ()

@property (nonatomic, strong) NSMutableDictionary *anchorPoints;

@end

@implementation BPXLCradleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    
    self.ballOne.tag = 1;
    self.ballTwo.tag = 2;
    self.ballThree.tag = 3;
    self.ballFour.tag = 4;
    self.ballFive.tag = 5;
}

- (void) addAnchorPoint:(CGPoint) anchorPoint forView:(UIView *) view {
    self.anchorPoints[@(view.tag)] = [NSValue valueWithCGPoint:anchorPoint];
    
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    for(NSNumber *tag in self.anchorPoints) {
        UIView *boxView = [self viewWithTag:tag.integerValue];
        CGPoint anchorPoint = [self.anchorPoints[tag] CGPointValue];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetLineWidth(context, 5.0);
        
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        
        CGPoint startingPoint = boxView.center;
        
        CGContextMoveToPoint(context, startingPoint.x, startingPoint.y);
        CGContextAddLineToPoint(context, anchorPoint.x, anchorPoint.y);
        
        CGContextStrokePath(context);
    }

}

- (NSMutableDictionary *) anchorPoints {
    if(!_anchorPoints) {
        _anchorPoints = [NSMutableDictionary dictionary];
    }
    
    return _anchorPoints;
}

@end
