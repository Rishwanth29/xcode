

#import <UIKit/UIKit.h>

//! Project version number for AIExpert.
FOUNDATION_EXPORT double AIExpertVersionNumber;

//! Project version string for AIExpert.
FOUNDATION_EXPORT const unsigned char AIExpertVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <AIExpert/PublicHeader.h>

@protocol AIChatViewProtocol
-(void)searchResultsWithFlag:(BOOL)flag;
@end

@protocol AIChatSearchResultsViewProtocol
-(void)viewSearchResults;
@end

#import <Foundation/Foundation.h>

@interface AIExpert : NSObject
@property (nonatomic,strong) NSDictionary *initialConversionDict;
-(UIView *)view;
-(UIViewController *)controller;
-(void)setUp;
-(void)searchResultsController:(UIViewController<AIChatViewProtocol>*)searchResultsController;
-(void)searchPropertyController:(UIViewController<AIChatSearchResultsViewProtocol> *)searchPropertyController;
@end
