//
//  ShortestPathStep.m
//  Mighty Sword
//
//  Created by Alexandros Almpanis on 11/06/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "ShortestPathStep.h"

@implementation ShortestPathStep

- (id)initWithPosition:(CGPoint)pos
{
	if ((self = [super init])) {
		_position = pos;
		_gScore = 0;
		_hScore = 0;
		_parent = nil;
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@  pos=[%.0f;%.0f]  g=%d  h=%d  f=%d", [super description], self.position.x, self.position.y, self.gScore, self.hScore, [self fScore]];
}

- (BOOL)isEqual:(ShortestPathStep *)other
{
	return CGPointEqualToPoint(self.position, other.position);
}

- (int)fScore
{
	return self.gScore + self.hScore;
}

@end
