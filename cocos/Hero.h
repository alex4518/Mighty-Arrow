//
//  Hero.h
//  cocos
//
//  Created by alex on 04/06/2013.
//  Copyright 2013 alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SneakyJoystick.h"
#import "SneakyButton.h"
#import "Enemy.h"

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

@property (nonatomic, strong) CCAction *frontAttackAction;

@property (nonatomic,strong) SneakyJoystick* joystick;
@property (nonatomic,assign) SneakyButton *attackButton;

@property (nonatomic,assign) CCSprite* arrow;




- (CGRect) heroBoundingBox;
- (CGRect) arrowBoundingBox;

@end
