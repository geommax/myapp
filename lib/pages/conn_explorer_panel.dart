import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/conn_explorer_provider.dart';

class ConnExplorerPanel extends StatefulWidget {
  const ConnExplorerPanel({super.key});

  @override
  State<ConnExplorerPanel> createState() => _ConnExplorerPanelState();
}

class _ConnExplorerPanelState extends State<ConnExplorerPanel> {

  @override
  Widget build(BuildContext context) {
  return Consumer2<ThemeProvider, ConnExplorerPanelStateProvider>(
  builder: (context, themeProvider, connExplorerState, child) {
    final Color appbarBackground = themeProvider.colors.appbarBackground;
    final Color ribbonbarBackground = themeProvider.colors.ribbonbarBackground;
    final Color iconColor = themeProvider.colors.iconColor;
    final Color defaultLabelColor = themeProvider.colors.defaultLabelColor;
    final Color subLabelColor = themeProvider.colors.subLabelColor;
    final Color subIconColor = themeProvider.colors.subIconColor;

    return Container(
      color: appbarBackground,
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // Header with title and close button
          Container(
            height: 26,
            width: double.infinity,
            color: ribbonbarBackground,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Connection Panel',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: subLabelColor,
                  ),
                ),
                
                IconButton(
                  iconSize: 14,
                  tooltip: "Collapse Panel",
                  icon: Icon(
                    Icons.close_fullscreen_outlined,
                    color: subIconColor,
                  ),
                  onPressed: () {
                    connExplorerState.toggleExplorerPanel();
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          ExpansionTile(
            key: const PageStorageKey("Robots"),
            leading: Icon(Icons.smart_toy, color: iconColor),
            title: Text('Robots', style: TextStyle(color: defaultLabelColor)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.add, color: iconColor),
                  tooltip: "Add Robot",
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Control Robots',
                      applicationVersion: '1.0.0',
                      applicationIcon: const Icon(Icons.smart_toy),
                      children: [
                        const Text('Add Robot functionality is not implemented yet.'),
                      ],
                    );
                  },
                ),
                Icon(
                  connExplorerState.robotsExpanded
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: iconColor,
                ),
              ],
            ),
            onExpansionChanged: (_) => connExplorerState.toggleRobotsExpanded(),
            children: [
              ListTile(
                title: Text("Robot A - 192.168.1.10:5000"),
              ),
              ListTile(
                title: Text("Robot B - 192.168.1.20:5001"),
              ),
            ],
          ),
          ExpansionTile(
            key: const PageStorageKey("Lasers"),
            leading: Icon(Icons.image, color: iconColor),
            title: Text('Lasers', style: TextStyle(color: defaultLabelColor)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.add, color: iconColor),
                  tooltip: "Add Laser",
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Control Lasers',
                      applicationVersion: '1.0.0',
                      applicationIcon: const Icon(Icons.waves_outlined),
                      children: [
                        const Text('Add Laser functionality is not implemented yet.'),
                      ],
                    );
                  },
                ),
                Icon(
                  connExplorerState.lasersExpanded
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: iconColor,
                ),
              ],
            ),
            onExpansionChanged: (_) => connExplorerState.toggleLasersExpanded(),
            children: [
              ListTile(
                title: Text("Laser A - 192.168.1.30:6000"),
              ),
              ListTile(
                title: Text("Laser B - 192.168.1.40:6001"),
              ),
            ],
          ),
        ],
      ),
    );
  },
);
}
}
