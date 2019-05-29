# React Native BLE Peripheral
Native BLE Peripheral in React Native
## Welcome

This is a simulator for a BLE peripheral, to help with testing BLE apps without an actual peripheral BLE device
this project is not yet complete,
for all ready parts see documentation below.
(docs are not complete, feel free to improve them)

## Realease notes
- fixed issues fixed on github repo in npm package - starting from version 1.2.0
- **IOS support was added in version 2.0.0**
- merged PR to fix write charicaristics - version 2.0.1
    
### Still missing

if you would like to contribute to this project or suggest more future features you're welcome to so via an issue or pull request.

### IOS support
right now this package does not support IOS, so any one that wants to help and contribute the IOS support is more than welcome


## Installation

```bash
npm install react-native-ble-peripheral --save
or 
yarn add react-native-ble-peripheral
```
npm page - https://www.npmjs.com/package/react-native-ble-peripheral
## Add permissions
* In `AndroidManifest.xml` add:
```xml

 <uses-permission android:name="android.permission.BLUETOOTH"/>
 <uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
```
## Project setup and initialization auto
```bash
react-native link
```
## Project setup and initialization manually 

* In `android/settings.gradle`

```gradle
...
include ':react-native-ble-peripheral'
project(':react-native-ble-peripheral').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-ble-peripheral/android')

```

* In `android/app/build.gradle`

```gradle
...
dependencies {
    /* YOUR DEPENDENCIES HERE */
   compile project(':react-native-ble-peripheral') // <--- add this
}

```

* Register Module (in MainApplication.java)

```java
import com.himelbrand.forwardcalls.RNForwardCallsPackage;  // <--- import

public class MainActivity extends ReactActivity {
  ......

  @Override
  protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
          new MainReactPackage(),
          new RNBLEPackage() // <--- Add this
      );
  }

  ......

}
```


## Usage

#### Import

```javascript
import BLEPeripheral from 'react-native-ble-peripheral'
```

#### Add Service 
BLEPeripheral.addService(UUID:string, primary:boolean)
```javascript
BLEPeripheral.addService('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX', true) //for primary service
BLEPeripheral.addService('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX', false) //for non primary service
```
#### Add Characteristic
BLEPeripheral.addCharacteristicToService(ServiceUUID:string, UUID:string, permissions:number, properties:number)

https://developer.android.com/reference/android/bluetooth/BluetoothGattCharacteristic.html
the link above is for permissions and properties constants info

Permissions:
* 1 - Readable
* 2 - Readable Encrypted
* 4 - Readable Encrypted MITM (Man-in-the-middle) Protection 
* 16 - Writable
* 32 - Writable Encrypted
* 64 - Writable Encrypted MITM Protection
* 128 - Writable Signed
* 256 - Writable Signed MITM

Properties:
* 1 - Broadcastable
* 2 - Readable
* 4 - Writable without response
* 8 - Writable
* 16 - Supports notification
* 32 - Supports indication
* 64 - Signed Write
* 128 - Extended properties

```javascript
BLEPeripheral.addCharacteristicToService('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX', 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX', 16 | 1, 8) //this is a Characteristic with read and write permissions and notify property
```
#### Notify to devices
BLEPeripheral.sendNotificationToDevices(ServiceUUID:string, CharacteristicUUID:string, data:byte[]) 
- note #1: in js it's not really a byte array, but an array of numbers
- note #2: the CharacteristicUUID must be of a Characteristic with notify property
```javascript
BLEPeripheral.sendNotificationToDevices('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX', 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX', [0x10,0x01,0xA1,0x80]) //sends a notification to all connected devices that, using the char uuid given
```

#### start Advertising 
note:use this only after adding services and characteristics
```javascript
 BLEPeripheral.start()
  .then(res => {
       console.log(res)
  }).catch(error => {
       console.log(error)
  })
```

In case of error, these are the error codes:
* 1 - Failed to start advertising as the advertise data to be broadcasted is larger than 31 bytes.
* 2 - Failed to start advertising because no advertising instance is available.
* 3 - Failed to start advertising as the advertising is already started.
* 4 - Operation failed due to an internal error.
* 5 - This feature is not supported on this platform.


#### stop Advertising 
```javascript
 BLEPeripheral.stop()
```

#### Set name (optional)
BLEPeripheral.setName(name:string)

This method sets the name of the device broadcast, before calling `start`.
```javascript
BLEPeripheral.setName('RNBLETEST')
```

DOCs and project is under development 
Any help would be welcome...
feel free to contact me
