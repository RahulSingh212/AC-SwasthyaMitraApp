// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class calorie {
  final int Calorie;
  final DateTime Date_time;
  final Color color;

  calorie({
    required this.Calorie,
    required this.Date_time,
    this.color = const Color(0xff0084f2),
  });
}
