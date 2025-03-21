import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConvertMessage {
  static String setNotiMsg(String detail) {
    final msgType = detail.split("/");
    String result = "";
    switch (msgType[0]) {
      case "TEMP":
        if (msgType[1] == "OVER") {
          result = "Temperature is too high";
        } else if (msgType[1] == "LOWER") {
          result = "Temperature is too low";
        } else {
          result = "Temperature returned to normal";
        }
        break;
      case "SD":
        result = msgType[1] == "ON" ? "SDCard connected" : "SDCard failed";
        break;
      case "AC":
        result = msgType[1] == "ON" ? "Power on" : "Power off";
        break;
      case "REPORT":
        result = "Report: ${msgType[1]}";
        break;
      default:
        if (msgType[1] == "TEMP") {
          if (msgType[2] == "OVER") {
            result = "${msgType[0].replaceAll("PROBE", "Probe")}: Temp is too high";
          } else if (msgType[2] == "LOWER") {
            result = "${msgType[0].replaceAll("PROBE", "Probe")}: Temp is too low";
          } else {
            result = "${msgType[0].replaceAll("PROBE", "Probe")}: Temp returned to normal";
          }
        } else if (msgType[1] == "SENSOR") {
          if (msgType[2] == "ON") {
            result = "${msgType[0].replaceAll("PROBE", "Probe")}: Sensor is connected";
          } else {
            result = "${msgType[0].replaceAll("PROBE", "Probe")}: Sensor is failed";
          }
        } else {
          if (msgType[2] == "ON") {
            result = "${msgType[0].replaceAll("PROBE", "Probe")}: ${msgType[1].replaceAll("DOOR", "Doors")} is opened";
          } else {
            result = "${msgType[0].replaceAll("PROBE", "Probe")}: ${msgType[1].replaceAll("DOOR", "Doors")} is closed";
          }
        }
    }
    return result;
  }

  static Widget showIcon(String data, double iconSize) {
    final result = data.split("/");
    switch (result[0]) {
      case "TEMP":
        return FaIcon(FontAwesomeIcons.temperatureLow, size: iconSize);
      case "SD":
        return FaIcon(FontAwesomeIcons.sdCard, size: iconSize);
      case "AC":
        if (result[1] == "ON") {
          return FaIcon(FontAwesomeIcons.plugCircleCheck, size: iconSize);
        } else {
          return FaIcon(FontAwesomeIcons.plugCircleXmark, size: iconSize);
        }
      case "REPORT":
        return FaIcon(FontAwesomeIcons.file, size: iconSize);
      default:
        if (result[1] == "TEMP") {
          if (result[2] == "OVER") {
            return FaIcon(FontAwesomeIcons.temperatureArrowUp, size: iconSize);
          } else if (result[2] == "LOWER") {
            return FaIcon(FontAwesomeIcons.temperatureArrowDown, size: iconSize);
          } else {
            return FaIcon(FontAwesomeIcons.temperatureLow, size: iconSize);
          }
        } else if (result[1] == "SENSOR") {
          return FaIcon(result[2] == "ON" ? FontAwesomeIcons.check : FontAwesomeIcons.xmark, size: iconSize);
        } else {
          return FaIcon(result[2] == "ON" ? FontAwesomeIcons.doorOpen : FontAwesomeIcons.doorClosed, size: iconSize);
        }
    }
  }
}
