import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: themeProvider.isDarkMode 
              ? Colors.grey[900] 
              : Colors.grey[50],
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Reduced from 24.0
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App Icon or Logo
                  Icon(
                    Icons.security,
                    size: 60, // Reduced from 80
                    color: themeProvider.isDarkMode 
                        ? Colors.blueAccent 
                        : Colors.blue,
                  ),
                  const SizedBox(height: 16), // Reduced from 24
                  
                  // App Title
                  Text(
                    'Robo Secure',
                    style: TextStyle(
                      fontSize: 22, // Reduced from 28
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode 
                          ? Colors.white 
                          : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12), // Reduced from 16
                  
                  // App Description
                  Text(
                    'Control Your Robotics',
                    style: TextStyle(
                      fontSize: 14, // Reduced from 16
                      color: themeProvider.isDarkMode 
                          ? Colors.white70 
                          : Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24), // Reduced from 40
                  
                  // Terms and Conditions Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Reduced from 12
                    ),
                    color: themeProvider.isDarkMode 
                        ? Colors.grey[800] 
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Reduced from 20.0
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Terms & Conditions',
                            style: TextStyle(
                              fontSize: 18, // Reduced from 20
                              fontWeight: FontWeight.bold,
                              color: themeProvider.isDarkMode 
                                  ? Colors.white 
                                  : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12), // Reduced from 16
                          const Text(
                            'By using our service, you agree to our terms:\n\n'
                            '• Use only for lawful purposes\n'
                            '• Respect privacy of others\n'
                            '• No malicious activities\n'
                            '• Service provided "as is"\n'
                            '• Subject to applicable laws',
                            style: TextStyle(
                              fontSize: 12, // Reduced from 14
                              height: 1.4, // Reduced from 1.5
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24), // Reduced from 40
                  
                  // Accept Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the main app
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12), // Reduced from 16
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Reduced from 12
                        ),
                        backgroundColor: themeProvider.isDarkMode 
                            ? Colors.blueAccent 
                            : Colors.blue,
                        foregroundColor: themeProvider.isDarkMode 
                            ? Colors.black 
                            : Colors.white,
                        elevation: 4,
                        tapTargetSize: MaterialTapTargetSize.padded,
                        textStyle: const TextStyle(
                          fontSize: 14, // Reduced from 16
                          fontWeight: FontWeight.w600,
                        ),
                        minimumSize: const Size(0, 40), // Reduced from 50
                      ),
                      child: const Text(
                        'Accept & Continue',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12), // Reduced from 16
                  
                  // Decline Button
                  SizedBox(
                    width: 600,
                    child: TextButton(
                      onPressed: () {
                        // Handle decline action (could close app or show more info)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please accept terms to continue'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12), // Reduced from 16
                        tapTargetSize: MaterialTapTargetSize.padded,
                        minimumSize: const Size(0, 40), // Reduced from 50
                      ),
                      child: Text(
                        'Decline',
                        style: TextStyle(
                          fontSize: 14, // Reduced from 16
                          fontWeight: FontWeight.w600,
                          color: themeProvider.isDarkMode 
                              ? Colors.blueAccent 
                              : Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}