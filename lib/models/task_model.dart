import 'package:flutter/material.dart';

class TaskModel {
  final String title;
  final String description;
  final String time;
  final Color color;
  final DateTime date;

  TaskModel({
    required this.title,
    required this.description,
    required this.time,
    required this.color,
    required this.date,
  });

  get startTime => null;

  get endTime => null;

  get id => null;
}
