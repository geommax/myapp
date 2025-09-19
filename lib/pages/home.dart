import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../providers/theme_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Ribbon tabs
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Scaffold(
            backgroundColor: themeProvider.isDarkMode 
                ? Colors.grey[900] 
                : Colors.grey[100],
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
                    tooltip: "Toggle Theme",
                    icon: Icon(
                      themeProvider.isDarkMode
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                  ),
                ],
              ),
              
              bottom:  PreferredSize(
                preferredSize: const Size.fromHeight(30.0),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Consumer<HomeStateProvider>(
                      builder: (context, homeState, child) {
                        return IconButton(
                          tooltip: "Robot Connections",
                          icon: Icon(
                            Icons.add_link,
                            color: themeProvider.isDarkMode 
                                ? Colors.white 
                                : Colors.black,
                          ),
                          onPressed: () {
                            homeState.toggleConnectionPanel();
                          },
                        );
                      }
                    ),
                    Expanded(
                      child: Consumer<HomeStateProvider>(
                        builder: (context, homeState, child) {
                          return TabBar(
                            isScrollable: true,
                            indicatorColor: themeProvider.isDarkMode 
                                ? Colors.white 
                                : Colors.black,
                            labelColor: themeProvider.isDarkMode 
                                ? Colors.white 
                                : Colors.black,
                            unselectedLabelColor: themeProvider.isDarkMode 
                                ? Colors.white70 
                                : Colors.black54,
                            onTap: (index) {
                              homeState.setSelectedTab(index);
                            },
                            tabs: const [
                              Tab(text: "Navigation"),
                              Tab(text: "Mapping"),
                              Tab(text: "WayPoints"),
                              Tab(text: "License"),
                              Tab(text: "Settings"),
                            ],
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                // Ribbon actions (changes by selected tab) - stays fixed at top
                SizedBox(
                  height: 70,
                  child: Consumer<HomeStateProvider>(
                    builder: (context, homeState, child) {
                      return _buildRibbonContent(homeState.selectedTab);
                    }
                  ),
                ),

                // Main content area - mapping space with connection panel
                Expanded(
                  child: Consumer<HomeStateProvider>(
                    builder: (context, homeState, child) {
                      return Row(
                        children: [
                          // Connection panel (shown/hidden based on state)
                          homeState.showConnectionPanel
                              ? Container(
                                  width: 250, // Adjust width as needed
                                  child: Consumer<ThemeProvider>(
                                    builder: (context, themeProvider, child) {
                                      return Container(
                                        color: themeProvider.isDarkMode 
                                            ? Colors.blueGrey[900] 
                                            : Colors.blueGrey[100],
                                        child: const Center(
                                          child: Text(
                                            "Connection Panel Content",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      );
                                    }
                                  ),
                                )
                              : const SizedBox.shrink(),
                          // Mapping area - gets pushed to the right when panel is shown
                          Expanded(
                            child: Consumer<ThemeProvider>(
                              builder: (context, themeProvider, child) {
                                return Container(
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
                                );
                              }
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  // Build ribbon content based on tab
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
        return _buildRibbonGroup( [
          _buildRibbonButton(Icons.zoom_in, "Zoom In"),
          _buildRibbonButton(Icons.zoom_out, "Zoom Out"),
          _buildRibbonButton(Icons.fullscreen, "Full Screen"),
        ]);
      default:
        return const SizedBox();
    }
  }

  // Ribbon group container
  Widget _buildRibbonGroup(List<Widget> buttons) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Container(
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode 
                  ? Colors.grey[800] 
                  : Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: buttons,
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  // Ribbon button
  Widget _buildRibbonButton(IconData icon, String label) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return InkWell(
          onTap: () {
            debugPrint("$label action executed in Mapping/Localization!");
            // TODO: connect action with map/localization logic
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon, 
                  size: 28.0,
                  color: themeProvider.isDarkMode 
                      ? Colors.white 
                      : Colors.black,
                ),
                Text(
                  label, 
                  style: TextStyle(
                    fontSize: 10,
                    color: themeProvider.isDarkMode 
                        ? Colors.white 
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}