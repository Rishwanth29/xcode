//
//  SAEProgressIndicatorImageView.m
//  SAEWidget
//
//  Created by anilbhandarkar on 4/15/16.
//  Copyright © 2016 Schneider Electric. All rights reserved.
//

#import "SAEProgressIndicatorImageView.h"


@interface SAEProgressIndicatorImageView()
@property (nonatomic,strong) CAShapeLayer *progressLayer;
@property (nonatomic) CGFloat progressRatio;
@end

@implementation SAEProgressIndicatorImageView
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(void)commonInit {
    self.progressRatio=0;
}
-(void)layoutSubviews {
    if (self.progressRatio) {
        self.layer.borderWidth = 2;
        if (!self.progressCircleColor) {
            self.progressCircleColor=[UIColor greenColor];
        }
        self.layer.borderColor=self.progressCircleColor.CGColor;
        NSInteger radius=(self.frame.size.height/2.0-1);
        self.layer.cornerRadius = radius;
        self.progressLayer.strokeColor = self.progressCircleColor.CGColor;
    } else {
        self.layer.borderWidth = 0;
        self.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor clearColor]);
    }
    
    [super layoutSubviews];
}
-(void)clearProgressLayer {
    if ([self.layer.sublayers containsObject:self.progressLayer]) {
        self.progressLayer.strokeStart=0;
        self.progressLayer.strokeEnd=0;
        [self.progressLayer removeFromSuperlayer];
        [self layoutSubviews];
     }
}

-(void)animateWithValue:(NSNumber *)fromValue toValue:(NSNumber *)toValue {
    [self layoutSubviews];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 0.0;
    self.progressRatio=toValue.floatValue;
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.delegate=self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    self.progressLayer.strokeEnd=self.progressRatio;
    [self.progressLayer addAnimation:animation forKey:@"drawCircleAnimation"];
}

-(void)showProgressWithProgressRatio:(CGFloat)progressRatio {
    self.progressRatio=progressRatio;
    
    if (progressRatio==0) {
        [self clearProgressLayer];
    } else {
        NSInteger radius=(self.frame.size.height/2.0-1);
        if (![self.layer.sublayers containsObject:self.progressLayer]&&self.frame.size.width&&self.frame.size.height) {
            CGFloat startAngle=-M_PI_2;
            CGFloat endAngle=startAngle+2*M_PI;
            self.progressLayer = [CAShapeLayer layer];
            self.progressLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:(radius-1) startAngle:startAngle endAngle:endAngle clockwise:YES].CGPath;
            self.progressLayer.fillColor = [UIColor clearColor].CGColor;
            self.progressLayer.lineWidth = 3;
            self.progressLayer.strokeStart=0;
            self.progressLayer.strokeEnd=0;
            [self.layer addSublayer:self.progressLayer];
             [self animateWithValue:@(progressRatio) toValue:@(progressRatio)];
        }
    }
    
    if (self.progressLayer.strokeEnd<progressRatio) {
        [self animateWithValue:@(progressRatio) toValue:@(progressRatio)];
    } else
        [self animateWithValue:@(self.progressLayer.strokeEnd) toValue:@(progressRatio)];
    
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
 // [self clearProgressLayer];
}

//-(void)startImageAnimation:(NSArray *)images frameRate:(CGFloat)frameRate numRepeats:(NSUInteger)numRepeats {
//    // basic sanity check on parameters
//    unsigned long numImages = [images count];
//    NSAssert(images && (numImages > 1),@"At least 2 static images are required for the UIImageView animation");
//    NSAssert(frameRate > 0,@"The frameRate for the UIImageView animation must be greater than 0");
//
//    // if already animating, stop it so we can start a new animation
//    if([self isAnimating])
//        [self stopAnimating];
//    
//    // setup the animation
//    self.image = [images objectAtIndex:0];
//    self.animationImages = images;
//    self.animationDuration = numImages * frameRate;
//    self.animationRepeatCount = numRepeats;
//    
//    // start the animation
//    [self startAnimating];
//}

-(void)stopImageAnimation:(UIImage *)staticImage {
    // stop animation if currently running
    if([self isAnimating]) {
        [self stopAnimating];
        self.image = staticImage;
    }
}


@end
