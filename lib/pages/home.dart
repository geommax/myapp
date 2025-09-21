import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/ribbon_provider.dart';
import '../pages/map.dart';
import '../pages/ribbon_content.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final tabs = ["Navigation", "Mapping", "WayPoints", "Wall", "About"];

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, RibbonStateProvider>(
      builder: (context, themeProvider, ribbonState, child) {
        return DefaultTabController(
          length: tabs.length,
          initialIndex: ribbonState.selectedTab,
          child: Scaffold(
            backgroundColor: themeProvider.isDarkMode
                ? Colors.grey[900]
                : Colors.grey[100],
            body: Column(
              children: [
                Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  color: themeProvider.isDarkMode
                      ? Colors.blueGrey[900]
                      : Colors.blueGrey[100],
                  child: Row(
                    children: [
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
                      IconButton(
                        iconSize: 20,
                        tooltip: "Update Available",
                        icon: Icon(
                          Icons.update_rounded,
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                        onPressed: () {
                          showAboutDialog(
                            context: context,
                            applicationName: 'Control Robots',
                            applicationVersion: '1.0.0',
                            applicationIcon: const Icon(Icons.smart_toy),
                            children: [
                              const Text('You are using the latest version.'),
                            ],
                          );
                        },
                      ),
                      IconButton(
                        iconSize: 20,
                        tooltip: themeProvider.isDarkMode
                            ? "Switch to Light Mode"
                            : "Switch to Dark Mode",
                        icon: Icon(
                          themeProvider.isDarkMode
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                        onPressed: () {
                          themeProvider.toggleTheme();
                        },
                      ),
                      
                    ],
                  ),
                ),
                // Tabs Row + Ribbon Toggle
                Container(
                  height: 45,
                  color: themeProvider.isDarkMode
                      ? Colors.blueGrey[800]
                      : Colors.blueGrey[200],
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      IconButton(
                        tooltip: "Robot Connections",
                        icon: Icon(
                          Icons.add_link,
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                        onPressed: () {
                          ribbonState.toggleConnectionPanel();
                        },
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
                                ? (themeProvider.isDarkMode
                                    ? Colors.blueGrey[700]
                                    : Colors.blueGrey[300])
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: ribbonState.showRibbon
                              ? (themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black)
                              : (themeProvider.isDarkMode
                                  ? Colors.white70
                                  : Colors.black54),
                          unselectedLabelColor: themeProvider.isDarkMode
                              ? Colors.white70
                              : Colors.black54,
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
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        ),
                        onPressed: () {
                          ribbonState.toggleRibbon();
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                // Ribbon content (dynamic based on selected tab)
                if (ribbonState.showRibbon)
                  SizedBox(
                    height: 60,
                    child: RibbonContent(selectedTab: ribbonState.selectedTab),
                  ),
                // Main content: Mapping / Localization
                Expanded(
                  child: Row(
                    children: [
                      if (ribbonState.showConnectionPanel)
                        Container(
                          width: 250,
                          color: themeProvider.isDarkMode
                              ? Colors.blueGrey[900]
                              : Colors.blueGrey[100],
                          child: const Center(
                            child: Text(
                              "Connection Panel Content",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      Expanded(
                        child: MapPage(),
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
