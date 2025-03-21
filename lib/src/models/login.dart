class Login {
  String? message;
  bool? success;
  Data? data;

  Login({required this.message, required this.success, this.data});

  Login.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    data['data'] = this.data?.toJson();
    return data;
  }
}

class Data {
  String? token;
  String? userId;
  String? hosId;
  String? wardId;
  String? userLevel;
  String? hosPic;
  String? hosName;
  bool? userStatus;
  String? userName;
  String? displayName;
  String? userPic;

  Data(
      {required this.token,
      required this.userId,
      required this.hosId,
      required this.wardId,
      required this.userLevel,
      required this.hosPic,
      required this.hosName,
      required this.userStatus,
      required this.userName,
      required this.displayName,
      required this.userPic});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
    hosId = json['hosId'];
    wardId = json['wardId'];
    userLevel = json['userLevel'];
    hosPic = json['hosPic'];
    hosName = json['hosName'];
    userStatus = json['userStatus'];
    userName = json['userName'];
    displayName = json['displayName'];
    userPic = json['userPic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['userId'] = userId;
    data['hosId'] = hosId;
    data['wardId'] = wardId;
    data['userLevel'] = userLevel;
    data['hosPic'] = hosPic;
    data['hosName'] = hosName;
    data['userStatus'] = userStatus;
    data['userName'] = userName;
    data['displayName'] = displayName;
    data['userPic'] = userPic;
    return data;
  }
}
