#import "GeLoCordovaPlugin.h"
#import "GeLoCordovaPluginJavaScriptExpression.h"
#import <GeLoSDK/GeLoSDK.h>


@implementation GeLoCordovaPlugin
/*
 Starts the beacon manager scanning for beacons.
 */
-(void)startScanningForBeacons:(CDVInvokedUrlCommand*)command {
    [[GeLoBeaconManager sharedInstance] startScanningForBeacons];
}

/*
 Stops the beacon manager scanning for beacons.
 */
-(void)stopScanningForBeacons:(CDVInvokedUrlCommand*)command {
    [[GeLoBeaconManager sharedInstance] stopScanningForBeacons];
}

/*
 Returns whether or not the beacon manager is currently scanning for beacons.
 */
-(void)isScanning:(CDVInvokedUrlCommand*)command {
    NSString *jsResult = nil;
    CDVPluginResult *result = nil;
    BOOL scanningStatus = [[GeLoBeaconManager sharedInstance] isScanning];
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:scanningStatus];
    jsResult = [result toSuccessCallbackString:command.callbackId];

    [self writeJavascript:jsResult];
}

/*
 Sets the time limit for the beacon manager to maintain a reference to a known beacon.
 */
-(void)setDefaultTimeToLive:(CDVInvokedUrlCommand*)command {
    NSNumber *ttl = [command.arguments objectAtIndex:0];
    [[GeLoBeaconManager sharedInstance] setDefaultTimeToLive:[ttl integerValue]];
}

/*
 Sets the minimum signal strength threshold for beacon recognition.
 */
-(void)setDefaultFalloff:(CDVInvokedUrlCommand*)command {
    NSNumber *falloff = [command.arguments objectAtIndex:0];
    [[GeLoBeaconManager sharedInstance] setDefaultFalloff:[falloff integerValue]];
}

/*
 Sets the maximum signal strength threshold for beacon recognition.
 */
-(void)setDefaultSignalCeiling:(CDVInvokedUrlCommand*)command {
    NSNumber *signalCeiling = [command.arguments objectAtIndex:0];
    [[GeLoBeaconManager sharedInstance] setDefaultSignalCeiling:[signalCeiling integerValue]];
}


/*
 Retrieves an array containing the beacons known to the beacon manager.
 */
-(void)knownBeacons:(CDVInvokedUrlCommand*)command {
    NSString *jsResult = nil;
    CDVPluginResult *result = nil;
    NSArray *beacons = [[GeLoBeaconManager sharedInstance] knownBeacons];

    if ([beacons count]) {
        NSString *jsonArray = [GeLoCordovaPluginJavaScriptExpression javascriptForGeLoBeaconArray:beacons];
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonArray];
        jsResult = [result toSuccessCallbackString:command.callbackId];
    }else{
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        jsResult = [result toErrorCallbackString:command.callbackId];
    }

    [self writeJavascript:jsResult];
}

/*
 Returns whether or not the beacon manager is currently scanning for beacons.
 */
-(void)nearestBeacon:(CDVInvokedUrlCommand*)command {
    NSString *jsResult = nil;
    CDVPluginResult *result = nil;

    GeLoBeacon *beacon = [[GeLoBeaconManager sharedInstance] nearestBeacon];
    if (beacon) {
        NSString *jsObject = [GeLoCordovaPluginJavaScriptExpression javascriptForGeLoBeacon:beacon];
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsObject];
        jsResult = [result toSuccessCallbackString:command.callbackId];
    }else{
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        jsResult = [result toErrorCallbackString:command.callbackId];
    }

    [self writeJavascript:jsResult];
}

/*
 Unsets the current nearest beacon.
 */
-(void)unsetNearestBeacon:(CDVInvokedUrlCommand*)command {
    [[GeLoBeaconManager sharedInstance] unsetNearestBeacon];
}

/*
 Register for NSNotification events used by the beacon manager.
 */
-(void)on:(CDVInvokedUrlCommand*)command {
    if (!_callbacks)
        _callbacks = [NSMutableDictionary dictionary];

    NSString *notificationName = [command.arguments objectAtIndex:0];
    //Stores the callback of the calling javascript function.
    [_callbacks setObject:command.callbackId forKey:notificationName];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:notificationName object:nil];
}

#pragma mark - Private Methods

/*
 Handles an NSNotification event.
 */
-(void)event:(NSNotification *)notification {
    CDVPluginResult *result = nil;
    NSString *jsResult = nil;

    //event will callback to the 'on' javascript function.
    NSString *callback = [_callbacks objectForKey:notification.name];
    NSString *jsExpression = [GeLoCordovaPluginJavaScriptExpression javascriptForNotification:notification];
    if (jsExpression) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsExpression];
        [result setKeepCallbackAsBool:YES];
        jsResult = [result toSuccessCallbackString:callback];
    }else{
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        jsResult = [result toErrorCallbackString:callback];
    }

    [self writeJavascript:jsResult];
}

@end