//  Created by Eskel on 12/12/2018.

import Foundation
import CoreBluetooth

@objc class BLEPeripheral: NSObject, CBPeripheralManagerDelegate {
    var advertising: Bool = false
    var peripheralManager: CBPeripheralManager!
    var servicesMap = Dictionary<String, CBMutableService>()

    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        print("BLEPeripheral initialized, advertising: \(advertising)")
    }

    @objc func isAdvertising(_ resolve: RCTPromiseResolveBlock) {
        resolve(advertising)
        print("called isAdvertising")
    }

    @objc func addService(_ uuid: String, _ primary: Bool) {
        let serviceUUID = CBUUID(string: uuid)
        if(servicesMap.keys.contains(uuid) != true){ servicesMap[uuid] = CBMutableService(type: serviceUUID, primary: primary) }
        print("called addService")
    }

    @objc func addCharacteristicToService() {


        /*
        let characteristicUUID = CBUUID(string: kCharacteristicUUID)
        let properties: CBCharacteristicProperties = [.Notify, .Read, .Write]
        let permissions: CBAttributePermissions = [.Readable, .Writeable]
        let characteristic = CBMutableCharacteristic(
            type: characteristicUUID,
            properties: properties,
            value: nil,
            permissions: permissions)

        // add to service
        // service.characteristics = @[characteristic, characteristic2];
        service.characteristics = @[characteristic];
        */
        print("called addCharacteristicToService")
    }
    
    @objc func start() {
        print("called start")
        let advertisementData = [CBAdvertisementDataLocalNameKey: "Test Device"]
        peripheralManager.startAdvertising(advertisementData)
    }
    
    @objc func stop() {
        print("called stop")
        peripheralManager.stopAdvertising()
    }
    
    @objc func sendNotificationToDevices() {
        print("called stop")
    }
    
    @objc static func requiresMainQueueSetup() -> Bool {
        return false
    }
    
    // Private functiomns
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("updated state: \(peripheral.state)")
    }
    
}
