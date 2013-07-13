//
//  Skeleton.h
//  Mighty Sword
//
//  Created by alex on 09/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "Enemy.h"

@interface Skeleton : Enemy {
   
    CGPoint velocity;
}

+(id) skeleton;


@property (nonatomic, strong) CCAction *walkRightAction;
@property (nonatomic, strong) CCAction *walkLeftAction;
@property (nonatomic, strong) CCAction *walkUpAction;
@property (nonatomic, strong) CCAction *walkDownAction;



-(void)initAnimations;


@end
