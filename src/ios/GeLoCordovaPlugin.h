#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>

@interface GeLoCordovaPlugin : CDVPlugin

@property (nonatomic) NSMutableDictionary *callbacks;

-(void)on:(CDVInvokedUrlCommand*)command;
-(void)stopScanningForBeacons:(CDVInvokedUrlCommand*)command;
-(void)startScanningForBeacons:(CDVInvokedUrlCommand*)command;
-(void)isScanning:(CDVInvokedUrlCommand*)command;
-(void)setDefaultTimeToLive:(CDVInvokedUrlCommand*)command;
-(void)setDefaultFalloff:(CDVInvokedUrlCommand*)command;
-(void)setDefaultSignalCeiling:(CDVInvokedUrlCommand*)command;
-(void)knownBeacons:(CDVInvokedUrlCommand*)command;
-(void)nearestBeacon:(CDVInvokedUrlCommand*)command;
-(void)unsetNearestBeacon:(CDVInvokedUrlCommand*)command;

@end