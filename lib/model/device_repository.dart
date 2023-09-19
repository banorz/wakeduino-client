import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:wakeduino_remote/_core/exceptions/already_exists_exception.dart';
import 'package:wakeduino_remote/_core/exceptions/not_exists_exception.dart';
import 'package:wakeduino_remote/model/device_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceRepository {
  Future<DeviceModel> insert(DeviceModel device) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? addresses = pref.getStringList("macAddresses");
    if(addresses!=null){
      if(addresses.contains(device.macAddress)){
        throw AlreadyExistsException(device.macAddress);
      }
      else {
        addresses.add(device.macAddress);
      }
    }
    else{
      addresses = [];
      addresses.add(device.macAddress);
    }
    pref.setStringList("macAddresses",addresses);
    pref.setString(device.macAddress, device.name);
    return device;
  }

  Future<DeviceModel> remove(DeviceModel device) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? addresses = pref.getStringList("macAddresses");
    if(addresses!=null){
      if(addresses.contains(device.macAddress)){
        addresses.remove(device.macAddress);
      }
      else {
        throw NotExistsException(device.macAddress);
      }
    }
    else{
      throw NotExistsException(device.macAddress);
    }
    pref.remove(device.macAddress);
    return device;
  }

  Future<List<DeviceModel>> queryAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<DeviceModel> devices = [];
    List<String>? addresses = pref.getStringList("macAddresses");
    if(addresses!=null) {
      for (var element in addresses) {
        var deviceName = pref.getString(element);
        deviceName ??= "";
        devices.add(DeviceModel(name: deviceName, macAddress: element));
      }
    }
    return devices;
  }

  Future<DeviceModel> queryByMac(String macAddress) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(!pref.containsKey(macAddress)){
      throw NotExistsException(macAddress);
    }
    else{
      var deviceName = pref.getString(macAddress);
      deviceName ??= "";
      return DeviceModel(name: deviceName, macAddress: macAddress);
    }
  }

}