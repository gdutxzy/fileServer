//
//  XYFileServer.h
//


@import CoreFoundation;
@import UIKit;

@interface XYFileServer : NSObject 

- (void)startWithPort:(NSString *)ports;
- (void)stopServer;

+ (NSString *) localHost;
+ (NSString *)getIPAddress;
@end
