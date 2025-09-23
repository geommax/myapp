import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notification_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationPanel extends StatelessWidget {
  const NotificationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        return Visibility(
          visible: provider.showPanel,
          child: Container(
            width: 340,
            color: const Color(0xFF3C4043),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(color: Colors.grey, height: 1),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = provider.notifications[index];
                      return ListTile(
                        leading: Icon(
                          notification.icon,
                          color: notification.iconColor,
                        ),
                        title: Text(
                          notification.title,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          notification.subtitle,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: Text(
                          timeago.format(notification.timestamp),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
