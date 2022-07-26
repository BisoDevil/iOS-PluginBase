//
//  ViewController.m
//  MoEPluginBase
//
//  Created by Chengappa C D on 09/08/2020.
//  Copyright (c) 2020 Chengappa C D. All rights reserved.
//

#import "ViewController.h"
@import MoEPluginBase;
@import MoEPluginInbox;
@import MoEPluginGeofence;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) NSArray* dataSourceArray;
@property(nonatomic, strong) NSString* defaultAppID;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSourceArray = @[@"Plugin Initialized",@"Set AppStatus",@"Track Event",@"Track User Attributes",@"Set Alias",@"Register For Push", @"Show InApp", @"Self Handled InApp", @"Set Context",@"Invalidate Context", @"Reset User", @"Opt-Out Tracking", @"Opt-In Tracking", @"Check Validity", @"Inbox - Get Messages", @"Inbox - Unread Count",@"Enable SDK",@"Disable SDK",@"Start GeofenceMontioring"];
    self.defaultAppID = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = self.dataSourceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            NSDictionary* pluginDict = @{
                @"accountMeta": @{
                  @"appId": self.defaultAppID
                }
            };
            [[MoEPluginBridge sharedInstance] pluginInitialized: pluginDict];
            
            break;
        }
        case 1:{
            NSDictionary* appstatusDict = @{
                  @"accountMeta": @{
                    @"appId": self.defaultAppID
                  },
                  @"data": @{
                    @"appStatus": @"INSTALL"
                  }
            };
            [[MoEPluginBridge sharedInstance] setAppStatus:appstatusDict];
            break;
        }
        case 2:{
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
            NSString* timeAttr = [dateFormatter stringFromDate:[NSDate date]];
            NSDictionary* trackEventDict = @{
                @"accountMeta": @{
                    @"appId": self.defaultAppID
                },
                @"data": @{
                    @"eventName": @"SampleEvent",
                    @"eventAttributes": @{
                        @"generalAttributes": @{
                            @"StringAttr": @"Hello MoEngage!!",
                            @"NumDoubleAttribute" : @123444.7877,
                            @"NumIntAttribute" : @1234,
                            @"boolAttribute" : @1
                        },
                        @"locationAttributes": @{
                            @"LocationAttr": @{
                                @"latitude": @12.34,
                                @"longitude": @13.23
                            }
                        },
                        @"dateTimeAttributes": @{
                            @"TimeAttr": timeAttr
                        }
                    },
                    @"isNonInteractive": @0
                }
            };
            [[MoEPluginBridge sharedInstance] trackEvent: trackEventDict];
            break;
        }
        case 3:{
            // 1. Unique ID Attribute
            NSDictionary* userAttrPayload1 = @{
                @"accountMeta": @{
                    @"appId": self.defaultAppID
                },
                @"data": @{
                    @"attributeName":@"USER_ATTRIBUTE_UNIQUE_ID",
                    @"attributeValue":@"Unique ID",
                    @"type":@"general"
                }
            };
            [[MoEPluginBridge sharedInstance] setUserAttribute:userAttrPayload1];
            
            // 2. Custom Attribute
            NSDictionary* userAttrPayload2 = @{
                @"accountMeta": @{
                    @"appId": self.defaultAppID
                },
                @"data": @{
                    @"attributeName":@"Attr 2",
                    @"attributeValue":@23.45,
                    @"type":@"general"
                }
            };
            [[MoEPluginBridge sharedInstance] setUserAttribute:userAttrPayload2];
            userAttrPayload2 = @{
                @"accountMeta": @{
                    @"appId": self.defaultAppID
                },
                @"data": @{
                    @"attributeName":@"Attr 3",
                    @"attributeValue":@0,
                    @"type":@"general"
                }
            };
            [[MoEPluginBridge sharedInstance] setUserAttribute:userAttrPayload2];
            
            // 3. Timestamp Attribute
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
            NSString* timeAttr = [dateFormatter stringFromDate:[NSDate date]];
            NSDictionary* userAttrPayload3 = @{
                @"accountMeta": @{
                    @"appId": self.defaultAppID
                },
                @"data": @{
                    @"attributeName":@"timestamp user attr",
                    @"attributeValue":timeAttr,
                    @"type":@"timestamp"
                }
            };
            [[MoEPluginBridge sharedInstance] setUserAttribute:userAttrPayload3];
            
            // 4. Location Attribute
            NSDictionary* userAttrPayload4 = @{
                @"accountMeta": @{
                    @"appId": self.defaultAppID
                },
                @"data": @{
                    @"attributeName":@"location user attr1",
                    @"type":@"location",
                    @"locationAttribute":@{
                        @"latitude": @23.23,
                        @"longitude": @43.34
                    }
                }
            };
            [[MoEPluginBridge sharedInstance] setUserAttribute:userAttrPayload4];
            break;
        }
        case 4:{
            NSDictionary* aliasDict = @{
                @"accountMeta": @{
                    @"appId": self.defaultAppID
                },
                @"data": @{
                    @"alias": @"alias ID"
                }
            };
            [[MoEPluginBridge sharedInstance] setAlias:aliasDict];
            break;
        }
        case 5:{
            [[MoEPluginBridge sharedInstance] registerForPush];
            break;
        }
        case 6:{
            NSDictionary* inappDict = @{
              @"accountMeta": @{
                @"appId": self.defaultAppID
              }
            };
            [[MoEPluginBridge sharedInstance] showInApp:inappDict];
            break;
        }
        case 7:{
            NSDictionary* inappDict = @{
              @"accountMeta": @{
                @"appId": self.defaultAppID
              }
            };
            
            [[MoEPluginBridge sharedInstance] getSelfHandledInApp:inappDict];
            break;
        }
        case 8:{
            NSDictionary* contextDict = @{
                @"accountMeta": @{
                    @"appId": self.defaultAppID
                },
                @"data": @{
                    @"contexts": @[@"Home", @"Settings"]
                }
            };
            
            [[MoEPluginBridge sharedInstance] setInAppContext:contextDict];
            break;
        }
        case 9:{
            NSDictionary* contextDict = @{
                @"accountMeta": @{
                    @"appId": self.defaultAppID
                }
            };
            
            [[MoEPluginBridge sharedInstance] resetInAppContext:contextDict];
            break;
        }
        case 10:{
            NSDictionary* resetDict = @{
                @"accountMeta": @{
                    @"appId": self.defaultAppID
                }
            };
            [[MoEPluginBridge sharedInstance] resetUser:resetDict];
            break;
        }
        case 11:{
            NSDictionary* optOutDataDict = @{
                @"accountMeta": @{
                    @"appId": self.defaultAppID
                },
                @"data": @{
                    @"type": @"data",
                    @"state": @0
                }
            };
            [[MoEPluginBridge sharedInstance] optOutDataTracking: optOutDataDict];
            
            break;
        }
        case 12:{
            NSDictionary* optOutDataDict = @{
                @"accountMeta": @{
                    @"appId": self.defaultAppID
                },
                @"data": @{
                    @"type": @"data",
                    @"state": @1
                }
            };
            [[MoEPluginBridge sharedInstance] optOutDataTracking:optOutDataDict];

        }
        case 13:{
            break;
        }
        case 14:{
            NSDictionary* inboxDict = @{
              @"accountMeta": @{
                @"appId": self.defaultAppID
              }
            };
            
            [[MoEInboxBridge sharedInstance]  getInboxMessages: inboxDict completionHandler:^(NSDictionary<NSString *,id> * _Nonnull inboxPayload) {
                NSLog(@"Fetched Inbox messages %@", inboxPayload);
                
        
                NSMutableDictionary* dataDict = inboxPayload[@"data"];
                NSArray* inboxMessage = dataDict[@"messages"];
                if (inboxMessage.count > 0) {
                    NSDictionary* message = inboxMessage.firstObject;
                    
                    NSDictionary* statsPayload = @{
                        @"accountMeta": @{
                            @"appId": self.defaultAppID
                        },
                        @"data": message
                    };
                    
                    [[MoEInboxBridge sharedInstance] trackInboxClick: statsPayload];
                    [[MoEInboxBridge sharedInstance] deleteInboxEntry: statsPayload];
                }
            }];
        }
            break;
        case 15:{
            NSDictionary* inboxDict = @{
              @"accountMeta": @{
                @"appId": self.defaultAppID
              }
            };

            [[MoEInboxBridge sharedInstance] getUnreadMessageCount: inboxDict completionHandler:^(NSDictionary<NSString *,id> * _Nonnull unreadDict) {
                NSLog(@"Unread count is %@",unreadDict);
            }];
            break;
        }
        case 16:{
            NSDictionary* sdkStateDict = @{
              @"accountMeta": @{
                @"appId": self.defaultAppID
              },
              @"data": @{
                @"isSdkEnabled": @1,
              }
            };
            [[MoEPluginBridge sharedInstance] updateSDKState: sdkStateDict];
            break;
        }
        case 17:{
            NSDictionary* sdkStateDict = @{
              @"accountMeta": @{
                @"appId": self.defaultAppID
              },
              @"data": @{
                @"isSdkEnabled": @0,
              }
            };
            [[MoEPluginBridge sharedInstance] updateSDKState:sdkStateDict];
            break;
        }
            
        case 18:{
            NSDictionary* payload = @{
              @"accountMeta": @{
                @"appId": self.defaultAppID
              }
            };
            [[MoEGeofenceBridge sharedInstance] startGeofenceMonitoring: payload];
            break;
        }
        default:
            break;
    }
}

@end
