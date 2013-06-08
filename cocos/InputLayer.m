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
        GameLayer* game = [GameLayer sharedGameLayer];
        
        game.delegate = self;
        
        [self addJoystick];
        
        [self addAttackButton];
        
		[self scheduleUpdate];
        
	}
	return self;
}

-(void) addJoystick
{    
    float stickRadius=30;
    sJoystick=[[SneakyJoystick alloc] initWithRect: CGRectMake(0, 0, stickRadius, stickRadius)];
    sJoystick.autoCenter = YES;
    sJoystick.hasDeadzone = YES;
    sJoystick.deadRadius = 10;
    sJoystick.isDPad = YES;
    sJoystick.numberOfDirections = 4;
    SneakyJoystickSkinnedBase* skinStick=[[SneakyJoystickSkinnedBase alloc] init];
    skinStick.joystick = sJoystick;
    skinStick.backgroundSprite.color = ccYELLOW;
    skinStick.backgroundSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:30];
    skinStick.thumbSprite = [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:10];
    skinStick.position=CGPointMake(stickRadius * 1.5f, stickRadius * 1.5f);
    [self addChild:skinStick];
}

-(void) addAttackButton
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    SneakyButtonSkinnedBase *attackBut = [[SneakyButtonSkinnedBase alloc] init];
    attackBut.position = ccp(winSize.width - 50.0f,50.0f );
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
}

-(void) setJoystickToHero{
    
    
    GameLayer* game = [GameLayer sharedGameLayer];
        
    Hero* hero = [game defaultHero];

    if (!(hero.joystick)){
    
    [hero setJoystick:sJoystick];
    }
}
@end
