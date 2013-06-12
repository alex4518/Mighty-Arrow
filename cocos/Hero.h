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
#import "Enemy.h"

@interface Hero : CCSprite {    
}

+(id) hero;

@property (nonatomic, strong) CCAction *walkRightAction;
@property (nonatomic, strong) CCAction *walkLeftAction;
@property (nonatomic, strong) CCAction *walkUpAction;
@property (nonatomic, strong) CCAction *walkDownAction;

@property (nonatomic,strong) SneakyJoystick* joystick;

- (CGRect) heroBoundingBox;
@end
