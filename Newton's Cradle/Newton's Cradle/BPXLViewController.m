//
//  BPXLViewController.m
//  Newton's Cradle
//
//  Created by Brandon Alexander on 11/5/13.
//  Copyright (c) 2013 Black Pixel. All rights reserved.
//

#import "BPXLViewController.h"
#import "BPXLCradleView.h"

@interface BPXLViewController ()<UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet BPXLCradleView *cradleView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachOne;
@property (nonatomic, strong) UIAttachmentBehavior *panAttachOne;

@property (nonatomic, strong) UIDynamicItemBehavior *baseBehavior;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@end

@implementation BPXLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.cradleView.ballOne.frame = CGRectMake(260.0, 455.0, 100.0, 100.0);
    self.cradleView.ballTwo.frame = CGRectMake(361.0, 455.0, 100.0, 100.0);
    self.cradleView.ballThree.frame = CGRectMake(462.0, 455.0, 100.0, 100.0);
    self.cradleView.ballFour.frame = CGRectMake(563.0, 455.0, 100.0, 100.0);
    self.cradleView.ballFive.frame = CGRectMake(664.0, 455.0, 100.0, 100.0);
    
    [self configureView:self.cradleView.ballOne];
    [self configureView:self.cradleView.ballTwo];
    [self configureView:self.cradleView.ballThree];
    [self configureView:self.cradleView.ballFour];
    [self configureView:self.cradleView.ballFive];
}

- (void) configureView:(UIView *) view {
    CGPoint ballCenter = view.center;
    ballCenter.y -= 350.0;
    UIAttachmentBehavior *attachOne = [[UIAttachmentBehavior alloc] initWithItem:view attachedToAnchor:ballCenter];
    attachOne.damping = 1.0;
    attachOne.frequency = 0.0;
    BPXLCradleView *cradleView = self.cradleView;
    attachOne.action = ^{
        [cradleView setNeedsDisplay];
    };

    [self.cradleView addAnchorPoint:ballCenter forView:view];
    
    [self.baseBehavior addItem:view];
    [self.gravity addItem:view];
    [self.collisionBehavior addItem:view];
    
    [self.animator addBehavior:attachOne];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)panRecognized:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            CGPoint ballCenter = sender.view.center;
            ballCenter.y -= 10.0;
            self.panAttachOne = [[UIAttachmentBehavior alloc] initWithItem:sender.view attachedToAnchor:ballCenter];
            self.panAttachOne.damping = 1.0;
            self.panAttachOne.frequency = 0.0;
            
            [self.animator addBehavior:self.panAttachOne];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint point = [sender locationInView:self.view];
            
            self.panAttachOne.anchorPoint = point;

            break;
        }
        case UIGestureRecognizerStateEnded:
            [self.animator removeBehavior:self.panAttachOne];
            self.panAttachOne = nil;
        default:
            break;
    }
}

- (UIDynamicItemBehavior *) baseBehavior {
    if(!_baseBehavior) {
        _baseBehavior = [[UIDynamicItemBehavior alloc] init];
        _baseBehavior.allowsRotation = NO;
        _baseBehavior.elasticity = 1.0;
        [self.animator addBehavior:_baseBehavior];
    }
    
    return _baseBehavior;
}

- (UIGravityBehavior *) gravity {
    if(!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
        
        [self.animator addBehavior:_gravity];
    }
    
    return _gravity;
}

- (UICollisionBehavior *) collisionBehavior {
    if(!_collisionBehavior) {
        _collisionBehavior = [[UICollisionBehavior alloc] init];
        
        [self.animator addBehavior:_collisionBehavior];
    }
    
    return _collisionBehavior;
}

-(UIDynamicAnimator *) animator {
    if(!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.cradleView];
    }
    
    return _animator;
}

@end
