//
//  ShortestPathStep.h
//  Mighty Sword
//
//  Created by Alexandros Almpanis on 11/06/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//


@interface ShortestPathStep : NSObject

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) int gScore;
@property (nonatomic, assign) int hScore;
@property (nonatomic, assign) ShortestPathStep *parent;
    
- (id)initWithPosition:(CGPoint)pos;
- (int)fScore;
    

@end
