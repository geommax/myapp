import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String subtitle;
  final DateTime timestamp;
  final IconData icon;
  final Color iconColor;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.timestamp,
    this.icon = Icons.check_circle,
    this.iconColor = Colors.green,
  });
}
