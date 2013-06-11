//
//  Enemy.h
//  cocos
//
//  Created by alex on 04/06/2013.
//  Copyright 2013 alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ShortestPathStep.h"

typedef enum
{
    EnemyType1 = 0,
    EnemyType2,
    EnemyType3,
    
    EnemyType_MAX,
} EnemyTypes;

id actionMoveX;
id actionMoveY;
id actionMoveDone;

@interface Enemy : CCSprite {
    
    EnemyTypes type;
}

@property (readonly, nonatomic) int initialHitPoints;
@property (readonly, nonatomic) int hitPoints;

@property (nonatomic, retain) NSMutableArray *spOpenSteps;
@property (nonatomic, retain) NSMutableArray *spClosedSteps;
@property (nonatomic, retain) NSMutableArray *shortestPath;



+(id) enemyWithType:(EnemyTypes)enemyType;
- (void)moveTowardHero;
- (void)insertInOpenSteps:(ShortestPathStep *)step;
- (int)computeHScoreFromCoord:(CGPoint)fromCoord toCoord:(CGPoint)toCoord;
- (int)costToMoveFromStep:(ShortestPathStep *)fromStep toAdjacentStep:(ShortestPathStep *)toStep;
- (void)constructPathAndStartAnimationFromStep:(ShortestPathStep *)step;
- (void)popStepAndAnimate;



@end

