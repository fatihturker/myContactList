//
//  myContacts.m
//  myContactList
//
//  Created by Fatih Türker on 31.08.2012.
//  Copyright (c) 2012 Fatih Türker. All rights reserved.
//

#import "myContacts.h"
@interface myContacts ()

@end

@implementation myContacts
@synthesize datasource, phoneAR;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSString*)allContacts
{
    NSString* recoveredString = [[NSUserDefaults standardUserDefaults] objectForKey:@"allContacts"];
    return recoveredString;
}
-(NSMutableArray*)nameArr
{
    NSMutableArray* recoveredString = [[NSUserDefaults standardUserDefaults] objectForKey:@"nameArray"];
    return recoveredString;
}
-(NSMutableArray*)phoneArr
{
    NSMutableArray* recoveredString = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneArray"];
    return recoveredString;
}
-(IBAction)callPhone: (id) sender {
    int index = [sender tag];
    NSString *urlStr = [NSString stringWithFormat:@"tel:%@",[phoneAR objectAtIndex:index]];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@" "
                                                         withString:@""];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@")"
                                               withString:@""];
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"("
                                               withString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}
- (void)viewDidLoad
{
    datasource = [[NSMutableArray alloc]init];
    phoneAR = [[NSMutableArray alloc]init];
    [self setupArray];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)setupArray{
    
    for(int i=0;i<[[self nameArr] count];i++){
        [datasource addObject:[[self nameArr] objectAtIndex:i]];
        [phoneAR addObject:[[self phoneArr] objectAtIndex:i]];
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[self nameArr] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    // Configure the cell...
    
    //---------- CELL BACKGROUND IMAGE -----------------------------
     /*
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.frame];
    UIImage *image = [UIImage imageNamed:@"LightGrey.png"];
    imageView.image = image;
    cell.backgroundView = imageView;
     */
    UIFont *titleFont = [UIFont fontWithName:@"Georgia-BoldItalic" size:18.0];
    [[cell textLabel] setFont:titleFont];
    
    UIFont *detailFont = [UIFont fontWithName:@"Georgia" size:16.0];
    [[cell detailTextLabel] setFont:detailFont];
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    [[cell detailTextLabel] setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.text = [datasource objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [phoneAR objectAtIndex:indexPath.row];
    
    UIImage *image=[UIImage imageNamed:@"Phone.png"];
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [buyButton setBackgroundImage:image forState:UIControlStateNormal];
    buyButton.frame = CGRectMake(220, 5, 48, 48);
    [buyButton setTag:indexPath.row];
    [buyButton addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:buyButton];
    //Arrow
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

//----------------------TABLEVIEWCELL HEIGHT -------------------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
