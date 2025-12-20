import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayItem extends StatelessWidget {
  final DateTime date;
  final bool active;

  const DayItem({
    super.key,
    required this.date,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final String month = DateFormat('MMM').format(date).toUpperCase();
    final String day = DateFormat('d').format(date);
    final String week = DateFormat('EEE').format(date).toUpperCase();

    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: active ? Colors.deepPurple : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            month,
            style: TextStyle(
              fontSize: 12,
              color: active ? Colors.white : Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            day,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: active ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            week,
            style: TextStyle(
              fontSize: 12,
              color: active ? Colors.white : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
