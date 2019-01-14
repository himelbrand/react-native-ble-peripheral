//  Created by Eskel on 12/12/2018.

import Foundation
import CoreBluetooth

@objc(BLEPeripheral)
class BLEPeripheral: RCTEventEmitter, CBPeripheralManagerDelegate {
    var advertising: Bool = false
    var hasListeners: Bool = false
    var servicesMap = Dictionary<String, CBMutableService>()
    var manager: CBPeripheralManager!
    var startPromiseResolve: RCTPromiseResolveBlock?
    var startPromiseReject: RCTPromiseRejectBlock?

    override init() {
        super.init()
        manager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        print("BLEPeripheral initialized, advertising: \(advertising)")
    }

    @objc func isAdvertising(_ resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) {
        resolve(advertising)
        print("called isAdvertising")
    }

    @objc(addService:primary:)
    func addService(uuid: String, primary: Bool) {
        let serviceUUID = CBUUID(string: uuid)
        let service = CBMutableService(type: serviceUUID, primary: primary)
        if(servicesMap.keys.contains(uuid) != true){
            servicesMap[uuid] = service
            manager.add(service)
            print("added service \(uuid)")
        }
        else {
            print("service \(uuid) already there")
            self.alertJS("service \(uuid) already there")
        }
    }
    
    @objc(addCharacteristicToService:uuid:permissions:properties:data:)
    func addCharacteristicToService(serviceUUID: String, uuid: String, permissions: UInt, properties: UInt, data: String) {
        let characteristicUUID = CBUUID(string: uuid)
        let propertyValue = CBCharacteristicProperties(rawValue: properties)
        let permissionValue = CBAttributePermissions(rawValue: permissions)
        let byteData: Data = data.data(using: .utf8)!
        let characteristic = CBMutableCharacteristic( type: characteristicUUID, properties: propertyValue, value: byteData, permissions: permissionValue)
        servicesMap[serviceUUID]?.characteristics?.append(characteristic)
        print("added characteristic to service")
    }

    @objc func start(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        if (manager.state != .poweredOn) {
            self.alertJS("Bluetooth turned off")
            return;
        }

        self.startPromiseResolve = resolve
        self.startPromiseReject = reject

        let advertisementData = [CBAdvertisementDataLocalNameKey: "Test data"]
        // manager.startAdvertising([CBAdvertisementDataServiceUUIDsKey : [service.UUID]])

        manager.startAdvertising(advertisementData)
    }
    
    @objc func stop() {
        manager.stopAdvertising()
        self.advertising = false
        print("called stop")
    }
    
    @objc func sendNotificationToDevices() {
        print("called stop")
    }
    
    @objc override func supportedEvents() -> [String]! {
        return ["onWarning"]
    }
    
    override func startObserving()
    {
        hasListeners = true
    }
    
    override func stopObserving()
    {
        hasListeners = false
    }
    
    @objc override static func requiresMainQueueSetup() -> Bool {
        return false
    }
    
    // Private functions
    
    func alertJS(_ message: Any) {
        if(self.hasListeners) {
            sendEvent(withName: "onWarning", body: message)
        }
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if let error = error {
            print("error: \(error)")
            self.alertJS("error: \(error)")
            return
        }
        print("service: \(service)")
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            print("advertising failed. error: \(error)")
            self.alertJS("advertising failed. error: \(error)")
            self.advertising = false
            self.startPromiseReject!("AD_ERR", "advertising failed", error)
            return
        }
        self.advertising = true
        self.startPromiseResolve!(self.advertising)
        print("advertising succeeded!")
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("updated state: \(peripheral.state)")
    }
    
}
