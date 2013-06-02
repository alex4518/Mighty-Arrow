#import "cocos2d.h"

@interface ColoredCircleSprite : CCNode <CCRGBAProtocol, CCBlendProtocol> {
	
	NSUInteger numberOfSegments;
    CGPoint *circleVertices_;
	
}

@property (nonatomic, readonly) GLubyte displayedOpacity;
@property (nonatomic, getter = isCascadeOpacityEnabled) BOOL cascadeOpacityEnabled;
@property (nonatomic, readonly) ccColor3B displayedColor;
@property (nonatomic, getter = isCascadeColorEnabled) BOOL cascadeColorEnabled;
@property (nonatomic, readwrite) float radius;
/** Opacity: conforms to CCRGBAProtocol protocol */
@property (nonatomic, readwrite) GLubyte opacity;
/** Opacity: conforms to CCRGBAProtocol protocol */
@property (nonatomic, readwrite) ccColor3B color;
/** BlendFunction. Conforms to CCBlendProtocol protocol */
@property (nonatomic,readwrite) ccBlendFunc blendFunc;

/** creates a Circle with color and radius */
+ (id) circleWithColor: (ccColor4B)color radius:(GLfloat)r;

/** initializes a Circle with color and radius */
- (id) initWithColor:(ccColor4B)color radius:(GLfloat)r;

- (BOOL) containsPoint:(CGPoint)point;

@end
