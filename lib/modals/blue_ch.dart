//
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
//
// import 'package:hive/hive.dart';
// // Generated file
//
// @HiveType(typeId: 0)
// class BluetoothCharacteristic1 extends HiveObject {
//   @HiveField(0)
//   DeviceIdentifier remoteId;
//   @HiveField(1)
//   Guid serviceUuid;
//   @HiveField(2)
//   Guid? secondaryServiceUuid;
//   @HiveField(3)
//   Guid characteristicUuid;
//   @HiveField(4)
//   List<BluetoothDescriptor> descriptors;
//   @HiveField(5)
//   CharacteristicProperties characteristicProperties;
//   @HiveField(6)
//   dynamic value;
//
//   BluetoothCharacteristic1({
//     required this.remoteId,
//     required this.serviceUuid,
//     required this.secondaryServiceUuid,
//     required this.characteristicUuid,
//     required this.descriptors,
//     required this.characteristicProperties,
//     required this.value,
//   });
// }
//
// enum BluetoothDescriptorType {
//   clientConfiguration,
//   serverConfiguration,
//   userDescription,
//   presentationFormat,
//   validRange,
// }
// int _compareAsciiLowerCase(String a, String b) {
//   const int upperCaseA = 0x41;
//   const int upperCaseZ = 0x5a;
//   const int asciiCaseBit = 0x20;
//   var defaultResult = 0;
//   for (var i = 0; i < a.length; i++) {
//     if (i >= b.length) return 1;
//     var aChar = a.codeUnitAt(i);
//     var bChar = b.codeUnitAt(i);
//     if (aChar == bChar) continue;
//     var aLowerCase = aChar;
//     var bLowerCase = bChar;
//     // Upper case if ASCII letters.
//     if (upperCaseA <= bChar && bChar <= upperCaseZ) {
//       bLowerCase += asciiCaseBit;
//     }
//     if (upperCaseA <= aChar && aChar <= upperCaseZ) {
//       aLowerCase += asciiCaseBit;
//     }
//     if (aLowerCase != bLowerCase) return (aLowerCase - bLowerCase).sign;
//     if (defaultResult == 0) defaultResult = aChar - bChar;
//   }
//   if (b.length > a.length) return -1;
//   return defaultResult.sign;
// }
//
// class BluetoothCharacteristic1Adapter extends TypeAdapter<BluetoothCharacteristic1> {
//   @override
//   final typeId = 1; // Use a unique positive integer as the typeId
//
//   @override
//   BluetoothCharacteristic1 read(BinaryReader reader) {
//     // Read the fields from the binary data
//     final remoteId = reader.read() as DeviceIdentifier;
//     final serviceUuid = reader.read() as Guid;
//     final secondaryServiceUuid = reader.read() as Guid?;
//     final characteristicUuid = reader.read() as Guid;
//     final descriptors = reader.read() as List<BluetoothDescriptor>;
//     final characteristicProperties = reader.read() as CharacteristicProperties;
//     final value = reader.read();
//
//     // Create and return a BluetoothCharacteristic1 instance
//     return BluetoothCharacteristic1(
//       remoteId: remoteId,
//       serviceUuid: serviceUuid,
//       secondaryServiceUuid: secondaryServiceUuid,
//       characteristicUuid: characteristicUuid,
//       descriptors: descriptors,
//       characteristicProperties: characteristicProperties,
//       value: value,
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, BluetoothCharacteristic1 obj) {
//     writer.write(obj.remoteId);
//     writer.write(obj.serviceUuid);
//     writer.write(obj.secondaryServiceUuid);
//     writer.write(obj.characteristicUuid);
//     writer.writeList(obj.descriptors);
//     writer.write(obj.characteristicProperties);
//     writer.write(obj.value);
//   }
// }
//
