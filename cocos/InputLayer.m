//
//  InputLayer.m
//  cocos
//
//  Created by alex on 23/05/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "InputLayer.h"
#import "ColoredCircleSprite.h"
#import "Hero.h"
#import "GameLayer.h"


@implementation InputLayer

-(id) init
{
	if ((self = [super init]))
	{
        [self initAnimations];
        
		[self addJoystick];
        
        [self addAttackButton];
        
		[self scheduleUpdate];
        
	}
	return self;
}

-(void) addJoystick
{    
    float stickRadius=30;
    joystick=[[SneakyJoystick alloc] initWithRect: CGRectMake(0, 0, stickRadius, stickRadius)];
    joystick.autoCenter = YES;
    joystick.hasDeadzone = YES;
    joystick.deadRadius = 10;
    joystick.isDPad = YES;
    joystick.numberOfDirections = 4;
    SneakyJoystickSkinnedBase* skinStick=[[SneakyJoystickSkinnedBase alloc] init];
    skinStick.joystick = joystick;
    skinStick.backgroundSprite.color = ccYELLOW;
    skinStick.backgroundSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:30];
    skinStick.thumbSprite = [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:10];
    skinStick.position=CGPointMake(stickRadius * 1.5f, stickRadius * 1.5f);
    [self addChild:skinStick];
}

-(void) addAttackButton
{
    SneakyButtonSkinnedBase *attackBut = [[SneakyButtonSkinnedBase alloc] init];
    attackBut.position = ccp(500,45);
    attackBut.defaultSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:22];
    attackBut.pressSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 255) radius:22];
    attackBut.button = [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 64)];
    attackButton = attackBut.button;
    attackButton.isToggleable = NO;
    attackButton.isHoldable = NO;
    [self addChild:attackBut];
    
    
}

-(void) update:(ccTime)delta
{
    GameLayer* game = [GameLayer sharedGameLayer];

    Hero* hero = [game defaultHero];
        
    
    float mapWidth = (game.themap.mapSize.width * game.themap.tileSize.width)/2;
    float mapHeight = (game.themap.mapSize.height * game.themap.tileSize.height)/2;
        
	CGPoint velocity = ccpMult(joystick.velocity, 2000 * delta);
    
    hero.position = CGPointMake(hero.position.x + velocity.x * delta, hero.position.y + velocity.y * delta);

    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    int x = MAX(hero.position.x, winSize.width/2);
    int y = MAX(hero.position.y, winSize.height/2);
    x = MIN(x, mapWidth - winSize.width / 2);
    y = MIN(y, mapHeight - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    game.position = viewPoint;

    
    // Make sure player doesn't walk out of the screen
    if (hero.position.x < 24.0f) {
        hero.position = ccp(24.0f, hero.position.y);
    } else if (hero.position.x > (game.themap.mapSize.width * game.themap.tileSize.width)/2 - 24.0f) {
        hero.position = ccp(mapWidth - 24.0f, hero.position.y);
    } else if (hero.position.y < 36.0f) {
        hero.position = ccp(hero.position.x, 36.0f);
    } else if (hero.position.y > (game.themap.mapSize.height * game.themap.tileSize.height)/2) {
        hero.position = ccp(hero.position.x, mapWidth);
    }
    

    if (joystick.velocity.x == 1.0f) {
        
        [hero stopAction:self.walkUpAction];
        [hero stopAction:self.walkDownAction];
        [hero stopAction:self.walkLeftAction];
        
        if (hero.numberOfRunningActions == 0) {
            [hero runAction:self.walkRightAction];
        }
    }
    else if (joystick.velocity.x == -1.0f){
        
        [hero stopAction:self.walkUpAction];
        [hero stopAction:self.walkDownAction];
        [hero stopAction:self.walkRightAction];

        if (hero.numberOfRunningActions == 0) {
            [hero runAction:self.walkLeftAction];
        }
    }
    else if (joystick.velocity.y == 1.0f){
        
        [hero stopAction:self.walkDownAction];
        [hero stopAction:self.walkLeftAction];
        [hero stopAction:self.walkRightAction];
        
        if (hero.numberOfRunningActions == 0) {
            [hero runAction:self.walkUpAction];
        }
    }
    else if (joystick.velocity.y == -1.0f){
        
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
