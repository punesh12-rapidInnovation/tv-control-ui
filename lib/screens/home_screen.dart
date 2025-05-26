import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/top_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  final Widget body;
  
  const HomeScreen({
    super.key,
    required this.body,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final FocusNode _searchFocus;
  late final FocusNode _contentFocus;
  String _selectedMenuItem = 'Home';  // Default to Home

  @override
  void initState() {
    super.initState();
    _searchFocus = FocusNode();
    _contentFocus = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      final String currentRoute = route.settings.name ?? '/';
      final newSelectedItem = _getMenuItemFromRoute(currentRoute);
      if (newSelectedItem != _selectedMenuItem) {
        setState(() {
          _selectedMenuItem = newSelectedItem;
        });
      }
    }
  }

  String _getMenuItemFromRoute(String route) {
    switch (route) {
      case '/':
        return 'Home';
      case '/library':
        return 'Library';
      case '/search':
        return 'Search';
      case '/account':
        return 'Account';
      case '/following':
        return 'Following';
      case '/friends':
        return 'Friends';
      case '/sign-up':
        return 'Login';
      default:
        return 'Home';
    }
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _contentFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopNavBar(searchFocusNode: _searchFocus),
          Expanded(
            child: Row(
              children: [
                Sidebar(
                  selectedMenuItem: _selectedMenuItem,
                ),
                Expanded(
                  child: widget.body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 