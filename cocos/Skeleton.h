//
//  Skeleton.h
//  Mighty Sword
//
//  Created by alex on 09/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "Enemy.h"
#import "Constants.h"

@interface Skeleton : Enemy {
   
    CGPoint velocity;
}

+(id) skeleton;


@property (nonatomic, strong) CCAnimation *walkRightAnim;
@property (nonatomic, strong) CCAnimation *walkLeftAnim;
@property (nonatomic, strong) CCAnimation *walkUpAnim;
@property (nonatomic, strong) CCAnimation *walkDownAnim;



-(void)initAnimations;


@end
