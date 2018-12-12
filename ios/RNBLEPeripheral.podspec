
Pod::Spec.new do |s|
  s.name         = "react-native-ble-peripheral"
  s.version      = "1.0.0"
  s.summary      = "react-native-ble-peripheral"
  s.description  = "Simulator for a BLE peripheral, to help with testing BLE apps without an actual peripheral BLE device"
  s.homepage     = ""
  s.license      = "MIT"
  s.author             = { "Omri Himelbrand" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/himelbrand/react-native-ble-peripheral", :tag => "master" }
  s.source_files  = "RNBlePeripheral/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"

end

  