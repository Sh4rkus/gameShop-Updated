//
//  ShopTableViewController.m
//  gameShop
//
//  Created by student on 4/4/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopTableViewController.h"
#import "ShopDataSource.h"
#import "Skin.h"

@interface ShopTableViewController ()

@property(nonatomic) ShopDataSource *dataSource;
@property(nonatomic) UIActivityIndicatorView *activityIndicator;

@end

enum { ITEM_VIEW_HEIGHT = 150, GAP_BTWN_VIEWS = 5, IMAGE_HEIGHT = 80, IMAGE_WIDTH = 80 };

static NSString *CellIdentifier = @"Cell";

@implementation ShopTableViewController

-(id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if(self) {
        //Custom Initialization
    }
    self.dataSource = [[ShopDataSource alloc] initWithSkins];
    
    self.title = @"Ye Olde Shoppe";
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    //self.dataSource.delegate = self
    self.tableView.allowsSelection = NO;
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityIndicator setCenter: self.view.center];
    [self.view addSubview: self.activityIndicator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dataSourceReadyForUse:(ShopDataSource *) dataSource
{
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.{
        [self.activityIndicator startAnimating];
        [self.activityIndicator setHidesWhenStopped: YES];
    
    return 1;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ITEM_VIEW_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"Number of rows in the table: %@", @([self.dataSource numberOfSkins]));
    return [self.dataSource numberOfSkins];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell = [self skinViewForIndex:[indexPath row] withTableViewCell:cell];
    
    return cell;
}

-(void) refreshTableView: (UIRefreshControl *) sender
{
    [self.tableView reloadData];
    [sender endRefreshing];
}

/*- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Skin *skin = [self.dataSource skinAtIndex:[indexPath row]];
    MoviesDetailedViewController *mController = [[MoviesDetailedViewController alloc] initWithMoive: movie];
    [self.navigationController pushViewController:mController animated:YES];
}*/

-(UITableViewCell *) skinViewForIndex: (NSInteger) rowIndex withTableViewCell: (UITableViewCell *) cell
{
    enum {IMAGE_VIEW_TAG = 20, MAIN_VIEW_TAG = 50, LABEL_TAG = 30};
    
    Skin *skin = [self.dataSource skinAtIndex: rowIndex];
    

    UIView *view = [cell viewWithTag: MAIN_VIEW_TAG];
    
    if( view ) {
        UIImageView *iv = (UIImageView *)[view viewWithTag: IMAGE_VIEW_TAG];
        NSArray *views = [iv subviews];
        for( UIView *v in views )
            [v removeFromSuperview];
        iv.image = [skin imageForListEntry];
        //UILabel *aLabel = (UILabel *) [view viewWithTag: LABEL_TAG];
        //aLabel.attributedText = [skin skinForListEntry];
        return cell;
    }
    
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    CGRect viewFrame = CGRectMake(0, 0, bounds.size.width, ITEM_VIEW_HEIGHT);
    
    UIView *thisView = [[UIView alloc] initWithFrame: viewFrame];
    
    UIImage *img = [skin imageForListEntry];
    CGRect imgFrame = CGRectMake(20, (viewFrame.size.height - IMAGE_HEIGHT) / 2 + 20, IMAGE_WIDTH, IMAGE_HEIGHT );
    UIImageView *iView = [[UIImageView alloc] initWithImage: img];
    iView.tag = IMAGE_VIEW_TAG;
    iView.frame = imgFrame;
    [thisView addSubview: iView];
    
    UILabel *skinNameLabel = [[UILabel alloc]
                               initWithFrame:CGRectMake(0, -55,
                                                        viewFrame.size.width - 10,
                                                        viewFrame.size.height -5)];
    UILabel *skinDescLabel = [[UILabel alloc]
                              initWithFrame:CGRectMake(0, -40,
                                                       viewFrame.size.width - 10,
                                                       viewFrame.size.height -5)];
    
    skinNameLabel.tag = LABEL_TAG;
    skinDescLabel.tag = 40;
    
    NSAttributedString *desc = [skin descriptionForListEntry];
    NSAttributedString *name = [skin nameForListEntry];
    NSString *price = [skin price];
    
    skinNameLabel.textAlignment = NSTextAlignmentCenter;
    skinNameLabel.attributedText = name;
    skinNameLabel.numberOfLines = 0;
    
    skinDescLabel.textAlignment = NSTextAlignmentCenter;
    skinDescLabel.attributedText = desc;
    skinDescLabel.numberOfLines = 0;
                                
    [thisView addSubview: skinNameLabel];
    [thisView addSubview: skinDescLabel];
    thisView.tag = MAIN_VIEW_TAG;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(250, 50, 100, 80)];
    
    [button setTitle:price forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button addTarget:self action:@selector(makePurchase:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSURL *cellUrl = [[NSURL alloc] initWithString:@"http://www.churchfurniturecanada.ca/wp-content/uploads/2013/03/light-brown-vintage-soft-leather-texture-500x375.jpg"];
    NSData *cellData = [[NSData alloc]initWithContentsOfURL:cellUrl];
    UIImage *cellImg = [[UIImage alloc]initWithData:cellData];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:cellImg];
    
    [[cell contentView] addSubview:thisView];
    [cell addSubview:button];
    return cell;
}

-(void) makePurchase: (id)sender
{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    Skin *skin = [self.dataSource skinAtIndex: indexPath.row];
    
    if(![self.dataSource.unlockedSkins containsObject:skin])
        [self.dataSource.unlockedSkins insertObject:skin atIndex:indexPath.row];
    
    [sender setTitle:@"Purchased"forState:UIControlStateNormal];
    [sender setBackgroundColor:[UIColor blueColor]];
    
    NSString * skinName = [skin name];
    NSLog(@"%@ Purchased", skinName);
    
    NSLog(@"Unlock Array : %@", self.dataSource.unlockedSkins);
}

@end