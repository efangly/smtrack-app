class User {
  String? message;
  bool? success;
  UserData? data;

  User({this.message, this.success, this.data});

  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
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

class UserData {
  String? userId;
  String? wardId;
  String? userName;
  bool? userStatus;
  String? userLevel;
  String? displayName;
  String? userPic;
  WardInfo? ward;

  UserData({
    this.userId,
    this.wardId,
    this.userName,
    this.userStatus,
    this.userLevel,
    this.displayName,
    this.userPic,
    this.ward,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    wardId = json['wardId'];
    userName = json['userName'];
    userStatus = json['userStatus'];
    userLevel = json['userLevel'];
    displayName = json['displayName'];
    userPic = json['userPic'];
    ward = json['ward'] != null ? WardInfo.fromJson(json['ward']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['wardId'] = wardId;
    data['userName'] = userName;
    data['userStatus'] = userStatus;
    data['userLevel'] = userLevel;
    data['displayName'] = displayName;
    data['userPic'] = userPic;
    if (ward != null) {
      data['ward'] = ward!.toJson();
    }
    return data;
  }

  Map<String, dynamic> toJsonDisplayname() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    return data;
  }

  Map<String, dynamic> toJsonDisble() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userStatus'] = userStatus;
    return data;
  }
}

class WardInfo {
  String? wardName;
  String? hosId;

  WardInfo({this.wardName, this.hosId});

  WardInfo.fromJson(Map<String, dynamic> json) {
    wardName = json['wardName'];
    hosId = json['hosId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wardName'] = wardName;
    data['hosId'] = hosId;
    return data;
  }
}

class ChangePassword {
  String? oldPassword;
  String? password;

  ChangePassword({this.oldPassword, this.password});

  ChangePassword.fromJson(Map<String, dynamic> json) {
    oldPassword = json['oldPassword'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oldPassword'] = oldPassword;
    data['password'] = password;
    return data;
  }
}
