//
//  Skeleton.m
//  Mighty Sword
//
//  Created by alex on 09/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "Skeleton.h"
#import "GameLayer.h"

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
        
	}
	return self;
}

-(void) update:(ccTime)delta {
    
    GameLayer* game = [GameLayer sharedGameLayer];
    
    Hero* hero = [game defaultHero];
    
    CGPoint oldPos = [self position];
    CGPoint newPos = [hero position];
    
    
    NSLog(@"old:%f",oldPos.x);
    NSLog(@"new:%f",newPos.x);
    
    NSLog(@"abs:%d",abs(self.position.x - hero.position.x));

    
    if (self.numberOfRunningActions == 0) {
        
        [self moveTowardHero];
    
    
        if (abs(self.position.x - hero.position.x > 30.0f)) {
                

        
                [self runAction:self.walkRightAction];
            

        
        }
            
       else if (abs(self.position.y - hero.position.y> 30))  {
            
                

                [self stopAction:self.walkRightAction];
                
                [self runAction:self.walkUpAction];
        }

        
    }

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
    
    CCAnimation *walkRightAnim = [CCAnimation animationWithSpriteFrames:walkRightAnimFrames delay:0.2f];
    
    self.walkRightAction = [CCRepeatForever actionWithAction:
                            [CCAnimate actionWithAnimation:walkRightAnim]];
    
    
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
    
    CCAnimation *walkLeftAnim = [CCAnimation animationWithSpriteFrames:walkLeftAnimFrames delay:0.2f];
    
    self.walkLeftAction = [CCRepeatForever actionWithAction:
                           [CCAnimate actionWithAnimation:walkLeftAnim]];
    
    
    
    
    //move up animation
    
    NSMutableArray *walkUpAnimFrames = [NSMutableArray array];
    
    [walkUpAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-back-left-step.png"]]];
    
    [walkUpAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-back-right-step.png"]]];
    
    CCAnimation *walkUpAnim = [CCAnimation animationWithSpriteFrames:walkUpAnimFrames delay:0.3f];
    
    self.walkUpAction = [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:walkUpAnim]];
    
    
    //move down animation
    
    NSMutableArray *walkDownAnimFrames = [NSMutableArray array];
    
    [walkDownAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-front-left-step.png"]]];
    
    [walkDownAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"skeleton-front-right-step.png"]]];
    
    CCAnimation *walkDownAnim = [CCAnimation animationWithSpriteFrames:walkDownAnimFrames delay:0.3f];
    
    self.walkDownAction = [CCRepeatForever actionWithAction:
                           [CCAnimate actionWithAnimation:walkDownAnim]];
}

@end
