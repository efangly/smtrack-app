class Configs {
  String? hosId;
  String? wardId;
  String? deviceName;
  String? devicePosition;
  String? deviceLocation;
  NetworkConfig? config;
  Configs({
    this.hosId,
    this.wardId,
    this.deviceName,
    this.devicePosition,
    this.deviceLocation,
    this.config,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hosId'] = hosId;
    data['wardId'] = wardId;
    if (deviceName != null) data['devDetail'] = deviceName;
    if (devicePosition != null) data['devicePosition'] = devicePosition;
    if (deviceLocation != null) data['deviceLocation'] = deviceLocation;
    if (config != null) data['config'] = config!.toJson();
    return data;
  }
}

class NetworkConfig {
  String? ssid;
  String? wifiPassword;
  String? mode;
  String? ip;
  String? subnet;
  String? gateway;
  String? dns;
  num? notiTime;
  num? repeat;
  String? backToNormal;
  String? mobileNoti;
  String? firstDay;
  String? secondDay;
  String? thirdDay;
  String? firstTime;
  String? secondTime;
  String? thirdTime;
  NetworkConfig({
    this.ssid,
    this.wifiPassword,
    this.mode,
    this.ip,
    this.subnet,
    this.gateway,
    this.dns,
    this.notiTime,
    this.repeat,
    this.backToNormal,
    this.mobileNoti,
    this.firstDay,
    this.secondDay,
    this.thirdDay,
    this.firstTime,
    this.secondTime,
    this.thirdTime,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ssid != null) data['ssid'] = ssid;
    if (wifiPassword != null) data['ssidPass'] = wifiPassword;
    if (mode != null) data['mode'] = mode;
    if (ip != null) data['ip'] = ip;
    if (subnet != null) data['subNet'] = subnet;
    if (gateway != null) data['getway'] = gateway;
    if (dns != null) data['dns'] = dns;
    if (notiTime != null) data['notiTime'] = notiTime;
    if (repeat != null) data['repeat'] = repeat;
    if (backToNormal != null) data['backToNormal'] = backToNormal;
    if (mobileNoti != null) data['mobileNoti'] = mobileNoti;
    if (firstDay != null) data['firstDay'] = firstDay;
    if (secondDay != null) data['secondDay'] = secondDay;
    if (thirdDay != null) data['thirdDay'] = thirdDay;
    if (firstTime != null) data['firstTime'] = firstTime;
    if (secondTime != null) data['secondTime'] = secondTime;
    if (thirdTime != null) data['thirdTime'] = thirdTime;
    return data;
  }
}
