//
//  SAEProgressIndicatorImageView.h
//  SAEWidget
//
//  Created by anilbhandarkar on 4/15/16.
//  Copyright © 2016 Schneider Electric. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  SAEProgressIndicatorImageView: Represents the image view that shows progress as circular ring.
 */

@interface SAEProgressIndicatorImageView : UIImageView

@property(nonatomic,strong) UIColor *progressCircleColor;
/**
 *  Method to showProgress with a circular Ring
 *
 *  @param progressRatio Represents Progress ratio float values from 0 to 1
 *
 *  @return void
 */
-(void)showProgressWithProgressRatio:(CGFloat)progressRatio;

///**
// *  Method to setup and start the animation of the UIImage with a series of static images
// *
// *  @param images The images to use for the animation
// *  @param frameRate The length of time that each image is displayed (in seconds)
// *  @param numRepeats The number of times to repeat the animation (0 => indefinite)
// *
// *  @return void
// */
//-(void)startImageAnimation:(NSArray *)images frameRate:(CGFloat)frameRate numRepeats:(NSUInteger)numRepeats;

/**
 *  Method to stop the animation of the UIImage
 *
 *  @param staticImage The image to set after the animation is stopped
 *
 *  @return void
 */
-(void)stopImageAnimation:(UIImage *)staticImage;

@end
