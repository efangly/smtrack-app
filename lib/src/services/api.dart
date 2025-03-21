import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_noti/src/constants/timer.dart';
import 'package:temp_noti/src/constants/url.dart';
import 'package:temp_noti/src/models/models.dart';
import 'package:temp_noti/src/services/services.dart';

class Api {
  Api._internal();

  static final Api _instance = Api._internal();
  factory Api() => _instance;

  static final _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          options.baseUrl = URL.BASE_URL;
          options.headers['Authorization'] = prefs.getString('token') ?? '';
          options.headers["Content-Type"] = "application/json";
          options.connectTimeout = Timer.CONNECT_TIMEOUT;
          options.receiveTimeout = Timer.RECEIVE_TIMEOUT;
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (e, handler) {
          return handler.next(e);
        },
      ),
    );

  static Future<Login> checkLogin(String username, String password) async {
    try {
      final Response response = await _dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Login valueMap = Login.fromJson(json.decode(jsonEncode(response.data)));
        String topic = "";
        await prefs.setString('token', "Bearer ${valueMap.data!.token}");
        await prefs.setString('userId', valueMap.data!.userId ?? "");
        switch (valueMap.data!.userLevel) {
          case "1":
            topic = "service";
            break;
          case "2":
            topic = valueMap.data!.hosId!;
            break;
          case "3":
            topic = valueMap.data!.wardId!;
            break;
          case "4":
            topic = valueMap.data!.wardId!;
            break;
          default:
            topic = "admin";
            break;
        }
        await prefs.setString('topic', topic);
        await prefs.setBool('noti', true);
        FirebaseApi().subscribeTopic(topic);
        return valueMap;
      } else {
        throw Exception('Failed to login');
      }
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  static Future<bool> register(String username, String password, String displayName) async {
    try {
      final Response response = await _dio.post('/auth/register', data: {
        'userName': username,
        'userPassword': password,
        'displayName': displayName,
        'wardId': 'WID-GUEST',
      });
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to register');
      }
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  static Future<List<DeviceList>> getDevice() async {
    List<DeviceList> device = [];
    try {
      final Response response = await _dio.get(
        '/device',
        options: Options(validateStatus: (_) => true),
      );
      if (response.statusCode == 200) {
        Device value = Device.fromJson(response.data as Map<String, dynamic>);
        device = value.data!;
        return device;
      } else {
        if (response.statusCode == 401) throw Exception('Unauthorized');
        return device;
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  static Future<DeviceId?> getDeviceById(String devId) async {
    try {
      final Response response = await _dio.get(
        '/device/$devId',
        options: Options(validateStatus: (_) => true),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data as Map<String, dynamic>;
        DeviceById value = DeviceById.fromJson(data);
        return value.data!;
      } else {
        return null;
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  static Future<List<NotiList>> getNotification() async {
    List<NotiList> notificate = [];
    try {
      final Response response = await _dio.get('/notification', options: Options(validateStatus: (_) => true));
      if (response.statusCode == 200) {
        Notifications value = Notifications.fromJson(json.decode(jsonEncode(response.data)));
        return value.data!;
      } else {
        return notificate;
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  static Future<UserData?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final Response response = await _dio.get('/user/${prefs.getString('userId') ?? ""}');
      if (response.statusCode == 200) {
        User value = User.fromJson(json.decode(jsonEncode(response.data)));
        return value.data!;
      } else {
        return null;
      }
    } on DioException catch (error) {
      if (kDebugMode) print(error.toString());
      return null;
    }
  }

  static Future<List<HospitalData>> getHospital() async {
    try {
      final Response response = await _dio.get('/hospital');
      if (response.statusCode == 200) {
        Hospital value = Hospital.fromJson(json.decode(jsonEncode(response.data)));
        return value.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  static Future<bool> updateDevice(String devId, Configs configs) async {
    try {
      final Response response = await _dio.patch('/config/$devId', data: configs.toJson());
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update device');
      }
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  static Future<bool> updateUser(String userId, UserData user) async {
    try {
      final Response response = await _dio.put('/user/$userId', data: user.toJsonDisplayname());
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update user');
      }
    } on DioException {
      rethrow;
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  static Future<bool> deleteUser(String userId) async {
    try {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['userStatus'] = "0";
      final Response response = await _dio.put('/user/$userId', data: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update user');
      }
    } on DioException {
      rethrow;
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  static Future<bool> changPass(String userId, ChangePassword pass) async {
    try {
      final Response response = await _dio.patch('/auth/reset/$userId', data: pass.toJson());
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update password');
      }
    } on DioException {
      rethrow;
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}
