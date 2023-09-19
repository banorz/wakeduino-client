import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:wakeduino_remote/model/device_repository.dart';
import 'package:wakeduino_remote/screens/settings_screen.dart';
import '../model/device_model.dart';
import '../view/device_list.dart';

class InsertScreen extends StatelessWidget {
  InsertScreen({super.key, this.initialMacAddress});
  final String? initialMacAddress;
  final deviceMacController = TextEditingController();
  final deviceNameController = TextEditingController();


  @override
  Widget build(BuildContext context){
    const title = 'New Device';
    deviceMacController.text = (initialMacAddress ?? "");
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        title: const Text(title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex:1,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  const Text("Device Name"),
                  TextField(
                    controller: deviceNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a device name',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Device MAC Address"),
                  TextField(
                    controller: deviceMacController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a device MAC address',
                    ),
                  ),
                ],
              ),
            )
          ),
          Center(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,

                    children: <Widget>[

                      Expanded(

                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.grey,
                              minimumSize: Size(80, 70),

                              padding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },

                            child: const Text('Cancel'),

                          )
                      ),
                      Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                              minimumSize: Size(80, 70),

                              padding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            onPressed: () async {
                              DeviceRepository().insert(
                                  DeviceModel(name: deviceNameController.value.text,
                                      macAddress: deviceMacController.value.text));
                              Navigator.of(context).pop();

                            },

                            child: const Text('Save'),

                          )
                      ),

                    ],
                  )
              )
          )
        ]
      )
    );
  }
}