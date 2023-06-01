import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class date_time {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime Date_time = DateTime.now();

  Future<DateTime?> selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    return selected;
  }

  Future<TimeOfDay?> selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    return selected;
  }

  static bool check_today(DateTime dateTime1, DateTime dateTime2) {
    return (dateTime1.day == dateTime2.day &&
        dateTime1.month == dateTime2.month &&
        dateTime1.year == dateTime2.year);
  }
}
