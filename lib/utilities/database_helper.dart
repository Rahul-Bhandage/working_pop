import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import 'package:pop_lights_app/modals/group_model.dart';
import 'package:pop_lights_app/modals/pop_lights_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../modals/combination_model.dart';
import '../screens/group_tabview.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "PopLights.db";


  static Future<Database> _getDB() async {
    return openDatabase(
        join(await getDatabasesPath(), _dbName), onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE Groups(groupId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, groupName TEXT NOT NULL, isDeletable BOOLEAN);");
      await db.execute(
          "CREATE TABLE PopLights(popLightId TEXT PRIMARY KEY, groupId INTEGER, popLightName TEXT NOT NULL, isOn INTEGER, brightness INTEGER, glow INTEGER, timer INTEGER , colorid TEXT NOT NULL );");
      await db.execute(
          "CREATE TABLE US_PopLights(popLightId TEXT PRIMARY KEY, groupId INTEGER, popLightName TEXT NOT NULL, isOn INTEGER, brightness INTEGER, glow INTEGER, timer INTEGER , colorid TEXT NOT NULL );");
    //   await db.execute('''
    //   CREATE TABLE bluetooth_characteristics (
    //     id INTEGER PRIMARY KEY,
    //     remote_id TEXT,
    //     service_uuid TEXT,
    //     secondary_service_uuid TEXT,
    //     characteristic_uuid TEXT,
    //     descriptors TEXT,
    //     properties TEXT,
    //     value BLOB
    //   )
    // ''');
    }, version: _version);
  }










  static Future<List<CombineModel>> getCombinedModels() async {
    final List<PopLightModel>? Poplist = await getAllPopLights();
    final List<GroupModel> grplist = await getAllGroups();

    final List<CombineModel> combinedModels = [];
    // int max=-1;
    // Combine data from both models
    // Poplist!.length > grplist.length ? max=Poplist.length  : max=grplist.length;
    // for (int index1 = 0; index1 <max;index1++) {
    //   // if(index1<Poplist.length)index1=Poplist.length;
    //   // if(index2<grplist.length)index2=grplist.length-1;
      combinedModels.add(await CombineModel(
        model1: Poplist!,
        model2: grplist,
        length_of_model1: Poplist.length,
        length_of_model2: grplist.length
      ));

    return combinedModels;
  }





  // Future<void> insertCharacteristic(BluetoothCharacteristic characteristic) async {
  //   final db = await _getDB();
  //   await db.insert('bluetooth_characteristics', {
  //     'remote_id': characteristic.remoteId,
  //     'service_uuid': characteristic.serviceUuid.toString(),
  //     'secondary_service_uuid': characteristic.secondaryServiceUuid?.toString(),
  //     'characteristic_uuid': characteristic.characteristicUuid.toString(),
  //     'descriptors': jsonEncode(characteristic.descriptors),
  //     // Serialize descriptors to JSON
  //     'properties': jsonEncode(characteristic.properties),
  //     // Serialize properties to JSON
  //     'last_received_value': Uint8List.fromList([]),
  //     // Initialize as an empty binary data array
  //   });
  // }

  // Future<CustomBluetoothCharacteristicModel> getAllCharacteristics() async {
  //   final db = await _getDB();
  //   final List<Map<String, Object?>> jsonStr = await db.query('bluetooth_characteristics');
  //   final customCharacteristic =CustomBluetoothCharacteristicModel.fromJson(jsonStr as String);
  //   // return List.generate(maps.length, (i) {
  //   //   return CustomBluetoothCharacteristicModel.fromMap(maps[i]);
  //   // });
  //   return customCharacteristic;
  // }
  //

/*

BluetoothCharacteristic{remoteId: D7:33:35:37:36:05, serviceUuid: 0000ffb0-0000-1000-8000-00805f9b34fb, secondaryServiceUuid: null, characteristicUuid: 0000ffb1-0000-1000-8000-00805f9b34fb, descriptors: [BluetoothDescriptor{remoteId: D7:33:35:37:36:05, serviceUuid: 0000ffb0-0000-1000-8000-00805f9b34fb, characteristicUuid: 0000ffb1-0000-1000-8000-00805f9b34fb, descriptorUuid: 00002901-0000-1000-8000-00805f9b34fb, lastValue: []}], properties: CharacteristicProperties{broadcast: false, read: false, writeWithoutResponse: true, write: true, notify: false, indicate: false, authenticatedSignedWrites: false, extendedProperties: false, notifyEncryptionRequired: false, indicateEncryptionRequired: false}, value: []}

 */













  static Future<int> addGroup(GroupModel groupModel) async {
    final db = await _getDB();
    return await db.insert("Groups", groupModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  static Future<int> addPopLight(PopLightModel popLightModel) async {
    final db = await _getDB();
    return await db.insert("PopLights", popLightModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  // static Future<int> addPoplightColor(PopLightColorModel popLightColorModel) async {
  //   final db = await _getDB();
  //   return await db.insert("PoplightColor", popLightColorModel.toJson(),
  //       conflictAlgorithm: ConflictAlgorithm.ignore);
  // }

  // static Future<int> updatePoplightColor(PopLightColorModel popLightColorModel) async {
  //   final db = await _getDB();
  //   return await db.update("PoplightColor", popLightColorModel.toJson(),
  //       where: "popLightColorId = ?",
  //       whereArgs: [popLightColorModel.popLightColorId],
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  //
  // }

  static Future<int> updateGroup(GroupModel groupModel) async {
    final db = await _getDB();
    return await db.update("Groups", groupModel.toJson(),
        where: "groupId = ?",
        whereArgs: [groupModel.groupId],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updatePopLight(PopLightModel popLightModel) async {
    final db = await _getDB();
    return await db.update("PopLights", popLightModel.toJson(),
        where: "popLightId = ?",
        whereArgs: [popLightModel.popLightId],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteGroup(GroupModel groupModel) async {
    final db = await _getDB();
    // delete group and unsync rhe devices
    return await db.delete(
        "Groups", where: "groupId = ?", whereArgs: [groupModel.groupId]);
  }

  static Future<int> deletePopLight(PopLightModel popLightModel) async {
    final db = await _getDB();

    return await db
        .delete("PopLights", where: "popLightId = ?",
        whereArgs: [popLightModel.popLightId]);
  }

  static Future<int> deletePopLightTable() async {
    final db = await _getDB();

    return await db.delete("PopLights");
  }

  static Future<List<GroupModel>> getAllGroups() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Groups");

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(
        maps.length, (index) => GroupModel.fromJson(maps[index]));
  }

  static Future<List<GroupModel>?> getGroup(int groupId) async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Groups",
        columns: ['groupId', 'groupName', 'isDeletable'],
        where: 'groupId = ?',
        whereArgs: [groupId]);

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(
        maps.length, (index) => GroupModel.fromJson(maps[index]));
  }

  static Future<List<PopLightModel>?> getAllPopLights() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("PopLights");

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(
        maps.length, (index) => PopLightModel.fromJson(maps[index]));
  }

  static Future<List<PopLightModel>?> getPopLight(String popLightId) async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("PopLights",
        columns: [
          'popLightId',
          'groupId',
          'popLightName',
          'isOn',
          'brightness',
          'glow',
          'timer',
          'colorid'
        ],
        where: 'popLightId = ?',
        whereArgs: [popLightId]);

    if (maps.isEmpty) {
      return [];
    }
    final list = List.generate(
        maps.length, (index) => PopLightModel.fromJson(maps[index]));
    return list;
  }


  static Future<int> updateunsynced(PopLightModel popLightModel) async {
    final db = await _getDB();
    return await db.update("US_PopLights", popLightModel.toJson(),
        where: "popLightId = ?",
        whereArgs: [popLightModel.popLightId],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }


  static Future<List<PopLightModel>?> UnsyncedPopLights() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("US_PopLights");

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(
        maps.length, (index) => PopLightModel.fromJson(maps[index]));
  }

  static Future<List<PopLightModel>?> getunsynced(String popLightId) async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("US_PopLights",
        columns: [
          'popLightId',
          'groupId',
          'popLightName',
          'isOn',
          'brightness',
          'glow',
          'timer',
          'colorid'
        ],
        where: 'popLightId = ?',
        whereArgs: [popLightId]);

    if (maps.isEmpty) {
      return [];
    }
    final list = List.generate(
        maps.length, (index) => PopLightModel.fromJson(maps[index]));
    return list;
  }
  static Future<int> deleteUnsynced(String popLightId) async {
    final db = await _getDB();

    return await db
        .delete("US_PopLights", where: "popLightId = ?",
        whereArgs: [popLightId]);
  }

  static Future<int> addunsynced(PopLightModel popLightModel) async {
    final db = await _getDB();
    return await db.insert("US_PopLights", popLightModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }
}



//   static Future<List<PopLightColorModel>?> getPopLightColor(String poplightId) async {
//     final db = await _getDB();
//
//     final List<Map<String, dynamic>> maps = await db.query("PoplightColor",
//         columns: ['popLightColorId', 'poplightImagePath'],
//         where: 'popLightColorId = ?',
//         whereArgs: [poplightId]);
//
//     if (maps.isEmpty) {
//       return [];
//     }
//     final list = List.generate(maps.length, (index) => PopLightColorModel.fromJson(maps[index]));
//     return list;
//   }
// }
//"CREATE TABLE PoplightColor(popLightColorId INTEGER PRIMARY KEY NOT NULL, poplightImagePath TEXT NOT NULL);");