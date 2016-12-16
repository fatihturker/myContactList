//
//  myContactListViewController.m
//  myContactList
//
//  Created by Fatih Türker on 29.08.2012.
//  Copyright (c) 2012 Fatih Türker. All rights reserved.
//

#import "myContactListViewController.h"

@interface myContactListViewController ()

@end

@implementation myContactListViewController
@synthesize syncButton;
@synthesize cleanButton;
@synthesize personNames,personPhones;
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
-(IBAction) saveContacts{
     
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@" " delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [alert addSubview:progress];
    [progress startAnimating];
    [alert show];
   [self cleanContacts2];
    ABAddressBookRef _addressBookRef = ABAddressBookCreate ();
    NSArray* allPeople = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(_addressBookRef);
    //personNames = [[NSMutableArray alloc] initWithCapacity:[allPeople count]];
    //personPhones = [[NSMutableArray alloc] initWithCapacity:[allPeople count]];
    for (id record in allPeople) {
        CFTypeRef phoneProperty = ABRecordCopyValue((__bridge ABRecordRef)record, kABPersonPhoneProperty);
        NSArray *phones = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(phoneProperty);
        CFRelease(phoneProperty);
        for (NSString *phone in phones) {
            NSString* compositeName = (__bridge NSString *)ABRecordCopyCompositeName((__bridge ABRecordRef)record);
            NSString* name = [NSString stringWithFormat:@"%@",compositeName];
            NSString* phoneNumber = [NSString stringWithFormat:@"%@",phone];
            NSLog(@"%@",name);
            NSLog(@"%@",phoneNumber);
            NSString *post = [NSString stringWithFormat:@"&username=%@&password=%@&cName=%@&pNumber=%@",[self userName],[self password],name,phoneNumber];
            NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://fatih.demiraytelekom.com/myContactList/saveContacts.php"]]];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
            [request setHTTPBody:postData];
          
                NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                NSString *regexString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
                NSLog(@"%@",regexString);

          //  [personNames addObject:name];
            //[personPhones addObject:phoneNumber];
        }
    }
     [alert dismissWithClickedButtonIndex:-1 animated:YES];
    UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Your Contact List Has Been Synced." message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert2 show];
    
}
-(IBAction) cleanContacts{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@" " delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [alert addSubview:progress];
    [progress startAnimating];
    [alert show];
    NSString *post = [NSString stringWithFormat:@"&username=%@&password=%@",[self userName],[self password]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://fatih.demiraytelekom.com/myContactList/cleanContacts.php"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *regexString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"%@",regexString);
    [alert dismissWithClickedButtonIndex:-1 animated:YES];
    UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Your Contact List Has Been Cleaned." message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert2 show];

}

-(void) cleanContacts2{
    NSString *post = [NSString stringWithFormat:@"&username=%@&password=%@",[self userName],[self password]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://fatih.demiraytelekom.com/myContactList/cleanContacts.php"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *regexString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"%@",regexString);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSyncButton:nil];
    [self setCleanButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
