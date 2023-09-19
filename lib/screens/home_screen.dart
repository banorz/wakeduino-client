import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:wakeduino_remote/screens/settings_screen.dart';
import '../view/device_list.dart';
import 'insert_screen.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});

  final _deviceListKey = GlobalKey<DeviceListState>();

  @override
  Widget build(BuildContext context) {
    const title = 'Devices';
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: DeviceList( key: _deviceListKey ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? macAddress;
          macAddress = await prompt(context, hintText: "FF:FF:FF:FF:FF:FF",
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a correct mac address';
                }
                return null;
              }, title: const Text('Insert device MAC address'));
          if (macAddress != null) {
            if (!context.mounted) return;
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => InsertScreen(initialMacAddress: macAddress,)));
            _deviceListKey.currentState?.refresh();
          }

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
