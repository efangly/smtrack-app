class Notifications {
  String? message;
  bool? success;
  List<NotiList>? data;

  Notifications({this.message, this.success, this.data});

  Notifications.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    if (json['data'] != null) {
      data = <NotiList>[];
      json['data'].forEach((v) {
        data!.add(NotiList.fromJson(v));
      });
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

class NotiList {
  String? notiId;
  String? devSerial;
  String? notiDetail;
  bool? notiStatus;
  String? createAt;
  String? updateAt;
  NotiDevice? device;

  NotiList({this.notiId, this.devSerial, this.notiDetail, this.notiStatus, this.createAt, this.updateAt, this.device});

  NotiList.fromJson(Map<String, dynamic> json) {
    notiId = json['notiId'];
    devSerial = json['devSerial'];
    notiDetail = json['notiDetail'];
    notiStatus = json['notiStatus'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    device = json['device'] != null ? NotiDevice.fromJson(json['device']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notiId'] = notiId;
    data['devSerial'] = devSerial;
    data['notiDetail'] = notiDetail;
    data['notiStatus'] = notiStatus;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    if (device != null) {
      data['device'] = device!.toJson();
    }
    return data;
  }
}

class NotiDevice {
  String? devId;
  String? devName;
  String? devSerial;
  String? devDetail;

  NotiDevice({this.devId, this.devName, this.devSerial});

  NotiDevice.fromJson(Map<String, dynamic> json) {
    devId = json['devId'];
    devName = json['devName'];
    devSerial = json['devSerial'];
    devDetail = json['devDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['devId'] = devId;
    data['devName'] = devName;
    data['devSerial'] = devSerial;
    data['devDetail'] = devDetail;
    return data;
  }
}
