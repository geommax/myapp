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


class NotificationPopover extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final VoidCallback? onDismiss;

  const NotificationPopover({
    Key? key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.textColor,
    this.onDismiss,
  }) : super(key: key);

  @override
  State<NotificationPopover> createState() => _NotificationPopoverState();
}

class _NotificationPopoverState extends State<NotificationPopover> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 200),
      vsync: this,
    )..forward();

    Future.delayed(const Duration(seconds: 2), () {
      _controller.reverse().then((_) {
        widget.onDismiss?.call();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(widget.icon, color: widget.iconColor, size: 20),
              const SizedBox(width: 8),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  widget.title,
                  style: TextStyle(color: widget.textColor),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shows a notification popover near the top right of the app.
/// Can be called from anywhere in the app.
void showNotificationPopover(
  BuildContext context, {
  required String title,
  required IconData icon,
  required Color iconColor,
  required Color textColor,
}) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50,
      right: 24,
      child: NotificationPopover(
        title: title,
        icon: icon,
        iconColor: iconColor,
        textColor: textColor,
        onDismiss: () => entry.remove(),
      ),
    ),
  );
  overlay.insert(entry);
}