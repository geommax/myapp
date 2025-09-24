import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/notification_provider.dart';
import '../models/notification_item.dart';
import '../pages/notification_panel.dart';

class RibbonContent extends StatefulWidget {
  final int selectedTab;

  const RibbonContent({
    super.key,
    required this.selectedTab,
  });

  @override
  State<RibbonContent> createState() => _RibbonContentState();
}

class _RibbonContentState extends State<RibbonContent> {
  @override
  Widget build(BuildContext context) {
    // Switch content depending on selected tab
    switch (widget.selectedTab) {
      case 0:
        return _buildMappingTools();
      case 1:
        return _buildMappingTools();
      case 2:
        return _buildMappingTools();
      case 3:
        return _buildMappingTools();
      case 4:
        return _buildMappingTools();
      default: 
        return const SizedBox.shrink();
    }
  }

  Widget _buildMappingTools() {
    // Define icons, texts, and actions
    final icons = [Icons.map, Icons.zoom_in, Icons.layers, Icons.add_alert];
    final texts = ["Show Grid", "Zoom In", "Layers", "Add Notification"];
    final actions = [
      () => print("Show Grid pressed!"),
      () => print("Zoom In pressed!"),
      () => print("Layers pressed!"),
      _addNotification,
    ];

    return Row(
      children: List.generate(icons.length, (index) {
        return Row(
          children: [
            const SizedBox(width: 20),
            _buildRibbonButton(
              icon: icons[index],
              text: texts[index],
              onPressed: actions[index],
            ),
            const SizedBox(width: 8),
          ],
        );
      }),
    );
  }
  

  // can be used from another threads
  // can be used from another threads
  void _addNotification() {
    final notification = NotificationItem(
      title: 'New notification from ribbon',
      subtitle: 'Action performed at ${DateTime.now()}',
      timestamp: DateTime.now(),
      icon: Icons.info,
      iconColor: Colors.blue,
    );

    Provider.of<NotificationProvider>(context, listen: false).addNotification(notification);

    showNotificationPopover(
      context,
      title: notification.title,
      icon: notification.icon,
      iconColor: notification.iconColor,
      textColor: Colors.white,
    );
  }
  // can be used from another threads
  // can be used from another threads

  // Ribbon Button Widget Style
  Widget _buildRibbonButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        Color normalColor = themeProvider.colors.ribbonButtonUnselected;
        Color pressedColor = themeProvider.colors.ribbonButtonSelected;

        bool isPressed = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              onTapDown: (_) {
                setState(() => isPressed = true);
              },
              onTapUp: (_) {
                setState(() => isPressed = false);
                onPressed();
              },
              onTapCancel: () {
                setState(() => isPressed = false);
              },
              child: Container(
                width: 100,
                height: 42,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isPressed ? pressedColor : normalColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: themeProvider.colors.subIconColor),
                ),
                child: Stack(
                  children: [
                    // Icon at top-left
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Icon(
                        icon,
                        color: themeProvider.colors.iconColor,
                        size: 14,
                      ),
                    ),
                    // Text filling remaining space, aligned center-right
                    Positioned.fill(
                      left: 20,
                      top: 2, // leave space below icon
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          text,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: themeProvider.colors.defaultLabelColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 12, // readable size
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )

            );
          },
        );
      },
    );
  }

}