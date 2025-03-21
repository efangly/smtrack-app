class Device {
  String? message;
  bool? success;
  List<DeviceList>? data;

  Device({this.message, this.success, this.data});

  Device.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    if (json['data'] != null) {
      data = <DeviceList>[];
      json['data'].forEach((v) => data!.add(DeviceList.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeviceList {
  String? devId;
  String? wardId;
  String? devSerial;
  String? devName;
  String? devDetail;
  bool? devStatus;
  int? devSeq;
  String? devZone;
  String? locInstall;
  String? locPic;
  String? dateInstall;
  String? firmwareVersion;
  String? createBy;
  String? comment;
  String? backupStatus;
  String? moveStatus;
  bool? alarm;
  String? duration;
  String? createAt;
  String? updateAt;
  List<Log>? log;
  List<Probe>? probe;
  Config? config;
  List<Noti>? noti;
  CountDev? cCount;

  DeviceList(
      {this.devId,
      this.wardId,
      this.devSerial,
      this.devName,
      this.devDetail,
      this.devStatus,
      this.devSeq,
      this.devZone,
      this.locInstall,
      this.locPic,
      this.dateInstall,
      this.firmwareVersion,
      this.createBy,
      this.comment,
      this.backupStatus,
      this.moveStatus,
      this.alarm,
      this.duration,
      this.createAt,
      this.updateAt,
      this.log,
      this.probe,
      this.config,
      this.noti,
      this.cCount});

  DeviceList.fromJson(Map<String, dynamic> json) {
    devId = json['devId'];
    wardId = json['wardId'];
    devSerial = json['devSerial'];
    devName = json['devName'];
    devDetail = json['devDetail'];
    devStatus = json['devStatus'];
    devSeq = json['devSeq'];
    devZone = json['devZone'];
    locInstall = json['locInstall'];
    locPic = json['locPic'];
    dateInstall = json['dateInstall'];
    firmwareVersion = json['firmwareVersion'];
    createBy = json['createBy'];
    comment = json['comment'];
    backupStatus = json['backupStatus'];
    moveStatus = json['moveStatus'];
    alarm = json['alarn'];
    duration = json['duration'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    if (json['log'] != null) {
      log = <Log>[];
      json['log'].forEach((v) {
        log!.add(Log.fromJson(v));
      });
    }
    if (json['probe'] != null) {
      probe = <Probe>[];
      json['probe'].forEach((v) {
        probe!.add(Probe.fromJson(v));
      });
    }
    config = json['config'] != null ? Config.fromJson(json['config']) : null;
    if (json['noti'] != null) {
      noti = <Noti>[];
      json['noti'].forEach((v) {
        noti!.add(Noti.fromJson(v));
      });
    }
    cCount = json['_count'] != null ? CountDev.fromJson(json['_count']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['devId'] = devId;
    data['wardId'] = wardId;
    data['devSerial'] = devSerial;
    data['devName'] = devName;
    data['devDetail'] = devDetail;
    data['devStatus'] = devStatus;
    data['devSeq'] = devSeq;
    data['devZone'] = devZone;
    data['locInstall'] = locInstall;
    data['locPic'] = locPic;
    data['dateInstall'] = dateInstall;
    data['firmwareVersion'] = firmwareVersion;
    data['createBy'] = createBy;
    data['comment'] = comment;
    data['backupStatus'] = backupStatus;
    data['moveStatus'] = moveStatus;
    data['alarn'] = alarm;
    data['duration'] = duration;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    if (probe != null) {
      data['probe'] = probe!.map((v) => v.toJson()).toList();
    }
    if (config != null) {
      data['config'] = config!.toJson();
    }
    if (cCount != null) {
      data['_count'] = cCount!.toJson();
    }
    return data;
  }
}

class Log {
  String? logId;
  String? devSerial;
  num? tempValue;
  num? tempAvg;
  num? humidityValue;
  num? humidityAvg;
  String? sendTime;
  String? ac;
  String? door1;
  String? door2;
  String? door3;
  String? internet;
  String? probe;
  int? battery;
  num? ambient;
  String? sdCard;
  String? createAt;
  String? updateAt;

  Log(
      {this.logId,
      this.devSerial,
      this.tempValue,
      this.tempAvg,
      this.humidityValue,
      this.humidityAvg,
      this.sendTime,
      this.ac,
      this.door1,
      this.door2,
      this.door3,
      this.internet,
      this.probe,
      this.battery,
      this.ambient,
      this.sdCard,
      this.createAt,
      this.updateAt});

  Log.fromJson(Map<String, dynamic> json) {
    logId = json['logId'];
    devSerial = json['devSerial'];
    tempValue = json['tempValue'];
    tempAvg = json['tempAvg'];
    humidityValue = json['humidityValue'];
    humidityAvg = json['humidityAvg'];
    sendTime = json['sendTime'];
    ac = json['ac'];
    door1 = json['door1'];
    door2 = json['door2'];
    door3 = json['door3'];
    internet = json['internet'];
    probe = json['probe'];
    battery = json['battery'];
    ambient = json['ambient'];
    sdCard = json['sdCard'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logId'] = logId;
    data['devSerial'] = devSerial;
    data['tempValue'] = tempValue;
    data['tempAvg'] = tempAvg;
    data['humidityValue'] = humidityValue;
    data['humidityAvg'] = humidityAvg;
    data['sendTime'] = sendTime;
    data['ac'] = ac;
    data['door1'] = door1;
    data['door2'] = door2;
    data['door3'] = door3;
    data['internet'] = internet;
    data['probe'] = probe;
    data['battery'] = battery;
    data['ambient'] = ambient;
    data['sdCard'] = sdCard;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    return data;
  }
}

class Probe {
  String? probeId;
  String? probeName;
  String? probeType;
  String? probeCh;
  num? tempMin;
  num? tempMax;
  num? humMin;
  num? humMax;
  num? adjustTemp;
  num? adjustHum;
  String? delayTime;
  int? door;
  String? location;
  String? devSerial;
  String? createAt;
  String? updateAt;

  Probe(
      {this.probeId,
      this.probeName,
      this.probeType,
      this.probeCh,
      this.tempMin,
      this.tempMax,
      this.humMin,
      this.humMax,
      this.adjustTemp,
      this.adjustHum,
      this.delayTime,
      this.door,
      this.location,
      this.devSerial,
      this.createAt,
      this.updateAt});

  Probe.fromJson(Map<String, dynamic> json) {
    probeId = json['probeId'];
    probeName = json['probeName'];
    probeType = json['probeType'];
    probeCh = json['probeCh'];
    tempMin = json['tempMin'];
    tempMax = json['tempMax'];
    humMin = json['humMin'];
    humMax = json['humMax'];
    adjustTemp = json['adjustTemp'];
    adjustHum = json['adjustHum'];
    delayTime = json['delayTime'];
    door = json['door'];
    location = json['location'];
    devSerial = json['devSerial'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['probeId'] = probeId;
    data['probeName'] = probeName;
    data['probeType'] = probeType;
    data['probeCh'] = probeCh;
    data['tempMin'] = tempMin;
    data['tempMax'] = tempMax;
    data['humMin'] = humMin;
    data['humMax'] = humMax;
    data['adjustTemp'] = adjustTemp;
    data['adjustHum'] = adjustHum;
    data['delayTime'] = delayTime;
    data['door'] = door;
    data['location'] = location;
    data['devSerial'] = devSerial;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    return data;
  }
}

class Config {
  String? confId;
  String? ip;
  String? macAddEth;
  String? macAddWiFi;
  String? subNet;
  String? getway;
  String? dns;
  String? ssid;
  String? ssidPass;
  String? sim;
  String? email1;
  String? email2;
  String? email3;
  num? notiTime;
  String? backToNormal;
  String? mobileNoti;
  num? repeat;
  String? firstDay;
  String? secondDay;
  String? thirdDay;
  String? firstTime;
  String? secondTime;
  String? thirdTime;
  String? muteDoor;
  String? muteLong;
  String? devSerial;
  String? createAt;
  String? updateAt;

  Config(
      {this.confId,
      this.ip,
      this.macAddEth,
      this.macAddWiFi,
      this.subNet,
      this.getway,
      this.dns,
      this.ssid,
      this.ssidPass,
      this.sim,
      this.email1,
      this.email2,
      this.email3,
      this.notiTime,
      this.backToNormal,
      this.mobileNoti,
      this.repeat,
      this.firstDay,
      this.secondDay,
      this.thirdDay,
      this.firstTime,
      this.secondTime,
      this.thirdTime,
      this.devSerial,
      this.createAt,
      this.updateAt});

  Config.fromJson(Map<String, dynamic> json) {
    confId = json['confId'];
    ip = json['ip'];
    macAddEth = json['macAddEth'];
    macAddWiFi = json['macAddWiFi'];
    subNet = json['subNet'];
    getway = json['getway'];
    dns = json['dns'];
    ssid = json['ssid'];
    ssidPass = json['ssidPass'];
    sim = json['sim'];
    email1 = json['email1'];
    email2 = json['email2'];
    email3 = json['email3'];
    notiTime = json['notiTime'];
    backToNormal = json['backToNormal'];
    mobileNoti = json['mobileNoti'];
    repeat = json['repeat'];
    firstDay = json['firstDay'];
    secondDay = json['secondDay'];
    thirdDay = json['thirdDay'];
    firstTime = json['firstTime'];
    secondTime = json['secondTime'];
    thirdTime = json['thirdTime'];
    devSerial = json['devSerial'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['confId'] = confId;
    data['ip'] = ip;
    data['macAddEth'] = macAddEth;
    data['macAddWiFi'] = macAddWiFi;
    data['subNet'] = subNet;
    data['getway'] = getway;
    data['dns'] = dns;
    data['ssid'] = ssid;
    data['ssidPass'] = ssidPass;
    data['sim'] = sim;
    data['email1'] = email1;
    data['email2'] = email2;
    data['email3'] = email3;
    data['notiTime'] = notiTime;
    data['backToNormal'] = backToNormal;
    data['mobileNoti'] = mobileNoti;
    data['repeat'] = repeat;
    data['firstDay'] = firstDay;
    data['secondDay'] = secondDay;
    data['thirdDay'] = thirdDay;
    data['firstTime'] = firstTime;
    data['secondTime'] = secondTime;
    data['thirdTime'] = thirdTime;
    data['devSerial'] = devSerial;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    return data;
  }
}

class Noti {
  String? notiId;
  String? devSerial;
  String? notiDetail;
  bool? notiStatus;
  String? createAt;
  String? updateAt;

  Noti({this.notiId, this.devSerial, this.notiDetail, this.notiStatus, this.createAt, this.updateAt});

  Noti.fromJson(Map<String, dynamic> json) {
    notiId = json['notiId'];
    devSerial = json['devSerial'];
    notiDetail = json['notiDetail'];
    notiStatus = json['notiStatus'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notiId'] = notiId;
    data['devSerial'] = devSerial;
    data['notiDetail'] = notiDetail;
    data['notiStatus'] = notiStatus;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    return data;
  }
}

class CountDev {
  int? warranty;
  int? repair;
  int? history;
  int? log;

  CountDev({this.warranty, this.repair, this.history, this.log});

  CountDev.fromJson(Map<String, dynamic> json) {
    warranty = json['warranty'];
    repair = json['repair'];
    history = json['history'];
    log = json['log'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['warranty'] = warranty;
    data['repair'] = repair;
    data['history'] = history;
    data['log'] = log;
    return data;
  }
}

class DeviceById {
  String? message;
  bool? success;
  DeviceId? data;

  DeviceById({this.message, this.success, this.data});

  DeviceById.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? DeviceId.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DeviceId {
  String? devId;
  String? wardId;
  String? devSerial;
  String? devName;
  String? devDetail;
  bool? devStatus;
  int? devSeq;
  String? devZone;
  String? locInstall;
  String? locPic;
  String? dateInstall;
  String? firmwareVersion;
  String? createBy;
  String? comment;
  String? backupStatus;
  String? moveStatus;
  bool? alarm;
  String? duration;
  String? createAt;
  String? updateAt;

  DeviceId({
    this.devId,
    this.wardId,
    this.devSerial,
    this.devName,
    this.devDetail,
    this.devStatus,
    this.devSeq,
    this.devZone,
    this.locInstall,
    this.locPic,
    this.dateInstall,
    this.firmwareVersion,
    this.createBy,
    this.comment,
    this.backupStatus,
    this.moveStatus,
    this.alarm,
    this.duration,
    this.createAt,
    this.updateAt,
  });

  DeviceId.fromJson(Map<String, dynamic> json) {
    devId = json['devId'];
    wardId = json['wardId'];
    devSerial = json['devSerial'];
    devName = json['devName'];
    devDetail = json['devDetail'];
    devStatus = json['devStatus'];
    devSeq = json['devSeq'];
    devZone = json['devZone'];
    locInstall = json['locInstall'];
    locPic = json['locPic'];
    dateInstall = json['dateInstall'];
    firmwareVersion = json['firmwareVersion'];
    createBy = json['createBy'];
    comment = json['comment'];
    backupStatus = json['backupStatus'];
    moveStatus = json['moveStatus'];
    alarm = json['alarm'];
    duration = json['duration'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['devId'] = devId;
    data['wardId'] = wardId;
    data['devSerial'] = devSerial;
    data['devName'] = devName;
    data['devDetail'] = devDetail;
    data['devStatus'] = devStatus;
    data['devSeq'] = devSeq;
    data['devZone'] = devZone;
    data['locInstall'] = locInstall;
    data['locPic'] = locPic;
    data['dateInstall'] = dateInstall;
    data['firmwareVersion'] = firmwareVersion;
    data['createBy'] = createBy;
    data['comment'] = comment;
    data['backupStatus'] = backupStatus;
    data['moveStatus'] = moveStatus;
    data['alarm'] = alarm;
    data['duration'] = duration;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    return data;
  }
}
