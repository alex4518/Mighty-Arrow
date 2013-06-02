
#import "ColoredCircleSprite.h"

@interface ColoredCircleSprite (privateMethods)
- (void) updateContentSize;
- (void) updateColor;
@end


@implementation ColoredCircleSprite

+ (id) circleWithColor: (ccColor4B)color radius:(GLfloat)r
{
	return [[self alloc] initWithColor:color radius:r];
}

- (void) updateDisplayedOpacity:(GLubyte)opacity
{
    
}

- (void) updateDisplayedColor:(ccColor3B)color
{
    
}

- (id) initWithColor:(ccColor4B)color radius:(GLfloat)r
{
	if( (self=[self init]) ) {
		self.radius	= r;
		
		_color.r = color.r;
		_color.g = color.g;
		_color.b = color.b;
		_opacity = color.a;
	}
	return self;
}

- (void) dealloc
{
	free(circleVertices_);
    [super dealloc];
}

- (id) init
{
	if((self = [super init])){
		_radius				= 10.0f;
		numberOfSegments	= 36U;
		
        //self.shaderProgram = [[CCShaderCache sharedShaderCache] programForKey:kCCShader_PositionColor];
        
			// default blend function
		_blendFunc = (ccBlendFunc) { CC_BLEND_SRC, CC_BLEND_DST };
		
		_color.r =
		_color.g =
		_color.b = 0U;
		_opacity = 255U;
		
		circleVertices_ = (CGPoint*) malloc(sizeof(CGPoint)*(numberOfSegments));
		if(!circleVertices_){
			NSLog(@"Ack!! malloc in colored circle failed");
			return nil;
		}
		memset(circleVertices_, 0, sizeof(CGPoint)*(numberOfSegments));
		
		self.radius			= _radius;
	}
	return self;
}

-(void) setRadius: (float) size
{
	_radius = size;
	const float theta_inc	= 2.0f * 3.14159265359f/numberOfSegments;
	float theta				= 0.0f;
	
	for(int i=0; i<numberOfSegments; i++)
	{
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
		float j = _radius * cosf(theta) + _position.x;
		float k = _radius * sinf(theta) + _position.y;
#elif defined(__MAC_OS_X_VERSION_MAX_ALLOWED)
		float j = radius_ * cosf(theta) + position_.x;
		float k = radius_ * sinf(theta) + position_.y;
#endif				
		
		circleVertices_[i] = ccp(j,k);
		
		theta += theta_inc;
	}
	
	[self updateContentSize];
}

-(void) setContentSize: (CGSize) size
{
	self.radius	= size.width/2;
}

- (void) updateContentSize
{
	[super setContentSize:CGSizeMake(_radius*2, _radius*2)];
}

- (void)draw
{		
	ccDrawSolidPoly(circleVertices_, numberOfSegments, ccc4f(_color.r/255.0f, _color.g/255.0f, _color.b/255.0f, _opacity/255.0f));
}

#pragma mark Protocols
	// Color Protocol

-(void) setColor:(ccColor3B)color
{
	_color = color;
}

-(void) setOpacity: (GLubyte) o
{
	_opacity = o;
	[self updateColor];
}

#pragma mark Touch

- (BOOL) containsPoint:(CGPoint)point
{
	float dSq = point.x * point.x + point.y * point.y;
	float rSq = _radius * _radius;
	return (dSq <= rSq );
}

- (NSString*) description
{
	return [NSString stringWithFormat:@"<%@ = %8@ | Tag = %i | Color = %02X%02X%02X%02X | Radius = %1.2f>", [self class], self, _tag, _color.r, _color.g, _color.b, _opacity, _radius];
}

@end