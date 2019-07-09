//
//  DXCLeftWelcomeViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 9/27/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCLeftWelcomeViewController.h"
#import "UIColor+HexToRGB.h"
#import "DXCCollapsableTableView.h"

@interface DXCLeftWelcomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray* metaData;
@property (weak, nonatomic) IBOutlet DXCCollapsableTableView *tableView;

@end

@implementation DXCLeftWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _metaData = @[@{@"title":@"Your Profile",@"Key":@[@"First Name",@"Last Name",@"Date of Birth",@"Contact Number",@"Email Address",@"Address",@"Household",@"Hobbies & Interests",@"Public Key"],@"value":@[@"Fay",@"Flevaras",@"06/11/1987 (30)",@"0466 856 291",@"fayf@gmail.com",@"232-242 Rouse Street, Brighton, Adelaide 5048",@"1 (you)",@"Kitesurfing, Cooking",@"MCowBQYDK2VwAyEArxfMQJFmEur4j2iPgFhopEg1Xk585bL2seeuCV54/WA="]},
                  @{@"title":@"Financial Summary",@"Key":@[@"graph",@"assets",@"liabilities"]},
                 ];
    self.tableView.translatesAutoresizingMaskIntoConstraints=NO;
    UINib* nib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:@"Header"];
    self.tableView.estimatedRowHeight=150;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.translatesAutoresizingMaskIntoConstraints=NO;
    self.tableView.initialCollapsedStatus = @{@0:@NO,@1:@YES};
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.allowsSelection = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"ffed00"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell;
    if (indexPath.section==0) {
        if (indexPath.row<([tableView numberOfRowsInSection:indexPath.section]-1)) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
            UILabel* lbl = [cell.contentView viewWithTag:2];
            
            NSArray* items = [self.metaData[indexPath.section] objectForKey:@"Key"];
            NSString* item = items[indexPath.row];
            
            [lbl setText:[NSString stringWithFormat:@"%@",item]];
            
            UILabel* lbl2 = [cell.contentView viewWithTag:3];
            
            NSArray* items2 = [self.metaData[indexPath.section] objectForKey:@"value"];
            NSString* item2 = items2[indexPath.row];
            
            [lbl2 setText:[NSString stringWithFormat:@"%@",item2]];
        } else {
           cell = [tableView dequeueReusableCellWithIdentifier:@"SpacingCell1"];
        }
        
        
        
    } else {
        if (indexPath.row<([tableView numberOfRowsInSection:indexPath.section]-1)) {
        NSArray* items = [self.metaData[indexPath.section] objectForKey:@"Key"];
        NSString* item = items[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:item];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"SpacingCell2"];
        }
        
    }
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.metaData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray* items = [self.metaData[section] objectForKey:@"Key"];
    return items.count+1;
}




#pragma mark - UITableViewDelegate
-(UITableViewHeaderFooterView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView* header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    UILabel* lbl = [header viewWithTag:1];
    
    NSString* headerTitle = [self.metaData[section] objectForKey:@"title"];
    UIImageView* imageView = [header viewWithTag:2];
    [imageView setImage:[UIImage imageNamed:@"accordionarrow"]];
    if([self.tableView isExpandedSection:section]){
        [imageView setImage:[UIImage imageNamed:@"accordioffarrow"]];
    }
    
    
    [lbl setText:[NSString stringWithFormat:@"%@",headerTitle]];
    
    
    if([self headerViewInitialized:header] == NO){
        UITapGestureRecognizer* tapGestr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onHeadTapped:)];
        tapGestr.cancelsTouchesInView = NO;
        
        [header addGestureRecognizer:tapGestr];
    }
    
    header.tag = section;
    return header;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 400)];
    [footer setBackgroundColor:[UIColor blackColor]];
    return footer;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView* header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    return header.frame.size.height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

#pragma mark - Event Handlers
-(void)onHeadTapped:(UITapGestureRecognizer*)gestr{
    UIView* headerView = [gestr view];
    
    
    [self.tableView toggleCollapsableSection:headerView.tag];
    
    
}

-(BOOL)headerViewInitialized:(UIView*)container{
    for (UIGestureRecognizer* gestr in container.gestureRecognizers) {
        if([gestr isKindOfClass:[UITapGestureRecognizer class]]){
            return YES;
        }
    }
    return NO;
}



@end
