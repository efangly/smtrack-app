class LegacyNotification {
  List<LegacyNotificationList>? data;
  String? message;
  bool? success;

  LegacyNotification({this.data, this.message, this.success});

  LegacyNotification.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LegacyNotificationList>[];
      json['data'].forEach((v) {
        data!.add(LegacyNotificationList.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}

class LegacyNotificationList {
  String? createdAt;
  String? mcuId;
  String? message;
  String? probe;

  LegacyNotificationList({this.createdAt, this.mcuId, this.message, this.probe});

  LegacyNotificationList.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    mcuId = json['mcuId'];
    message = json['message'];
    probe = json['probe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['mcuId'] = mcuId;
    data['message'] = message;
    data['probe'] = probe;
    return data;
  }
}
