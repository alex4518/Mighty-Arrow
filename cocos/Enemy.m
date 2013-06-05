//
//  Enemy.m
//  cocos
//
//  Created by alex on 04/06/2013.
//  Copyright 2013 alex. All rights reserved.
//

#import "Enemy.h"
#import "Hero.h"
#import "GameLayer.h"


@implementation Enemy

-(id) initWithType:(EnemyTypes)enemyType
{
    NSString* enemyFrameName;
    
    
    switch (enemyType)
    {
        case EnemyType1:
            enemyFrameName = @"enemy.png";
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
    }
            self = [super initWithSpriteFrameName:enemyFrameName];
            if (self)
            {
                [self scheduleUpdate];
                
            }
    
    
    return self;
}

+(id) enemyWithType:(EnemyTypes)enemyType
{
    return [[self alloc] initWithType:enemyType];
}

// callback. starts another iteration of enemy movement.
- (void) enemyMoveFinished:(id)sender {
    CCSprite *enemy = (CCSprite *)sender;
    
    [self animateEnemy: enemy];
}

// a method to move the enemy 10 pixels toward the player
- (void) animateEnemy:(CCSprite*)enemy
{
    GameLayer* game = [GameLayer sharedGameLayer];

    Hero* hero = [game defaultHero];
    
    // speed of the enemy
    ccTime actualDuration = 0.3;
    
    // Create the actions
     actionMove = [CCMoveBy actionWithDuration:actualDuration
                                        position:ccpMult(ccpNormalize(ccpSub(hero.position,enemy.position)), 10)];
     actionMoveDone = [CCCallFuncN actionWithTarget:self
                                             selector:@selector(enemyMoveFinished:)];
    [enemy runAction:
     [CCSequence actions:actionMove, actionMoveDone, nil]];
}

-(void) update:(ccTime)delta{
   
    GameLayer* game = [GameLayer sharedGameLayer];
    
    Hero* hero = [game defaultHero];
    
    NSLog(@"x:%f",hero.position.x - self.position.x);
    NSLog(@"y:%f",hero.position.y - self.position.y);

    
    if ((abs(hero.position.x - self.position.x) < 400.0f) &&( abs(hero.position.x - self.position.x) > 30.0f) && ((abs(hero.position.y - self.position.y) < 400.0f) && (abs(hero.position.y - self.position.y) > 30.0f))) {
        if (self.numberOfRunningActions == 0) {
    
                [self animateEnemy:self];
        }
    }

    else [self stopAction:actionMove];
}


@end
