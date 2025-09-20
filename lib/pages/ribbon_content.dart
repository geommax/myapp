import 'package:flutter/material.dart';

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
  // Example local states for this ribbon
  bool isGridVisible = true;
  double zoomLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    // Switch content depending on selected tab
    switch (widget.selectedTab) {
      case 0:
        return _buildMappingTools();
      case 1:
        return _buildLocalizationTools();
      case 2:
        return _buildControlTools();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildMappingTools() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              isGridVisible = !isGridVisible;
            });
          },
          child: Text(isGridVisible ? "Hide Grid" : "Show Grid"),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            setState(() {
              zoomLevel += 0.1;
            });
          },
          child: const Text("Zoom In"),
        ),
        const SizedBox(width: 12),
        Text("Zoom: ${zoomLevel.toStringAsFixed(1)}x"),
      ],
    );
  }

  Widget _buildLocalizationTools() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            debugPrint("Start Localization");
          },
          child: const Text("Start Localization"),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            debugPrint("Stop Localization");
          },
          child: const Text("Stop Localization"),
        ),
      ],
    );
  }

  Widget _buildControlTools() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            debugPrint("Robot Move Forward");
          },
          child: const Text("Forward"),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            debugPrint("Robot Stop");
          },
          child: const Text("Stop"),
        ),
      ],
    );
  }
}
