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
#import "HelloWorldLayer.h"

@implementation InputLayer

-(id) init
{
	if ((self = [super init]))
	{
		[self addJoystick];
        
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
    SneakyJoystickSkinnedBase* skinStick=[[SneakyJoystickSkinnedBase alloc] init]; skinStick.joystick = joystick;
    skinStick.backgroundSprite.color = ccYELLOW;
    skinStick.backgroundSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:30];;
    skinStick.thumbSprite = [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:10];;
    skinStick.position=CGPointMake(stickRadius * 1.5f, stickRadius * 1.5f); [self addChild:skinStick];
}

-(void) update:(ccTime)delta
{
    HelloWorldLayer* game = [HelloWorldLayer sharedGameLayer];

    Hero* hero = [game defaultHero];
    
	CGPoint velocity = ccpMult(joystick.velocity, 2000 * delta);
    
    hero.position = CGPointMake(hero.position.x + velocity.x * delta, hero.position.y + velocity.y * delta);
    game.position = CGPointMake(game.position.x - velocity.x * delta, game.position.y - velocity.y * delta);
    
    if (hero.position.x < 24.0f) {
        hero.position = ccp(24.0f, hero.position.y);
        game.position = ccp(100.0f, game.position.y);
    } else if (hero.position.x > (game.themap.mapSize.width * game.themap.tileSize.width)/2 - 24.0f) {
        hero.position = ccp((game.themap.mapSize.width * game.themap.tileSize.width)/2 - 24.0f, hero.position.y);
        game.position = ccp((game.themap.mapSize.width * game.themap.tileSize.width)/2 - 1100.0f, game.position.y);
    }
    
}

@end
