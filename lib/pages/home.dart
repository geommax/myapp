import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/ribbon_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final tabs = ["Navigation", "Mapping", "WayPoints", "License", "Settings"];

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
                          ribbonState.setSelectedTab(index);
                        },
                        indicator: BoxDecoration(
                          color: ribbonState.showRibbon
                              ? Colors.blueAccent.withOpacity(0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        labelColor: Colors.blueAccent,
                        unselectedLabelColor: themeProvider.isDarkMode
                            ? Colors.white70
                            : Colors.black54,
                        tabs: tabs.map((name) => Tab(text: name)).toList(),
                      ),
                    ),
                    // Ribbon toggle
                    IconButton(
                      tooltip: ribbonState.showRibbon ? "Hide Ribbon" : "Show Ribbon",
                      icon: Icon(
                        ribbonState.showRibbon
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
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
                    height: 70,
                    child: _buildRibbonContent(ribbonState.selectedTab),
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
                        child: Container(
                          color: themeProvider.isDarkMode
                              ? Colors.black87
                              : Colors.black12,
                          child: const Center(
                            child: Text(
                              "Mapping / Localization Space",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
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

  // ===== Ribbon content builder =====
  Widget _buildRibbonContent(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return _buildRibbonGroup([
          _buildRibbonButton(Icons.content_copy, "Copy"),
          _buildRibbonButton(Icons.cut, "Cut"),
          _buildRibbonButton(Icons.paste, "Paste"),
        ]);
      case 1:
        return _buildRibbonGroup([
          _buildRibbonButton(Icons.format_bold, "Bold"),
          _buildRibbonButton(Icons.format_italic, "Italic"),
          _buildRibbonButton(Icons.format_underline, "Underline"),
        ]);
      case 2:
        return _buildRibbonGroup([
          _buildRibbonButton(Icons.zoom_in, "Zoom In"),
          _buildRibbonButton(Icons.zoom_out, "Zoom Out"),
          _buildRibbonButton(Icons.fullscreen, "Full Screen"),
        ]);
      default:
        return const SizedBox();
    }
  }

  Widget _buildRibbonGroup(List<Widget> buttons) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Container(
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: buttons,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRibbonButton(IconData icon, String label) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return InkWell(
          onTap: () {
            debugPrint("$label action executed!");
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 28,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
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
