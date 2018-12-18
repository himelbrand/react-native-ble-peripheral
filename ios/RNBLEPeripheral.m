#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(BLEPeripheral, NSObject)

RCT_EXTERN_METHOD(isAdvertising: (RCTPromiseResolveBlock)resolve)
RCT_EXTERN_METHOD(addService)
RCT_EXTERN_METHOD(addCharacteristicToService)
RCT_EXTERN_METHOD(start)
RCT_EXTERN_METHOD(stop)
RCT_EXTERN_METHOD(sendNotificationToDevices)
RCT_EXTERN_METHOD(requiresMainQueueSetup)

@end
