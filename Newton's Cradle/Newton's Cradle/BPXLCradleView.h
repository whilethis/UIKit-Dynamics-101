//
//  BPXLCradleView.h
//  Newton's Cradle
//
//  Created by Brandon Alexander on 11/5/13.
//  Copyright (c) 2013 Black Pixel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPXLCradleView : UIView
@property (weak, nonatomic) IBOutlet UIView *ballOne;
@property (weak, nonatomic) IBOutlet UIView *ballTwo;
@property (weak, nonatomic) IBOutlet UIView *ballThree;
@property (weak, nonatomic) IBOutlet UIView *ballFour;
@property (weak, nonatomic) IBOutlet UIView *ballFive;

- (void) addAnchorPoint:(CGPoint) anchorPoint forView:(UIView *) view;

@end
