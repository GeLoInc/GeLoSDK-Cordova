This is the GeLoSDK plugin for PhoneGap / Cordova. It exposes a higher level JS API that web developers can use to interact with GeLo beacons.

## Supported Platforms

* iOS (supports [latest](https://github.com/GeLoInc/GeLoSDK-iOS) GeloSDK, [2.0.1](https://github.com/GeLoInc/GeLoSDK-iOS/tree/v2.0.1), [2.0.0](http://github.com/GeLoInc/GeLoSDK-iOS/tree/v2.0.0), and [1.1.9](https://github.com/GeLoInc/GeLoSDK-iOS/tree/v1.1.9))
* Android (not yet supported, coming soon)

## Supported GeLo Events

* GeLoNearestBeaconExpired
* GeLoNearestBeaconChanged
* GeLoBeaconExpired
* GeLoBeaconFound
* GeLoBeaconAgedGracefully
* GeLoBTLEStateUnknown
* GeLoBTLEPoweredOff
* GeLoBTLEPoweredOn
* GeLoBTLEUnsupported
* GeLoScanningStarted
* GeLoScanningStopped

## Basic Example

    // All supported events exist inside of this namespace
    var K = GeLoCordovaPlugin.Events;

    // All events can be registered for with the following pattern
    GeLoCordovaPlugin.on(K.GeLoBeaconFound, function(beacon){
      console.log("Found a beacon: " + beacon.beaconId);
    });

    // All events also support taking an optional error callback 
    // as the second argument.
    GeLoCordovaPlugin.on(K.GeLoNearestBeaconChanged, 
      function(beacon){
        // this is a success callback
        console.log("Nearest beacon changed to" + beacon.beaconId);
      },
      function(){
        // the second argument (optional) is an error callback
        console.log("Nearest beacon change failed");
    });

    // Start scanning
    GeLoCordovaPlugin.startScanningForBeacons();

    // Stop scanning for beacons in 10 seconds
    setTimeout(function(){
      GeLoCordovaPlugin.stopScanningForBeacons();
    }, 10000)

