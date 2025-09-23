import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'providers/ribbon_provider.dart';
import 'providers/conn_explorer_provider.dart';
import 'providers/notification_provider.dart';

import 'pages/startup.dart';
import 'pages/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => RibbonStateProvider()),
        ChangeNotifierProvider(create: (context) => ConnExplorerPanelStateProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, 
          title: 'My App',
          theme: themeProvider.currentTheme,
          initialRoute: "/home",
          routes: {
            "/startup": (context) => StartupPage(),
            "/home": (context) => Home(),
          },
        );
      },
    );
  }
}