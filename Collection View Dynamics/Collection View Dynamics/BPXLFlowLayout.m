//
//  BPXLFlowLayout.m
//  Collection View Dynamics
//
//  Created by Brandon Alexander on 10/14/13.
//  Copyright (c) 2013 Black Pixel. All rights reserved.
//

//Pieces of this class was taken from http://www.objc.io/issue-5/collection-views-and-uidynamics.html


#import "BPXLFlowLayout.h"

@interface BPXLFlowLayout ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation BPXLFlowLayout

- (void) prepareLayout {
	[super prepareLayout];
	
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.itemSize = CGSizeMake(44, 44);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
}

- (CGSize) collectionViewContentSize {
	CGSize size = [super collectionViewContentSize];
	
	return size;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
	if(self.animator) {
		return [self.animator itemsInRect:rect];
	}
	
	self.animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
	
	CGSize contentSize = [self collectionViewContentSize];
	CGRect size = (CGRect) { .size = contentSize };
	NSArray *items = [super layoutAttributesForElementsInRect:size];
	
	[items enumerateObjectsUsingBlock:^(id<UIDynamicItem> obj, NSUInteger idx, BOOL *stop) {
		UIAttachmentBehavior *behavior = [[UIAttachmentBehavior alloc] initWithItem:obj
																   attachedToAnchor:[obj center]];
		
		behavior.length = 0.0f;
		behavior.damping = 0.2f;
		behavior.frequency = 1.0f;
		
		[self.animator addBehavior:behavior];
	}];
	
	return items;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.animator layoutAttributesForCellAtIndexPath:indexPath];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    UIScrollView *scrollView = self.collectionView;
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [self.animator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehavior, NSUInteger idx, BOOL *stop) {
        CGFloat yDistanceFromTouch = fabsf(touchLocation.y - springBehavior.anchorPoint.y);
        CGFloat xDistanceFromTouch = fabsf(touchLocation.x - springBehavior.anchorPoint.x);
        CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1500.0f;
        
        UICollectionViewLayoutAttributes *item = springBehavior.items.firstObject;
        CGPoint center = item.center;
        if (delta < 0) {
            center.y += MAX(delta, delta*scrollResistance);
        }
        else {
            center.y += MIN(delta, delta*scrollResistance);
        }
        item.center = center;
        
        [self.animator updateItemUsingCurrentState:item];
    }];
    
    return NO;
}

@end
