import 'package:flutter/material.dart';
import '../models/notification_item.dart';

class NotificationProvider with ChangeNotifier {
  bool _showPanel = false;
  int _unreadCount = 0;
  int get unreadCount => _unreadCount;

  final List<NotificationItem> _notifications = [];

  bool get showPanel => _showPanel;
  List<NotificationItem> get notifications => _notifications;

  void togglePanel() {
    _showPanel = !_showPanel;
    if (_showPanel) {
      _unreadCount = 0;
    }
    notifyListeners();
  }

  void addNotification(NotificationItem notification) {
    _notifications.insert(0, notification);
    _unreadCount++;
    notifyListeners();
  }
}
