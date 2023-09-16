import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {

//  final FlutterBluePlus _flutterBluePlus = FlutterBluePlus.instance;

  bool _isSearching = false;

/*  scanDevices() async {

    _isSearching = true;
    _flutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    _flutterBluePlus.stopScan();
    _isSearching = false;
  }*/

//  Stream<List<ScanResult>> get scanResults => _flutterBluePlus.scanResults;
  bool get isSearching => _isSearching;

  Future turnOnBLE() async {

  }

/*  turnOffBLE() async {

    if (!await Permission.bluetoothConnect.isGranted) {
      await Permission.bluetoothConnect.request();
    }
    _flutterBluePlus.turnOff();
  }*/

}