//
//  BPXLViewController.m
//  GravityBox
//
//  Created by Brandon Alexander on 6/13/13.
//  Copyright (c) 2013 Black Pixel. All rights reserved.
//

#import "BPXLViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "BPXLGravityView.h"

@interface BPXLViewController ()<UICollisionBehaviorDelegate>
@property (weak, nonatomic) IBOutlet UIView *fallingBox;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravityBehavior;
@property (strong, nonatomic) UIAttachmentBehavior *attachBehavior;

@end

@implementation BPXLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	UITapGestureRecognizer *tappy = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(boxTapped:)];
	
	[self.fallingBox addGestureRecognizer:tappy];
	
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
	[self.view addGestureRecognizer:pan];
	
	self.attachBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.fallingBox attachedToAnchor:CGPointZero];
	self.attachBehavior.length = 50.0;
	self.attachBehavior.damping = 0.0;
	self.attachBehavior.frequency = 1.0;
	__weak BPXLViewController *weakSelf = self;
	self.attachBehavior.action = ^{
		BPXLGravityView *view = (BPXLGravityView *)weakSelf.view;
		view.anchorPoint = weakSelf.attachBehavior.anchorPoint;
	};
	
	
	[self.animator addBehavior:self.attachBehavior];
	
	BPXLGravityView *view = (BPXLGravityView *)self.view;
	view.boxView = self.fallingBox;
	view.anchorPoint = self.fallingBox.center;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) boxTapped:(UITapGestureRecognizer *) tappy {
	if(!self.gravityBehavior) {
		self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.fallingBox]];

		
		[self.animator addBehavior:self.gravityBehavior];
	}
}

- (void) panRecognized:(UIPanGestureRecognizer *) pan {
	CGPoint point = [pan locationInView:self.view];
	
	self.attachBehavior.anchorPoint = point;
//	self.fallingBox.center = point;
}

- (UIDynamicAnimator *) animator {
	if(!_animator) {
		_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	}
	
	return _animator;
}

@end
