import 'package:flutter/material.dart';
import '../models/notification_item.dart';

class NotificationProvider with ChangeNotifier {
  bool _showPanel = false;
  final List<NotificationItem> _notifications = [
    NotificationItem(
      title: 'Delete VM instance "instance-20250910-173643"',
      subtitle: 'My First Project',
      timestamp: DateTime.now().subtract(const Duration(days: 12)),
    ),
    NotificationItem(
      title:
          'Create VM instance "instance-20250910-173643" and its boot disk "instance-20250910-173643"',
      subtitle: 'My First Project',
      timestamp: DateTime.now().subtract(const Duration(days: 12)),
    ),
    NotificationItem(
      title: 'Delete firewall rule "shadowsocks-rule"',
      subtitle: 'My First Project',
      timestamp: DateTime.now().subtract(const Duration(days: 13)),
    ),
  ];

  bool get showPanel => _showPanel;
  List<NotificationItem> get notifications => _notifications;

  void togglePanel() {
    _showPanel = !_showPanel;
    notifyListeners();
  }

  void addNotification(NotificationItem notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }
}
