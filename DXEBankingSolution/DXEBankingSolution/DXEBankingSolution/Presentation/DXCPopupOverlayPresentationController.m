//
//  DXCPopupOverlayPresentationController.m
//
//  Created by anilbhandarkar on 4/1/16
//


#import "DXCPopupOverlayPresentationController.h"
#import "DXCPopupOverlayAnimatedTransitioning.h"


@implementation DXCPopupOverlayPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if(self)
    {
        [self prepareDimmingView];
    }
    
    return self;
}

- (void)presentationTransitionWillBegin {
    // Here, we'll set ourselves up for the presentation

    UIView* containerView = [self containerView];
    UIViewController* presentedViewController = [self presentedViewController];

    // Make sure the dimming view is the size of the container's bounds, and fully transparent

    [[self dimmingView] setFrame:[containerView bounds]];
    [[self dimmingView] setAlpha:0.0];

    // Insert the dimming view below everything else

    [containerView insertSubview:[self dimmingView] atIndex:0];
    
    if([presentedViewController transitionCoordinator])
    {
        [[presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {

            // Fade the dimming view to be fully visible

            [[self dimmingView] setAlpha:1.0];
        } completion:nil];
    }
    else
    {
        [[self dimmingView] setAlpha:1.0];
    }
}

- (void)dismissalTransitionWillBegin {
    // Here, we'll undo what we did in -presentationTransitionWillBegin. Fade the dimming view to be fully transparent

    if([[self presentedViewController] transitionCoordinator])
    {
        [[[self presentedViewController] transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            [[self dimmingView] setAlpha:0.0];
        } completion:nil];
    }
    else
    {
        [[self dimmingView] setAlpha:0.0];
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyle {
    // When we adapt to a compact width environment, we want to be over full screen
    return UIModalPresentationOverFullScreen;
}

- (CGSize)sizeForChildContentContainer:(id <UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    
        return CGSizeMake(floorf(549),
                      444);
    
}

- (void)containerViewWillLayoutSubviews {
    // Before layout, make sure our dimmingView and presentedView have the correct frame
    [[self dimmingView] setFrame:[[self containerView] bounds]];
    [[self presentedView] setFrame:[self frameOfPresentedViewInContainerView]];
    [self presentedView].center=[self containerView].center;
}

- (BOOL)shouldPresentInFullscreen {
    // This is a full screen presentation
    return YES;
}

- (CGRect)frameOfPresentedViewInContainerView {
    // Return a rect with the same size as -sizeForChildContentContainer:withParentContainerSize:, and right aligned
    CGRect presentedViewFrame = CGRectZero;
    CGRect containerBounds = [[self containerView] bounds];
    
    presentedViewFrame.size = [self sizeForChildContentContainer:(UIViewController<UIContentContainer> *)[self presentedViewController]
                                         withParentContainerSize:containerBounds.size];
    presentedViewFrame.origin.y=0;
    return presentedViewFrame;
}



- (void)prepareDimmingView {
    _dimmingView = [[UIView alloc] init];
    [[self dimmingView] setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.85]];
    [[self dimmingView] setAlpha:1.0];
    
}


@end
