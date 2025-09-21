import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/ribbon_provider.dart';
import '../pages/map.dart';
import '../pages/ribbon_content.dart';
import '../pages/conn_explorer_panel.dart';
import '../providers/conn_explorer_provider.dart';

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
        final Color appbarBackground = themeProvider.colors.appbarBackground;
        final Color ribbonbarBackground = themeProvider.colors.ribbonbarBackground;
        final Color iconColor = themeProvider.colors.iconColor;
        final Color tabSelected = themeProvider.colors.tabSelected;
        final Color selectedLabelColor = themeProvider.colors.selectedLabelColor;
        final Color unselectedLabelColor = themeProvider.colors.unselectedLabelColor;

        return DefaultTabController(
          length: tabs.length,
          initialIndex: ribbonState.selectedTab,
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  color: appbarBackground,
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
                          color: iconColor,
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
                          color: iconColor,
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
                  color: ribbonbarBackground,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Consumer<ConnExplorerPanelStateProvider>(
                        builder: (context, explorerState, _) => IconButton(
                          tooltip: "Connections",
                          icon: Icon(Icons.add_link, color: iconColor),
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
                                ? (tabSelected)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: ribbonState.showRibbon
                              ? (selectedLabelColor)
                              : (unselectedLabelColor),
                          unselectedLabelColor: unselectedLabelColor,
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
                          color: iconColor,
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
