//
//  DXCPopupOverlayAnimatedTransitioning.h
//
//  Created by anilbhandarkar on 4/1/16
//

@import UIKit;

@interface DXCPopupOverlayAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic) BOOL isPresentation;
@end

@interface DXCPopupOverlayTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>
@end
