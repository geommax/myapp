import 'package:flutter/foundation.dart';

class RibbonStateProvider with ChangeNotifier {
  // Global State variables
  bool _showRibbon = false;
  int _selectedTab = 0;


  // Getters
  int get selectedTab => _selectedTab;
  bool get showRibbon => _showRibbon;


    /// Toggle ribbon visibility
  void toggleTab(int index) {
    if (_selectedTab == index) {
      // Same tab clicked again → toggle ribbon
      _showRibbon = !_showRibbon;
    } else {
      // New tab clicked → select and always show ribbon
      _selectedTab = index;
      _showRibbon = true;
    }
    notifyListeners();
  }

  void toggleRibbon() {
    if (_showRibbon) {
      _showRibbon = false;
    } else {
      _showRibbon = true;
    }
    notifyListeners();
  }

}
