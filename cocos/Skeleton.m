//
//  Skeleton.m
//  Mighty Sword
//
//  Created by alex on 09/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "Skeleton.h"

@implementation Skeleton


+(id) skeleton
{
	return [[self alloc] initWithEnemyImage];
}

-(id) initWithEnemyImage
{
	// Loading the Hero's sprite using a sprite frame name (eg the filename)
	if ((self = [super initWithSpriteFrameName:@"skeleton-right.png"]))
	{
        [self initAnimations];
        
        [self scheduleUpdate];
        
        self.health = 50;
        
	}
	return self;
}

-(int) getDamage {
    
    return kSkeletonDamage;
}

-(void)initAnimations {
    
    //move right animation
    
    NSMutableArray *walkRightAnimFrames = [NSMutableArray array];
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-right-left-step.png"]]];
   
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-right.png"]]];
    
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-right-right-step.png"]]];
    
    self.walkRightAnim = [CCAnimation animationWithSpriteFrames:walkRightAnimFrames delay:0.1f];
    
    //move left animation
    
    NSMutableArray *walkLeftAnimFrames = [NSMutableArray array];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-left-left-step.png"]]];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-left.png"]]];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-left-right-step.png"]]];
    
    self.walkLeftAnim = [CCAnimation animationWithSpriteFrames:walkLeftAnimFrames delay:0.1f];
    
    //move up animation
    
    NSMutableArray *walkUpAnimFrames = [NSMutableArray array];
    
    [walkUpAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-back-left-step.png"]]];
    
    [walkUpAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-back-right-step.png"]]];
    
    self.walkUpAnim= [CCAnimation animationWithSpriteFrames:walkUpAnimFrames delay:0.2f];
    
    
    //move down animation
    
    NSMutableArray *walkDownAnimFrames = [NSMutableArray array];
    
    [walkDownAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-front-left-step.png"]]];
    
    [walkDownAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-front-right-step.png"]]];
    
    self.walkDownAnim = [CCAnimation animationWithSpriteFrames:walkDownAnimFrames delay:0.2f];
    
}

@end
