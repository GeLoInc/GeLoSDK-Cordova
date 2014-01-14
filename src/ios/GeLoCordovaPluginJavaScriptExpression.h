#import <Foundation/Foundation.h>
#import <GeLoSDK/GeLoSDK.h>

@interface GeLoCordovaPluginJavaScriptExpression : NSObject

@property (readonly) NSNotification *notification;
@property (readonly) GeLoBeacon *beacon;
@property (readonly) NSArray *beaconArray;

+(NSString *) javascriptForNotification:(NSNotification *) notification;
+(NSString *) javascriptForGeLoBeacon:(GeLoBeacon *)beacon;
+(NSString *) javascriptForGeLoBeaconArray:(NSArray *)beacons;

-(id) initWithNotification:(NSNotification *) notification;
-(id) initWithGeLoBeacon:(GeLoBeacon *) beacon;

-(NSString *) jsExpression;
-(NSString *) javascriptForBeacon:(GeLoBeacon *)beacon;
-(NSString *) javascriptForBeaconArray;

@end
