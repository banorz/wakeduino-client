
import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:settings_ui/settings_ui.dart';

import '../singletons/wakeduino.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Settings';
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),),
          title: const Text(title),
          centerTitle: true,
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: Text('Impostazioni'),
              tiles: <SettingsTile>[
                SettingsTile(
                  leading: const Icon(Icons.web_asset),
                  title: const Text('Hostname'),
                  onPressed: (BuildContext context) async {
                    String initialValue = await WakeDuino().getHostname();
                    if (!context.mounted) return;
                    String? hostname = await prompt(
                        context, hintText: "127.0.0.1 or www.domain.com",
                        initialValue: initialValue,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an address';
                          }
                          return null;
                        }, title: const Text('WakeDuino Host'));
                    if(hostname!=null){
                      WakeDuino().setHostname(hostname);
                    }
                  },
                ),
                SettingsTile(
                  leading: const Icon(Icons.web_asset),
                  title: const Text('Port'),
                  onPressed: (BuildContext context) async {
                    String initialValue = (await WakeDuino().getPort())
                        .toString();
                    if (!context.mounted) return;
                    String? portString = await prompt(context, hintText: "6923",
                        initialValue: initialValue,
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a port';
                          }
                          return null;
                        },
                        title: const Text('WakeDuino Port'));
                    if(portString!=null){
                      int port = int.parse(portString!);
                      WakeDuino().setPort(port);
                    }
                  },
                ),
                SettingsTile(
                  leading: const Icon(Icons.key),
                  title: const Text('Key'),
                  onPressed: (BuildContext context) async {
                    String initialValue = await WakeDuino().getKey();
                    if (!context.mounted) return;
                    String? key = await prompt(context, hintText: "insert secret key",
                        initialValue: initialValue,
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a key';
                          }
                          return null;
                        },
                        title: const Text('WakeDuino Secret Key'));
                    if(key!=null){
                      WakeDuino().setKey(key);
                    }
                  },
                ),
                SettingsTile(
                  leading: const Icon(Icons.key),
                  title: const Text('Key'),
                  onPressed: (BuildContext context) async {
                    String initialValue = await WakeDuino().getKey();
                    if (!context.mounted) return;
                    String? key = await prompt(context, hintText: "insert secret key",
                        initialValue: initialValue,
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a key';
                          }
                          return null;
                        },
                        title: const Text('WakeDuino Secret Key'));
                    if(key!=null){
                      WakeDuino().setKey(key);
                    }
                  },
                )
              ],
            ),
          ],
        )
    );
  }
}


