//
//  getContactList.m
//  myContactList
//
//  Created by Fatih Türker on 31.08.2012.
//  Copyright (c) 2012 Fatih Türker. All rights reserved.
//

#import "getContactList.h"
#import "myContacts.h"
@interface getContactList ()

@end

@implementation getContactList
@synthesize nameAR, phoneAR;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSString*)userName
{
    NSString* recoveredString = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    return recoveredString;
}
-(NSString*)password
{
    NSString* recoveredString = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    return recoveredString;
}
+ (UIColor*)myColor2 {
    return [UIColor colorWithRed:0.0f/255.0f green:64.0f/255.0f blue:128.0f/255.0f alpha:1.0f];
}
-(IBAction) getContacts{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@" " delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [alert addSubview:progress];
    [progress startAnimating];
    [alert show];
    nameAR = [[NSMutableArray alloc]init];
    phoneAR = [[NSMutableArray alloc]init];
    NSString *post = [NSString stringWithFormat:@"&username=%@&password=%@",[self userName],[self password]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://fatih.demiraytelekom.com/myContactList/getContacts.php"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *regexString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];

    regexString = [regexString stringByReplacingOccurrencesOfString:@"B#304;"
                                                         withString:@"İ"];
    regexString = [regexString stringByReplacingOccurrencesOfString:@"B#305;"
                                                         withString:@"ı"];
    regexString = [regexString stringByReplacingOccurrencesOfString:@"BOuml;"
                                                         withString:@"Ö"];
    regexString = [regexString stringByReplacingOccurrencesOfString:@"Bouml;"
                                                         withString:@"ö"];
    regexString = [regexString stringByReplacingOccurrencesOfString:@"BUuml;"
                                                         withString:@"Ü"];
    regexString = [regexString stringByReplacingOccurrencesOfString:@"Buuml;"
                                                         withString:@"ü"];
    
    regexString = [regexString stringByReplacingOccurrencesOfString:@"BCcedil;"
                                                         withString:@"Ç"];
    regexString = [regexString stringByReplacingOccurrencesOfString:@"Bccedil;"
                                                         withString:@"ç"];
    regexString = [regexString stringByReplacingOccurrencesOfString:@"B#286;"
                                                         withString:@"Ğ"];
    regexString = [regexString stringByReplacingOccurrencesOfString:@"B#287;"
                                                         withString:@"ğ"];
    regexString = [regexString stringByReplacingOccurrencesOfString:@"B#350;"
                                                         withString:@"Ş"];
    regexString = [regexString stringByReplacingOccurrencesOfString:@"B#351;"
                                                         withString:@"ş"];
    //NSLog(@"%@",regexString);
    
    if([regexString length] != 0){
        
        NSString *tryingNewRegexForImages = @"<contact><contactName>(.*?)</contactName><phone>(.*?)</phone></contact>";
        NSRegularExpression *regExpForImages = [NSRegularExpression
                                                regularExpressionWithPattern:tryingNewRegexForImages
                                                options:NSRegularExpressionCaseInsensitive | NSRegularExpressionSearch
                                                error:nil];
        
        //Getting Parsed Images
        NSArray *Datas = [regExpForImages matchesInString:regexString options:0
                                                    range:NSMakeRange(0, [regexString length])];
        
        for (NSTextCheckingResult *match in Datas) {
            //For cNames
            NSRange rangeContactName = [match rangeAtIndex:1];
            NSString *replacedStringName = [regexString substringWithRange:rangeContactName];
            [nameAR addObject:replacedStringName];
            
            //For Telephone
            NSRange rangeTelephone = [match rangeAtIndex:2];
            NSString *replacedStringTelephone = [regexString substringWithRange:rangeTelephone];
            [phoneAR addObject:replacedStringTelephone];
            
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:nameAR forKey:@"nameArray"];
    [[NSUserDefaults standardUserDefaults] setObject:phoneAR forKey:@"phoneArray"];
    [alert dismissWithClickedButtonIndex:-1 animated:YES];
    myContacts *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"myContacts"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
