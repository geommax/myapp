import 'package:flutter/foundation.dart';

class RibbonStateProvider with ChangeNotifier {
  // Global State variables
  bool _showRibbon = false;
  int _selectedTab = 0;
  int? _highlightedTab; 
  bool _showConnectionPanel = false;

  // Getters
  int get selectedTab => _selectedTab;
  bool get showRibbon => _showRibbon;
  bool get showConnectionPanel => _showConnectionPanel;
  int? get highlightedTab => _highlightedTab;

    /// Toggle ribbon visibility
  void setSelectedTab(int index) {
    _selectedTab = index;
    _highlightedTab = index;
    _showRibbon = true; 
    notifyListeners();
  }

  void clearHighlight() {
    _highlightedTab = null;
    notifyListeners();
  }
void toggleRibbon() {
    if (_showRibbon) {
      // hide ribbon
      _showRibbon = false;
      _highlightedTab = null; // clear highlight
    } else {
      // show ribbon, highlight first tab if nothing selected
      if (_selectedTab == null) {
        _selectedTab = 0;
      }
      _highlightedTab = _selectedTab;
    }
    notifyListeners();
  }


  /// Toggle connection panel visibility
  void toggleConnectionPanel() {
    _showConnectionPanel = !_showConnectionPanel;
    notifyListeners();
  }

  void setShowConnectionPanel(bool value) {
    _showConnectionPanel = value;
    notifyListeners();
  }
}
