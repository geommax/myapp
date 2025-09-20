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
            backgroundColor:
                themeProvider.isDarkMode ? Colors.grey[900] : Colors.grey[100],

            // ===== AppBar with Tabs and Ribbon Toggle =====
            appBar: AppBar(
              toolbarHeight: 45,
              title: Row(
                children: [
                  const Icon(Icons.smart_toy, size: 18),
                  const SizedBox(width: 6),
                  const Text(
                    'Control Robots',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: themeProvider.isDarkMode
                        ? "Switch to Light Mode"
                        : "Switch to Dark Mode",
                    icon: Icon(
                      themeProvider.isDarkMode
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color:
                          themeProvider.isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                  ),
                ],
              ),

              // Bottom: Tabs Row + Ribbon Toggle
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(30),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    // Robot connection icon
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
                          color:ribbonState.showRibbon ? 
                              (themeProvider.isDarkMode
                                  ? Colors.blueGrey[700]
                                  : Colors.blueGrey[300])
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: ribbonState.showRibbon ?
                            (themeProvider.isDarkMode
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
                                width: 100, // fixed width for all tabs
                                child: Tab(text: name),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    // Ribbon toggle
                    IconButton(
                      tooltip: ribbonState.showRibbon ? "Hide Ribbon" : "Show Ribbon",
                      icon: Icon(
                        ribbonState.showRibbon
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_left,
                        
                        color:
                            themeProvider.isDarkMode ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        ribbonState.toggleRibbon();
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),

            // ===== Body =====
            body: Column(
              children: [
                // Ribbon content (dynamic based on selected tab)
                if (ribbonState.showRibbon)
                  SizedBox(
                    height: 60,
                    //child: _buildRibbonContent(ribbonState.selectedTab),
                    child: RibbonContent(selectedTab: ribbonState.selectedTab),
                  ),

                // Main content: Mapping / Localization
                Expanded(
                  child: Row(
                    children: [
                      // Connection panel
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
                      // Mapping space
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
