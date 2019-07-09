//
//  DXCChatViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 29/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCSearchResultsViewController.h"
#import "DXCPopupOverlayAnimatedTransitioning.h"
#import "DXCSearchCellTableViewCell.h"
#import "DXCSearchPropertyViewController.h"

@interface DXCSearchResultsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;
@property (strong, nonatomic) UIViewController *hololensViewController;
@property (nonatomic) id<UIViewControllerTransitioningDelegate> transitioningDelegate;
@property (nonatomic,strong) NSArray *searchResultsArray;
@end

@implementation DXCSearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchResultsTableView.rowHeight=UITableViewAutomaticDimension;
    self.searchResultsTableView.estimatedRowHeight=30;
    self.searchResultsTableView.translatesAutoresizingMaskIntoConstraints=NO;
    
    _transitioningDelegate = [[DXCPopupOverlayTransitioningDelegate alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    self.hololensViewController = [storyboard instantiateViewControllerWithIdentifier:@"HololensViewController"];
    self.hololensViewController.modalPresentationStyle = UIModalPresentationCustom;
    [self.hololensViewController setTransitioningDelegate:[self transitioningDelegate]];
    self.searchResultsTableView.backgroundColor=[UIColor clearColor];
    
    self.searchResultsArray=@[@{@"Preview":@"First_House",@"Price":@"$450,000",@"Address":@"1/10 Derby St, Brighton, SA 5048",@"AuctionDate":@"today",@"HideButton":@NO},
                              @{@"Preview":@"Second_House",@"Price":@"$520,000",@"Address":@"299 Jasmine Rd, Brighton, SA 5048",@"AuctionDate":@"tomorrow",@"HideButton":@NO},
                              @{@"Preview":@"Third_House",@"Price":@"$495,000",@"Address":@"9 Carlo Ct, Brighton, SA 5048",@"AuctionDate":@"21/11/2017",@"HideButton":@NO},
                              ];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResultsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DXCSearchCellTableViewCell *cell;
    cell=(DXCSearchCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    [cell setViewIn3DButtonClicked:^(BOOL flag) {
         [self presentViewController:self.hololensViewController animated:YES completion:nil];
    }];
    [cell setFinanceButtonClicked:^(BOOL flag) {
        [self.tabBarController setSelectedIndex:2];
        DXCSearchPropertyViewController *searchPropertyViewController=(DXCSearchPropertyViewController *)self.tabBarController.parentViewController;
        searchPropertyViewController.searchResultsImageView.image=[UIImage imageNamed:@"greenbar"];
        searchPropertyViewController.financingImageView.image=[UIImage imageNamed:@"blackbar"];
    }];
    UIImageView *imageView=[cell viewWithTag:1];
    NSDictionary *currentDictionary=self.searchResultsArray[indexPath.row];
    [imageView setImage:[UIImage imageNamed:currentDictionary[@"Preview"]]];
    

    UILabel *priceLabel=(UILabel *)[cell viewWithTag:2];
    [priceLabel setText:currentDictionary[@"Price"]];;
    
    UILabel *addressLabel=(UILabel *)[cell viewWithTag:3];
    [addressLabel setText:currentDictionary[@"Address"]];;
    
    
    UILabel *dateLabel=(UILabel *)[cell viewWithTag:4];
    [dateLabel setText:currentDictionary[@"AuctionDate"]];;
    
    UIButton *view3D=(UIButton *)[cell viewWithTag:5];
    [view3D setHidden:((NSNumber *)currentDictionary[@"HideButton"]).boolValue];
    
    UIButton *financeButton=(UIButton *)[cell viewWithTag:6];
     [financeButton setHidden:((NSNumber *)currentDictionary[@"HideButton"]).boolValue];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

@end
