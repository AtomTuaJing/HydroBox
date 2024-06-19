import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEProvider extends ChangeNotifier {
  BluetoothDevice? bluetoothDevice;
  BluetoothCharacteristic? writeCharacteristic;
  BluetoothCharacteristic? notify1Characteristic;
  BluetoothCharacteristic? notify2Characteristic;
  BluetoothCharacteristic? notify3Characteristic;

  void changeDevice(BluetoothDevice device) {
    bluetoothDevice = device;
  }

  void changeWriteCharacteristic(BluetoothCharacteristic characteristic) {
    writeCharacteristic = characteristic;
    notifyListeners();
    print("Write");
  }

  void changeNotify1Characteristic(BluetoothCharacteristic characteristic) {
    notify1Characteristic = characteristic;
    notifyListeners();
    print("Notify1");
  }

  void changeNotify2Characteristic(BluetoothCharacteristic characteristic) {
    notify2Characteristic = characteristic;
    notifyListeners();
    print("Notify2");
  }

  void changeNotify3Characteristic(BluetoothCharacteristic characteristic) {
    notify3Characteristic = characteristic;
    notifyListeners();
    print("Notify3");
  }
}
