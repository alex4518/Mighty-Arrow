//
//  Level1.h
//  Mighty Sword
//
//  Created by alex on 20/07/2013.
//  Copyright 2013 alex. All rights reserved.
//

#import "GameLayer.h"
#import "InputLayer.h"


@interface Level1 : GameLayer {
}

@property(nonatomic,readwrite) CGRect exitRect ;

+(Level1*) Level1Layer;


@end
