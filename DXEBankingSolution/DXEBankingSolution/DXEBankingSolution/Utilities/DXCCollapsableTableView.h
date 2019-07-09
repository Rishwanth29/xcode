//
//  DXCCollapsableTableView.h
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 29/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DXCCollapsableTableView : UITableView
@property  (nonatomic,assign) BOOL initialCollapsedAll;

/*
 * @parameter initialCollapsedStatus
 */
@property (nonatomic,strong) NSDictionary* initialCollapsedStatus;

/** Returns YES if the specified section is expanded. */
- (BOOL)isExpandedSection:(NSInteger)section;

/** Collapses all expanded sections.
 */
- (void)collapseAllSections;

/** Expand all collapsed sections.
 */
-(void)expandAllSections;

/**
 *  Toggle section's collapsable state between collapsed and expanded
 */
-(void)toggleCollapsableSection:(NSInteger)section;
@end
