class DeviceModel {
  final String name;
  final String macAddress;

  DeviceModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        macAddress = json['macAddress'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'macAddress': macAddress,
      };

  DeviceModel({required this.name, required this.macAddress});
}
