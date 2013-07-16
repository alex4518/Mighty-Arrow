//
//  Arrow.m
//  Mighty Sword
//
//  Created by alex on 16/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "Arrow.h"

@implementation Arrow


-(id) init
{
    if( (self=[super init]) )
    {
        
    }
    return self;
}

-(CGRect) arrowBoundingBox {
    
    return self.boundingBox;
}

@end
