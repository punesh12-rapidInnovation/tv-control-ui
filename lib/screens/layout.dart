import 'package:flutter/material.dart';
import 'package:tv_control_ui/routes/app_routes.dart';
import '../widgets/sidebar.dart';
import '../widgets/top_nav_bar.dart';

class Layout extends StatefulWidget {
  final Widget body;
  
  const Layout({
    super.key,
    required this.body,
  });

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
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
      case AppRoutes.home:
        return 'Home';
      case AppRoutes.library:
        return 'Library';
      case AppRoutes.search:
        return 'Search';
      case AppRoutes.account:
        return 'Account';
      case AppRoutes.following:
        return 'Following';
      case AppRoutes.friends:
        return 'Friends';
      case AppRoutes.login:
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
      backgroundColor: Colors.black, // Overscan area color
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1920),
          child: Column(
            children: [
              TopNavBar(searchFocusNode: _searchFocus),
              Expanded(
                child: Row(
                  children: [
                    Sidebar(
                      selectedMenuItem: _selectedMenuItem,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black, // Content area background
                        child: widget.body,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 