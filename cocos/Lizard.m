//
//  Lizard.m
//  Mighty Sword
//
//  Created by alex on 31/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "Lizard.h"

@implementation Lizard

+(id) lizard
{
	return [[self alloc] initWithEnemyImage];
}

-(id) initWithEnemyImage
{
	// Loading the Hero's sprite using a sprite frame name (eg the filename)
	if ((self = [super initWithSpriteFrameName:@"lizard-right.png"]))
	{
        [self initAnimations];
        
        [self scheduleUpdate];
        
	}
	return self;
}

-(int) getDamage {
    
    return kLizardDamage;
}

-(void)initAnimations {
    
    //move right animation
    
    NSMutableArray *walkRightAnimFrames = [NSMutableArray array];
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"lizard-right-left-step.png"]]];
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"lizard-right.png"]]];
    
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"lizard-right-right-step.png"]]];
    
    self.walkRightAnim = [CCAnimation animationWithSpriteFrames:walkRightAnimFrames delay:0.1f];
    
    //move left animation
    
    NSMutableArray *walkLeftAnimFrames = [NSMutableArray array];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"lizard-left-left-step.png"]]];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"lizard-left.png"]]];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"lizard-left-right-step.png"]]];
    
    self.walkLeftAnim = [CCAnimation animationWithSpriteFrames:walkLeftAnimFrames delay:0.1f];
    
    //move up animation
    
    NSMutableArray *walkUpAnimFrames = [NSMutableArray array];
    
    [walkUpAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"lizard-back-left-step.png"]]];
    
    [walkUpAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"lizard-back-right-step.png"]]];
    
    self.walkUpAnim= [CCAnimation animationWithSpriteFrames:walkUpAnimFrames delay:0.2f];
    
    
    //move down animation
    
    NSMutableArray *walkDownAnimFrames = [NSMutableArray array];
    
    [walkDownAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"lizard-front-left-step.png"]]];
    
    [walkDownAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"lizard-front-right-step.png"]]];
    
    self.walkDownAnim = [CCAnimation animationWithSpriteFrames:walkDownAnimFrames delay:0.2f];
    
}


@end
