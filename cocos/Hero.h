//
//  Hero.h
//  cocos
//
//  Created by alex on 04/06/2013.
//  Copyright 2013 alex. All rights reserved.
//

#import "SneakyJoystick.h"
#import "SneakyButton.h"
#import "Enemy.h"
#import "Constants.h"
#import <OpenAL/al.h>


typedef enum
{
    DirectionRight = 0,
    DirectionLeft,
    DirectionUp,
    DirectionDown,
    
} Direction;

@interface Hero : CCSprite {
    Direction myDirection;
    int realX;
    int realY;
}

+(id) hero;

@property (nonatomic, strong) CCAction *walkRightAction;
@property (nonatomic, strong) CCAction *walkLeftAction;
@property (nonatomic, strong) CCAction *walkUpAction;
@property (nonatomic, strong) CCAction *walkDownAction;

@property (nonatomic, strong) SneakyJoystick* joystick;
@property (nonatomic, assign) SneakyButton *attackButton;

@property (nonatomic, strong) CCSprite* arrow;


@property (readwrite, nonatomic) int level;
@property (readwrite, nonatomic) int heroDamageFromLevelUp;
@property (readwrite, nonatomic) int heroHealth;
@property (readwrite, nonatomic) int currentXP;
@property (nonatomic, assign) ALuint soundEffectID;


@property (readwrite, nonatomic) BOOL canShoot;

- (int) getDamage;
- (void) recieveXP:(int)xpPoints;

- (CGRect) heroBoundingBox;
- (CGRect) arrowBoundingBox;

@end
