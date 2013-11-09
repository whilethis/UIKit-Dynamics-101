//
//  BPXLPendulumBehavior.h
//  Newton's Cradle
//
//  Created by Brandon Alexander on 11/7/13.
//  Copyright (c) 2013 Black PIxel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPXLPendulumBehavior : UIDynamicBehavior
- (instancetype) initWithItem:(id<UIDynamicItem>) item pendulumLength:(CGFloat) length;

@end
