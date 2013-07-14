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
        
        hero = [game defaultHero];
        
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
    self.sJoystick=[[SneakyJoystick alloc] initWithRect: CGRectMake(0, 0, stickRadius, stickRadius)];
    self.sJoystick.autoCenter = YES;
    self.sJoystick.hasDeadzone = YES;
    self.sJoystick.deadRadius = 10;
    self.sJoystick.isDPad = YES;
    self.sJoystick.numberOfDirections = 4;
    SneakyJoystickSkinnedBase* skinStick=[[SneakyJoystickSkinnedBase alloc] init];
    skinStick.joystick = self.sJoystick;
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

        
    

}

-(void) setJoystickToHero {
    
    if (!(hero.joystick)){
    
    [hero setJoystick:self.sJoystick];
    [hero setAttackButton:attackButton];
    }
}



@end
