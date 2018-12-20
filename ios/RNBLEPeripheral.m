#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(BLEPeripheral, NSObject)

// Best explanation: https://medium.com/@andrei.pfeiffer/react-natives-rct-extern-method-c61c17bf17b2

RCT_EXTERN_METHOD(isAdvertising: (RCTPromiseResolveBlock)resolve)
RCT_EXTERN_METHOD(addService: (String)uuid (Bool)primary)
RCT_EXTERN_METHOD(addCharacteristicToService: (String)uid (UInt)permissiomns (UInt)properties (String)data)
RCT_EXTERN_METHOD(start)
RCT_EXTERN_METHOD(stop)
RCT_EXTERN_METHOD(sendNotificationToDevices)
RCT_EXTERN_METHOD(requiresMainQueueSetup)

@end
