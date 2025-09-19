import 'package:flutter/material.dart';

class HomeStateProvider extends ChangeNotifier {
  int _selectedTab = 0;
  bool _showConnectionPanel = false;

  // Getters
  int get selectedTab => _selectedTab;
  bool get showConnectionPanel => _showConnectionPanel;

  // Methods to update state
  void setSelectedTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void toggleConnectionPanel() {
    _showConnectionPanel = !_showConnectionPanel;
    notifyListeners();
  }

  void setShowConnectionPanel(bool value) {
    _showConnectionPanel = value;
    notifyListeners();
  }
}