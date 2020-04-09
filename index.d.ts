declare module "react-native-ble-peripheral" {
  function addService(UUID: string, primary: boolean): void;
  function addCharacteristicToService(
    ServiceUUID: string,
    UUID: string,
    permissions: number,
    properties: number
  ): void;
  function sendNotificationToDevices(
    ServiceUUID: string,
    CharacteristicUUID: string,
    data: number[]
  ): void;
  function start(): Promise<boolean>;
  function stop(): void;
  function setName(name: string): void;
  function isAdvertising(): Promise<boolean>;
  function isAdvertisementSupported(): Promise<boolean>;
}
