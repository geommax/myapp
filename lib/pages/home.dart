import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/ribbon_provider.dart';
import '../pages/map.dart';
import '../pages/ribbon_content.dart';
import '../pages/conn_explorer_panel.dart';
import '../providers/conn_explorer_provider.dart';
import '../providers/notification_provider.dart';
import 'notification_panel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final tabs = ["Navigation", "Mapping", "WayPoints", "Wall", "About"];
  
  Widget datetimeWidget() {
    final now = DateTime.now();
    final formatted = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} "
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        formatted,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, RibbonStateProvider>(
      builder: (context, themeProvider, ribbonState, child) {
        return DefaultTabController(
          length: tabs.length,
          initialIndex: ribbonState.selectedTab,
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  height: 26,
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  color: themeProvider.colors.appbarBackground,
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      const Icon(Icons.smart_toy, size: 18),
                      const SizedBox(width: 6),
                      const Text(
                        'Control Robots',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      datetimeWidget(),
                      
                    ],
                  ),
                ),
                // Tabs Row + Ribbon Toggle
                Container(
                  height: 36,
                  color: themeProvider.colors.ribbonbarBackground,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Consumer<ConnExplorerPanelStateProvider>(
                        builder: (context, explorerState, _) => IconButton(
                          tooltip: explorerState.showExplorerPanel
                              ? "Hide Connection Explorer"
                              : "Show Connection Explorer",
                          icon: Icon(
                            Icons.add_link,
                            size: 24,
                            color: explorerState.showExplorerPanel
                                ? themeProvider.isDarkMode
                                    ? Colors.blue[300]
                                    : Colors.blue[700] // Highlight color when open 
                                : themeProvider.colors.iconColor, // Default theme color when closed
                          ),
                          onPressed: () {
                            explorerState.toggleExplorerPanel();
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Tabs
                      Expanded(
                        child: TabBar(
                          isScrollable: true,
                          onTap: (index) {
                            ribbonState.toggleTab(index);
                          },
                          indicator: BoxDecoration(
                            color: ribbonState.showRibbon
                                ? (themeProvider.colors.tabSelected)
                                : Colors.transparent,
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: ribbonState.showRibbon
                              ? (themeProvider.colors.selectedLabelColor)
                              : (themeProvider.colors.unselectedLabelColor),
                          unselectedLabelColor: themeProvider.colors.unselectedLabelColor,
                          tabs: tabs
                              .map(
                                (name) => SizedBox(
                                  width: 100,
                                  child: Tab(text: name),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      IconButton(
                        tooltip: ribbonState.showRibbon ? "Hide Ribbon" : "Show Ribbon",
                        icon: Icon(
                          ribbonState.showRibbon
                              ? Icons.keyboard_arrow_up_outlined
                              : Icons.keyboard_arrow_down_outlined,
                          color: themeProvider.colors.iconColor,
                        ),
                        onPressed: () {
                          ribbonState.toggleRibbon();
                        },
                      ),
                      
                      const SizedBox(width: 8),
                      // ...notification panel...
                      Consumer<NotificationProvider>(
                        builder: (context, notificationProvider, _) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showNotificationPanel(context);
                            notificationProvider.togglePanel();
                          },
                          child: Stack(
                            children: [
                              IconButton(
                                alignment: Alignment.center,
                                iconSize: 20,
                                tooltip: "Notifications",
                                icon: Icon(
                                  Icons.notifications,
                                  color: themeProvider.colors.iconColor,
                                ),
                                onPressed: () {
                                  showNotificationPanel(context);
                                  notificationProvider.togglePanel();
                                },
                              ),
                              if (notificationProvider.unreadCount > 0)
                                Positioned(
                                  right: 6,
                                  top: 6,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Text(
                                      '${notificationProvider.unreadCount}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Theme Toggle
                      IconButton(
                        alignment: Alignment.center,
                        iconSize: 18,
                        tooltip: themeProvider.isDarkMode
                            ? "Switch to Light Mode"
                            : "Switch to Dark Mode",
                        icon: Icon(
                          themeProvider.isDarkMode
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined,
                          color: themeProvider.colors.iconColor,
                        ),
                        onPressed: () {
                          themeProvider.toggleTheme();
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                // Ribbon content (dynamic based on selected tab)
                if (ribbonState.showRibbon)
                  Container(
                    color: themeProvider.colors.tabSelected,
                    height: 60,
                    child: RibbonContent(selectedTab: ribbonState.selectedTab),
                  ),
                // Main content: Mapping / Localization
                Expanded(
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Consumer<ConnExplorerPanelStateProvider>(
                            builder: (context, connExplorerState, _) => Visibility(
                              visible: connExplorerState.showExplorerPanel,
                              child: SizedBox(
                                width: 250,
                                child: ConnExplorerPanel(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: MapPage(),
                          ),
                        ],
                      ),
                    ],
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
