class Hospital {
  String? message;
  bool? success;
  List<HospitalData>? data;

  Hospital({this.message, this.success, this.data});

  Hospital.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    if (json['data'] != null) {
      data = <HospitalData>[];
      json['data'].forEach((v) {
        data!.add(HospitalData.fromJson(v));
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

class HospitalData {
  String? hosId;
  String? hosName;
  String? hosAddress;
  String? hosTelephone;
  String? userContact;
  String? userTelePhone;
  String? hosLatitude;
  String? hosLongitude;
  String? hosPic;
  String? createAt;
  String? updateAt;
  List<Ward>? ward;

  HospitalData(
      {this.hosId,
      this.hosName,
      this.hosAddress,
      this.hosTelephone,
      this.userContact,
      this.userTelePhone,
      this.hosLatitude,
      this.hosLongitude,
      this.hosPic,
      this.createAt,
      this.updateAt,
      this.ward});

  HospitalData.fromJson(Map<String, dynamic> json) {
    hosId = json['hosId'];
    hosName = json['hosName'];
    hosAddress = json['hosAddress'];
    hosTelephone = json['hosTelephone'];
    userContact = json['userContact'];
    userTelePhone = json['userTelePhone'];
    hosLatitude = json['hosLatitude'];
    hosLongitude = json['hosLongitude'];
    hosPic = json['hosPic'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    if (json['ward'] != null) {
      ward = <Ward>[];
      json['ward'].forEach((v) {
        ward!.add(Ward.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hosId'] = hosId;
    data['hosName'] = hosName;
    data['hosAddress'] = hosAddress;
    data['hosTelephone'] = hosTelephone;
    data['userContact'] = userContact;
    data['userTelePhone'] = userTelePhone;
    data['hosLatitude'] = hosLatitude;
    data['hosLongitude'] = hosLongitude;
    data['hosPic'] = hosPic;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    if (ward != null) {
      data['ward'] = ward!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ward {
  String? wardId;
  String? wardName;
  int? wardSeq;
  String? hosId;
  String? createAt;
  String? updateAt;

  Ward({this.wardId, this.wardName, this.wardSeq, this.hosId, this.createAt, this.updateAt});

  Ward.fromJson(Map<String, dynamic> json) {
    wardId = json['wardId'];
    wardName = json['wardName'];
    wardSeq = json['wardSeq'];
    hosId = json['hosId'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wardId'] = wardId;
    data['wardName'] = wardName;
    data['wardSeq'] = wardSeq;
    data['hosId'] = hosId;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    return data;
  }
}
