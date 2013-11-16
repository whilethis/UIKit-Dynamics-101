//
//  BPXLViewController.m
//  Dynamics and Autolayout
//
//  Created by Brandon Alexander on 10/22/13.
//  Copyright (c) 2013 Black Pixel. All rights reserved.
//

#import "BPXLViewController.h"

@interface BPXLViewController ()<UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@end

@implementation BPXLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    [self.view removeConstraints:self.view.constraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)centerViewTapped:(id)sender {
    [self addGravity];
    
    [self spoiler1];
    [self spoiler2];
    [self fixAutoLayout];
}

- (void) addGravity {
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.centerView]];
	[self.animator addBehavior:gravity];
}

- (void) spoiler1 {
    UICollisionBehavior *gravityBounds = [[UICollisionBehavior alloc] initWithItems:@[self.centerView]];
    gravityBounds.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:gravityBounds];
}

- (void) spoiler2 {
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.centerView]];
    itemBehavior.elasticity = 1.0;
    itemBehavior.friction = 0.0;
//    [itemBehavior addAngularVelocity:M_PI_4 forItem:self.centerView];
    [self.animator addBehavior:itemBehavior];
}

- (void) fixAutoLayout {
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.centerView]];
    [itemBehavior setAction:^{
        self.topConstraint.constant = self.centerView.center.y - (self.centerView.bounds.size.height * 0.5);
        [self.view updateConstraintsIfNeeded];
    }];
    [self.animator addBehavior:itemBehavior];
}

- (IBAction)leftViewTapped:(id)sender {
	self.topConstraint.constant = 50;
}

- (UIDynamicAnimator *) animator {
	if(!_animator) {
		_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
		_animator.delegate = self;
	}
	
	return _animator;
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator {
	[self.animator removeAllBehaviors];
	self.animator = nil;
}

@end
