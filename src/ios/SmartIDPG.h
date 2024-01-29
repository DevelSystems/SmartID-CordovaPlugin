#import <Cordova/CDVPlugin.h>

@interface SmartIDPG : CDVPlugin {
}

// Encabezados de las funciones del plugin
- (void) startSmartId:(CDVInvokedUrlCommand*)command;
- (void) getRawData:(CDVInvokedUrlCommand*)command;
@end
