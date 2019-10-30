//
//  ViewController.m
//  FileServerDemo
//
//  Created by Mac on 2019/10/30.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "ViewController.h"
#import "XYFileServer.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;
@property (strong, nonatomic) XYFileServer *fileServer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fileServer = [[XYFileServer alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *port = @"8080";
    [self.fileServer startWithPort:port];
    self.textView1.text = [NSString stringWithFormat:@"%@:%@",XYFileServer.localHost,port];
    self.textView2.text = [NSString stringWithFormat:@"%@:%@",XYFileServer.getIPAddress,port];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.fileServer stopServer];
}

@end
