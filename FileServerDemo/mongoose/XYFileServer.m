//
//  XYFileServer.m
//


#import "XYFileServer.h"
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#import <ifaddrs.h>
#import "mongoose.h"

#define DOCUMENTS_FOLDER NSHomeDirectory()

@interface XYFileServer ()

@property (assign,nonatomic)  struct mg_context *ctx;

@end


@implementation XYFileServer



- (void)startHTTP:(NSString *)ports {
  self.ctx = mg_start();     // Start Mongoose serving thread
  mg_set_option(self.ctx, "root", [DOCUMENTS_FOLDER UTF8String]);  // Set document root
  mg_set_option(self.ctx, "ports", [ports UTF8String]);    // Listen on port XXXX
  //mg_bind_to_uri(ctx, "/foo", &bar, NULL); // Setup URI handler

  // Now Mongoose is up, running and configured.
  // Serve until somebody terminates us
}

- (void)startWithPort:(NSString *)ports {
  [self startHTTP:ports];
}

- (void)stopServer {
  mg_stop(self.ctx);
}

+ (NSString *) localHost {
    char baseHostName[255];
    gethostname(baseHostName, 255);
    
    // Adjust for iPhone -- add .local to the host name
    char hn[255];
    sprintf(hn, "%s.local", baseHostName);
    return [NSString stringWithCString:hn encoding:NSUTF8StringEncoding];
}

+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
     
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
             
            temp_addr = temp_addr->ifa_next;
        }
    }
     
    // Free memory
    freeifaddrs(interfaces);
     
    return address;
}
@end
