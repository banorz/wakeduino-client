import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

import 'package:flutter/material.dart';

import '../model/device_model.dart';
import '../model/device_repository.dart';
import '../singletons/wakeduino.dart';
import 'non_widgets/toast.dart';
import 'list_items/device_list_item.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class DeviceList extends StatefulWidget {
  const DeviceList({required Key key}) : super(key: key);

  static State<DeviceList>? of(BuildContext context) =>
      context.findAncestorStateOfType<State<DeviceList>>();

  @override
  State<StatefulWidget> createState() {
    return DeviceListState();
  }
}

class DeviceListState extends State<DeviceList> {
  late final Toast toast;

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
            onLongPress: () async {
              if (await confirm(context,
                  title: const Text('Delete device'),
                  content: const Text('Are you sure?'),
                  textOK: const Text('Yes'),
                  textCancel: const Text('No'))) {
                DeviceRepository().remove(device);
                refresh();
              }
              return;
            },
            onTap: () async {
              String hostname = await WakeDuino().getHostname();
              int port = await WakeDuino().getPort();
              String key = await WakeDuino().getKey();
              String macAddress = device.macAddress;
              String name = device.name;
              try {
                Socket socket = await Socket.connect(hostname, port);
                print('connected');
                String response = "";
                // listen to the received data event stream
                socket.listen(
                  (List<int> event) {
                    String msg = utf8.decode(event);
                    response += msg;
                  },
                  onDone: () {
                    print(response);
                    if (response.contains("Ok\r")) {
                      toast.showToast(response);
                    }
                    socket.destroy();
                    print('done');
                  },
                );
                response = "";
                // send hello
                socket.add(utf8.encode("$key||$name"));
                //print('sent');
              } catch (e) {
                if (e is SocketException) {
                  toast.showToast("socket error");
                  print("Socket exception: ${e.toString()}");
                } else if (e is TimeoutException) {
                  toast.showToast("connection timeour");
                  print("Timeout exception: ${e.toString()}");
                } else {
                  toast.showToast("unexpected error");
                  print("Unhandled exception: ${e.toString()}");
                }
              }
            });
      },
    );
  }

  void refresh() {
    setState(() {
      DeviceRepository().queryAll().then((devices) {
        this.devices = devices;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    toast = Toast(context);
    DeviceRepository().queryAll().then((devices) {
      setState(() {
        this.devices = devices;
      });
    });
  }
}
