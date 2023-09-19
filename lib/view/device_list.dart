
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

import 'package:flutter/material.dart';

import '../model/device_model.dart';
import '../model/device_repository.dart';
import '../singletons/wakeduino.dart';
import 'list_items/device_list_item.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
class DeviceList extends StatefulWidget {
  const DeviceList({required Key key}) : super(key: key);

  static State<DeviceList>? of(BuildContext context) => context.findAncestorStateOfType<State<DeviceList>>();


  @override
  State<StatefulWidget> createState() {
    return DeviceListState();
  }




}

class DeviceListState extends State<DeviceList> {
  //receiving and sending back a custom message
  void messageReceived(String msg){
    print(msg);
  }

  List<DeviceModel> devices = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: devices.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {

        final device = devices[index];
        DeviceListItem item = DeviceListItem(device.name, device.macAddress);

        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
          onTap: () async {
            String hostname = await WakeDuino().getHostname();
            int port = await WakeDuino().getPort();
            String key = await WakeDuino().getKey();
            String macAddress = device.macAddress;
            String name = device.name;
            Socket socket = await Socket.connect(hostname, port);
            //print('connected');

            // listen to the received data event stream
            socket.listen((List<int> event) {
              //print(utf8.decode(event));
            });

            // send hello
            socket.add(utf8.encode("$key||$name"));

          }
        );
      },

    );
  }

  void refresh(){
    setState(() {
      DeviceRepository().queryAll().then((devices) {
        this.devices = devices;
      });
    });

  }
  @override
  initState() {
    super.initState();
    DeviceRepository().queryAll().then((devices) {
      setState(() {
        this.devices = devices;
      });
    });
  }
}
