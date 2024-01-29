#import "SmartIDPG.h"
#import <Cordova/CDVAvailability.h>
#import "CordovaAppDummy-Swift.h"

@implementation SmartIDPG

- (void)pluginInitialize {
}

- (void)startSmartId:(CDVInvokedUrlCommand *)command {
    BridgeSmartId* smartId= [BridgeSmartId new];
    [smartId startSmartId];
}

- (void)getRawData:(CDVInvokedUrlCommand *)command {
    BridgeSmartId* smartId= [BridgeSmartId new];
    [smartId getRawDataWithCommandDelegate:self.commandDelegate command:command];
}

@end
