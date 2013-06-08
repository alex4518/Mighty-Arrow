//
//  Hero.m
//  cocos
//
//  Created by alex on 04/06/2013.
//  Copyright 2013 alex. All rights reserved.
//

#import "Hero.h"
#import "GameLayer.h"
#import "InputLayer.h"


@interface Hero (PrivateMethods)
-(id) initWithHeroImage;
@end

@implementation Hero

+(id) hero
{
	return [[self alloc] initWithHeroImage];
}

-(id) initWithHeroImage
{
	// Loading the Hero's sprite using a sprite frame name (eg the filename)
	if ((self = [super initWithSpriteFrameName:@"right_sword.png"]))
	{        
        [self initAnimations];

        [self scheduleUpdate];
        
	}
	return self;
}

-(void) update:(ccTime)delta {
    
    GameLayer* game = [GameLayer sharedGameLayer];
    
    Hero* hero = [game defaultHero];
    
    [hero applyJoystick:self.joystick
           forTimeDelta:delta];
}


-(void)applyJoystick:(SneakyJoystick *)aJoystick forTimeDelta:(float)delta{
    
    GameLayer* game = [GameLayer sharedGameLayer];
    
    Hero* hero = [game defaultHero];
    
    CGPoint velocity = ccpMult(aJoystick.velocity, 2000 * delta);
    
    hero.position = CGPointMake(hero.position.x + velocity.x * delta, hero.position.y + velocity.y * delta);

    
    if (aJoystick.velocity.x == 1.0f) {
        
        [hero stopAction:self.walkUpAction];
        [hero stopAction:self.walkDownAction];
        [hero stopAction:self.walkLeftAction];
        
        if (hero.numberOfRunningActions == 0) {
            [hero runAction:self.walkRightAction];
        }
    }
    else if (aJoystick.velocity.x == -1.0f){
        
        [hero stopAction:self.walkUpAction];
        [hero stopAction:self.walkDownAction];
        [hero stopAction:self.walkRightAction];
        
        if (hero.numberOfRunningActions == 0) {
            [hero runAction:self.walkLeftAction];
        }
    }
    else if (aJoystick.velocity.y == 1.0f){
        
        [hero stopAction:self.walkDownAction];
        [hero stopAction:self.walkLeftAction];
        [hero stopAction:self.walkRightAction];
        
        if (hero.numberOfRunningActions == 0) {
            [hero runAction:self.walkUpAction];
        }
    }
    else if (aJoystick.velocity.y == -1.0f){
        
        [hero stopAction:self.walkUpAction];
        [hero stopAction:self.walkLeftAction];
        [hero stopAction:self.walkRightAction];
        
        if (hero.numberOfRunningActions == 0) {
            [hero runAction:self.walkDownAction];
        }
    }
    else {
        [hero stopAllActions];
    }
    
}

-(void)initAnimations {
    
    //move right animation
    
    NSMutableArray *walkRightAnimFrames = [NSMutableArray array];
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"right_left_step_sword.png"]]];
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"right_sword.png"]]];
    
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"right_right_step_sword.png"]]];
    
    CCAnimation *walkRightAnim = [CCAnimation animationWithSpriteFrames:walkRightAnimFrames delay:0.2f];
    
    self.walkRightAction = [CCRepeatForever actionWithAction:
                            [CCAnimate actionWithAnimation:walkRightAnim]];
    
    
    //move left animation
    
    NSMutableArray *walkLeftAnimFrames = [NSMutableArray array];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"left_left_step_sword.png"]]];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"left_sword.png"]]];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"left_right_step_sword.png"]]];
    
    CCAnimation *walkLeftAnim = [CCAnimation animationWithSpriteFrames:walkLeftAnimFrames delay:0.2f];
    
    self.walkLeftAction = [CCRepeatForever actionWithAction:
                           [CCAnimate actionWithAnimation:walkLeftAnim]];
    
    
    
    
    //move up animation
    
    NSMutableArray *walkUpAnimFrames = [NSMutableArray array];
    
    [walkUpAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"back_left_step.png"]]];
    
    [walkUpAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"back_right_step.png"]]];
    
    CCAnimation *walkUpAnim = [CCAnimation animationWithSpriteFrames:walkUpAnimFrames delay:0.3f];
    
    self.walkUpAction = [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:walkUpAnim]];
    
    
    //move down animation
    
    NSMutableArray *walkDownAnimFrames = [NSMutableArray array];
    
    [walkDownAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"front_left_step_sword.png"]]];
    
    [walkDownAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"front_right_step_sword.png"]]];
    
    CCAnimation *walkDownAnim = [CCAnimation animationWithSpriteFrames:walkDownAnimFrames delay:0.3f];
    
    self.walkDownAction = [CCRepeatForever actionWithAction:
                           [CCAnimate actionWithAnimation:walkDownAnim]];
}


@end
