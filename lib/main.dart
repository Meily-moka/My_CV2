// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, no_leading_underscores_for_local_identifiers, dead_code, unused_label

import 'package:flutter/material.dart';
import 'package:homework_cv_001/aboutme.dart';
import 'package:homework_cv_001/achievements.dart';
import 'package:homework_cv_001/home.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CV Application',
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        // Using the extracted Boba Tea palette
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF533315), // Deep Brown (Boba)
          primary: const Color(0xFF533315),
          secondary: const Color(0xFFF7ACAC), // Strawberry Pink
          surface: const Color(0xFFF6E1BB), // Creamy Tan
        ),
        scaffoldBackgroundColor: const Color(0xFFF6E1BB), // Light Creamy Tan
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF533315),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'CV Application',
        themeMode: _themeMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

enum AppPage { home, achievements, about }

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.themeMode,
    required this.onToggleTheme,
  });

  final String title;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AppPage _currentPage = AppPage.home;

  Future<void> _launchURLBrowser() async {
    final Uri url = Uri.parse('https://github.com/Meily-moka');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = widget.themeMode == ThemeMode.dark;

    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _buildBody(),
      ),
      appBar: AppBar(
        // Boba Tea Palette: #F2D3A0 (Tan), #F6E1BB (Cream), #533315 (Brown), #FFCCCC (Light Pink), #F7ACAC (Pink)
        backgroundColor: isDark ? Colors.grey[900] : const Color(0xFFF2D3A0), // Tan color for AppBar
        elevation: 0,
        leadingWidth: 100,
        leading: Center(
          child: Text(
            "My Blog",
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF533315), // Deep Brown text
            ),
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _navButton(icon: Icons.home, label: 'Home', page: AppPage.home),
            SizedBox(width: 12),
            _navButton(icon: Icons.archive_sharp, label: 'Achievements', page: AppPage.achievements),
            SizedBox(width: 12),
            _navButton(icon: Icons.person, label: 'About me', page: AppPage.about),
          ],
        ),
        actions: [
          InkWell(
            onTap: _launchURLBrowser,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                "GitHub",
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF533315),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: Icon(
              isDark ? Icons.nightlight_round : Icons.wb_sunny,
              color: isDark ? Colors.white : const Color(0xFF533315),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentPage) {
      case AppPage.home: return HomePage();
      case AppPage.achievements: return AchievementsPage();
      case AppPage.about: return aboutmePage(title: 'About Me Page');
    }
  }

  Widget _navButton({required IconData icon, required String label, required AppPage page}) {
    final bool isActive = _currentPage == page;
    final bool isDark = widget.themeMode == ThemeMode.dark;

    return OutlinedButton(
      onPressed: () => setState(() => _currentPage = page),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isActive ? const Color(0xFF533315) : const Color(0xFFF7ACAC), // Brown if active, Pink if not
          width: 2,
        ),
        backgroundColor: isActive ? const Color(0xFFF7ACAC) : Colors.transparent, // Pink background if active
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF533315) : const Color(0xFF533315), // Always Brown for contrast
            size: 18,
          ),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF533315), // Always Brown for contrast
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
