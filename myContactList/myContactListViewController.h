//
//  myContactListViewController.h
//  myContactList
//
//  Created by Fatih Türker on 29.08.2012.
//  Copyright (c) 2012 Fatih Türker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressBook/AddressBook.h"
@interface myContactListViewController : UIViewController{
    NSMutableArray* personNames;
    NSMutableArray* personPhones;
}
@property (weak, nonatomic) IBOutlet UIButton *syncButton;
@property (weak, nonatomic) IBOutlet UIButton *cleanButton;
@property(nonatomic,retain) NSMutableArray* personNames,*personPhones;
-(IBAction) saveContacts;
-(IBAction) cleanContacts;
@end
