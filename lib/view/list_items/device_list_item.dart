
import 'package:flutter/material.dart';
import 'package:wakeduino_remote/view/list_items/simple_list_item.dart';

/// A ListItem that contains data to display a message.
class DeviceListItem implements SimpleListItem {
  final String deviceName;
  final String body;

  DeviceListItem(this.deviceName, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(deviceName);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}