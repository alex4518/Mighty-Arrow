//
//  IntroLayer.h
//  cocos
//
//  Created by alex on 06/03/2013.
//  Copyright alex 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameLayer.h"
#import "MainMenuLayer.h"

#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"

// GameLayer
@interface IntroLayer : CCLayer

// returns a CCScene that contains the GameLayer as the only child
+(CCScene *) scene;

@end
