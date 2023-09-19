import 'package:shared_preferences/shared_preferences.dart';

class WakeDuino {
  static final WakeDuino _instance = WakeDuino._internal();

  late String hostname;
  late int port;
  late String key;
  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory WakeDuino() {
    return _instance;
  }



  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  WakeDuino._internal(){}

  Future<String> getHostname() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    hostname = pref.getString("wd_hostname") ?? "";
    return hostname;

  }
  Future<int> getPort() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    port = pref.getInt("wd_port") ?? 0;
    return port;
  }
  Future<String> getKey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    key = pref.getString("wd_key") ?? "";
    return key;
  }
  void setHostname(String hostname) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("wd_hostname", hostname);
    this.hostname = hostname;
  }

  void setPort(int port) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("wd_port", port);
    this.port = port;
  }

  void setKey(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("wd_key", key);
    this.key = key;
  }
}