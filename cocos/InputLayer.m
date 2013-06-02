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
		[self addJoystick];
        
		[self scheduleUpdate];
        
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
         [NSString stringWithFormat:@"right_left_step.png"]]];
        
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"right_right_step.png"]]];
        
        CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.3f];
        
        self.walkAction = [CCRepeatForever actionWithAction:
                           [CCAnimate actionWithAnimation:walkAnim]];        
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
    SneakyJoystickSkinnedBase* skinStick=[[SneakyJoystickSkinnedBase alloc] init]; skinStick.joystick = joystick;
    skinStick.backgroundSprite.color = ccYELLOW;
    skinStick.backgroundSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:30];;
    skinStick.thumbSprite = [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:10];;
    skinStick.position=CGPointMake(stickRadius * 1.5f, stickRadius * 1.5f); [self addChild:skinStick];
}

-(void) update:(ccTime)delta
{
    GameLayer* game = [GameLayer sharedGameLayer];

    Hero* hero = [game defaultHero];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    float mapWidth = (game.themap.mapSize.width * game.themap.tileSize.width)/2;
    float mapHeight = (game.themap.mapSize.height * game.themap.tileSize.height)/2;
        
	CGPoint velocity = ccpMult(joystick.velocity, 2000 * delta);
    
    hero.position = CGPointMake(hero.position.x + velocity.x * delta, hero.position.y + velocity.y * delta);
    game.position = CGPointMake(game.position.x - velocity.x * delta, game.position.y - velocity.y * delta);

    // Make sure player doesn't walk out of the screen
    if (hero.position.x < 24.0f) {
        hero.position = ccp(24.0f, hero.position.y);
        game.position = ccp(screenHeight/2 - 24.0f, game.position.y);
    } else if (hero.position.x > (game.themap.mapSize.width * game.themap.tileSize.width)/2 - 24.0f) {
        hero.position = ccp(mapWidth - 24.0f, hero.position.y);
        game.position = ccp(-mapWidth + screenHeight/2 + 24.0f, game.position.y);
    } else if (hero.position.y < 36.0f) {
        hero.position = ccp(hero.position.x, 36.0f);
        game.position = ccp(game.position.x, screenWidth/2 - 36.0f);
    } else if (hero.position.y > (game.themap.mapSize.height * game.themap.tileSize.height)/2) {
        hero.position = ccp(hero.position.x, mapWidth);
        game.position = ccp(game.position.x, -mapHeight + screenWidth/2);
    }
    
    if (joystick.velocity.x != 0.0f) {
        if (hero.numberOfRunningActions == 0) {
            [hero runAction:self.walkAction];
        }
    } else {
        [hero stopAllActions];
    }
    
}

@end
