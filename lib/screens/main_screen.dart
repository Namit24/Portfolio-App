import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/home_screen.dart';
import '../screens/about_screen.dart';
import '../screens/projects_screen.dart';
import '../screens/contact_screen.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;
  final PageController _pageController = PageController();
  bool _isDarkMode = false;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AboutScreen(),
    const ProjectsScreen(),
    const ContactScreen(),
  ];

  final List<String> _titles = [
    "Home",
    "About",
    "Projects",
    "Contact",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
          _pageController.jumpToPage(_currentIndex);
        });
      }
    });
    
    _isDarkMode = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      // Change the theme mode
      final platform = Theme.of(context).platform;
      if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
        // For iOS/macOS
        Future.delayed(Duration.zero, () {
          final newBrightness = _isDarkMode ? Brightness.dark : Brightness.light;
          final systemOverlayStyle = SystemUiOverlayStyle(
            statusBarBrightness: newBrightness,
            statusBarColor: Colors.transparent,
          );
          SystemChrome.setSystemUIOverlayStyle(systemOverlayStyle);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(
                content: Text(_isDarkMode ? 'Dark mode enabled' : 'Light mode enabled'),
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ));
        });
      } else {
        // For Android/other platforms
        Future.delayed(Duration.zero, () {
          final newBrightness = _isDarkMode ? Brightness.dark : Brightness.light;
          final systemOverlayStyle = SystemUiOverlayStyle(
            statusBarIconBrightness: newBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
            statusBarColor: Colors.transparent,
          );
          SystemChrome.setSystemUIOverlayStyle(systemOverlayStyle);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(
                content: Text(_isDarkMode ? 'Dark mode enabled' : 'Light mode enabled'),
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _isDarkMode
          ? SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
            ),
      child: Scaffold(
        appBar: AppBar(
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              _titles[_currentIndex],
              key: ValueKey<String>(_titles[_currentIndex]),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: false,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                _isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: _toggleTheme,
              tooltip: _isDarkMode ? "Light Mode" : "Dark Mode",
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
              _tabController.animateTo(index);
            });
          },
          children: _screens,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
              _tabController.animateTo(index);
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'About',
            ),
            NavigationDestination(
              icon: Icon(Icons.work_outline),
              selectedIcon: Icon(Icons.work),
              label: 'Projects',
            ),
            NavigationDestination(
              icon: Icon(Icons.mail_outline),
              selectedIcon: Icon(Icons.mail),
              label: 'Contact',
            ),
          ],
          animationDuration: const Duration(milliseconds: 500),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
      ),
    );
  }
}

