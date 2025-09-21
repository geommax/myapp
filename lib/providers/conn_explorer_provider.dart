import 'package:flutter/foundation.dart';

class ConnExplorerPanelStateProvider with ChangeNotifier {
  // Global State variables
  bool _showExplorerPanel = false;
  bool _robotsExpanded = false;
  bool _lasersExpanded = false;

  bool get showExplorerPanel => _showExplorerPanel;
  bool get robotsExpanded => _robotsExpanded;
  bool get lasersExpanded => _lasersExpanded;

  /// Toggle explorer panel visibility
  void toggleExplorerPanel() {
    _showExplorerPanel = !_showExplorerPanel;
    notifyListeners();
  }

  /// Toggle Robots section
  void toggleRobotsExpanded() {
    _robotsExpanded = !_robotsExpanded;
    notifyListeners();
  }

  /// Toggle Lasers section
  void toggleLasersExpanded() {
    _lasersExpanded = !_lasersExpanded;
    notifyListeners();
  }


}
