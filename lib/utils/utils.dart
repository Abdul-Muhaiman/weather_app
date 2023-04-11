import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utilities {
  String getWeekDays(inputDate) {
    DateTime date = DateTime.parse(inputDate);
    String dayName = '';

    switch (date.weekday) {
      case 1:
        dayName = 'Monday';
        break;
      case 2:
        dayName = 'Tuesday';
        break;
      case 3:
        dayName = 'Wednesday';
        break;
      case 4:
        dayName = 'Thursday';
        break;
      case 5:
        dayName = 'Friday';
        break;
      case 6:
        dayName = 'Saturday';
        break;
      case 7:
        dayName = 'Sunday';
        break;
    }

    return dayName;
  }

  convertUTCtoLocal(inputTime) {
// Define the UTC time as a string
    String utcTime = '$inputTime UTC';

// Parse the UTC time into a DateTime object
    DateTime dateTime = DateFormat('HH:mm z').parseUtc(utcTime);

// Get the local time zone
    DateTime timeZone = DateTime.now();
    var localZone = timeZone.timeZoneOffset;

// Convert the UTC time to the local time zone
    dateTime = dateTime.add(Duration(seconds: localZone.inSeconds));

// Format the local time as a string
    String localTime = DateFormat.jm().format(dateTime);

    return localTime;
  }

  showMessage(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
