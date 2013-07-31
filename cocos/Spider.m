//
//  Spider.m
//  Mighty Sword
//
//  Created by alex on 31/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "Spider.h"

@implementation Spider

+(id) spider
{
	return [[self alloc] initWithEnemyImage];
}

-(id) initWithEnemyImage
{
	// Loading the Hero's sprite using a sprite frame name (eg the filename)
	if ((self = [super initWithSpriteFrameName:@"spider-right.png"]))
	{
        [self initAnimations];
        
        [self scheduleUpdate];
        
	}
	return self;
}

-(int) getDamage {
    
    return kSpiderDamage;
}

-(void)initAnimations {
    
    //move right animation
    
    NSMutableArray *walkRightAnimFrames = [NSMutableArray array];
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"spider-right-left-step.png"]]];
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"spider-right.png"]]];
    
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"spider-right-right-step.png"]]];
    
    self.walkRightAnim = [CCAnimation animationWithSpriteFrames:walkRightAnimFrames delay:0.1f];
    
    //move left animation
    
    NSMutableArray *walkLeftAnimFrames = [NSMutableArray array];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"spider-left-left-step.png"]]];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"spider-left.png"]]];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"spider-left-right-step.png"]]];
    
    self.walkLeftAnim = [CCAnimation animationWithSpriteFrames:walkLeftAnimFrames delay:0.1f];
    
    //move up animation
    
    NSMutableArray *walkUpAnimFrames = [NSMutableArray array];
    
    [walkUpAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"spider-back-left-step.png"]]];
    
    [walkUpAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"spider-back-right-step.png"]]];
    
    self.walkUpAnim= [CCAnimation animationWithSpriteFrames:walkUpAnimFrames delay:0.2f];
    
    
    //move down animation
    
    NSMutableArray *walkDownAnimFrames = [NSMutableArray array];
    
    [walkDownAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"spider-front-left-step.png"]]];
    
    [walkDownAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"spider-front-right-step.png"]]];
    
    self.walkDownAnim = [CCAnimation animationWithSpriteFrames:walkDownAnimFrames delay:0.2f];
    
}


@end
