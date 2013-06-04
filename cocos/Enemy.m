//
//  Enemy.m
//  cocos
//
//  Created by alex on 04/06/2013.
//  Copyright 2013 alex. All rights reserved.
//

#import "Enemy.h"


@implementation Enemy

-(id) initWithType:(EnemyTypes)enemyType
{
    type = enemyType;
    NSString* enemyFrameName;
    
    _initialHitPoints = 1;
    
    switch (type)
    {
        case EnemyType1:
           // enemyFrameName = @"monster-a.png";
            _initialHitPoints = 1;
            break;
        case EnemyType2:
          //  enemyFrameName = @"monster-b.png";
            _initialHitPoints = 3;
            break;
        case EnemyType3:
           // enemyFrameName = @"monster-c.png";
            _initialHitPoints = 15;
            break;
        default:
            [NSException exceptionWithName:@"Enemy Exception"
                                    reason:@"unhandled enemy type"
                                  userInfo:nil];
            
            self=[super initWithSpriteFrameName:enemyFrameName];
            if (self)
            {
                // Create the game logic components
            }
    }
    
    return self;
}

+(id) enemyWithType:(EnemyTypes)enemyType
{
    return [[self alloc] initWithType:enemyType];
}

@end
