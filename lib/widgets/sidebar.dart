import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import 'sidebar_item.dart';

class Sidebar extends StatefulWidget {
  final String selectedMenuItem;

  const Sidebar({
    super.key,
    required this.selectedMenuItem,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final List<FocusNode> _focusNodes;
  String _currentMenuItem = '';
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  final List<Map<String, dynamic>> _items = [
    {
      'title': 'Profile',
      'icon': Icons.person,
      'route': AppRoutes.account,
    },
    {
      'title': 'Home',
      'icon': Icons.home,
      'route': AppRoutes.home,
    },
    {
      'title': 'Search',
      'icon': Icons.search,
      'route': AppRoutes.search,
    },
    {
      'title': 'Library',
      'icon': Icons.library_add,
      'route': AppRoutes.library,
    },
    {
      'title': 'Friends',
      'icon': Icons.people,
      'route': AppRoutes.friends,
    },
    {
      'title': 'Following',
      'icon': Icons.list,
      'route': AppRoutes.following,
    },
    {
      'title': 'Account',
      'icon': Icons.settings,
      'route': AppRoutes.account,
    },
    {
      'title': 'Login',
      'icon': Icons.login,
      'route': AppRoutes.login,
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentMenuItem = widget.selectedMenuItem;
    _focusNodes = List.generate(
      _items.length,
      (_) => FocusNode(),
    );

    _expandController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );

    // Add listeners to all focus nodes
    for (var node in _focusNodes) {
      node.addListener(() {
        if (node.hasFocus && !_isExpanded) {
          _expandSidebar();
        }
      });
    }
  }

  void _expandSidebar() {
    setState(() {
      _isExpanded = true;
    });
    _expandController.forward();
  }

  void _collapseSidebar() {
    setState(() {
      _isExpanded = false;
    });
    _expandController.reverse();
  }

  @override
  void didUpdateWidget(Sidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedMenuItem != _currentMenuItem) {
      setState(() {
        _currentMenuItem = widget.selectedMenuItem;
      });
    }
  }

  @override
  void dispose() {
    _expandController.dispose();
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleItemSelection(Map<String, dynamic> item) {
    if (!mounted || !item.containsKey('route')) return;

    final String targetRoute = item['route'] as String;
    final String itemTitle = item['title'] as String;
    final String currentRoute = ModalRoute.of(context)?.settings.name ?? '/';

    if (_currentMenuItem != itemTitle) {
      setState(() {
        _currentMenuItem = itemTitle;
      });
    }

    // Always pushReplacementNamed, since even if on the same route, we want to rebuild
    if (currentRoute != targetRoute || _currentMenuItem == itemTitle) {
      Navigator.of(context).pushReplacementNamed(targetRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (!_isExpanded) {
          _expandSidebar();
        }
      },
      onExit: (_) {
        if (_isExpanded && !_focusNodes.any((node) => node.hasFocus)) {
          _collapseSidebar();
        }
      },
      child: AnimatedBuilder(
        animation: _expandAnimation,
        builder: (context, child) {
          final width = 60.0 + (140.0 * _expandAnimation.value); // Animate from 60 to 200
          return SizedBox(
            width: width,
            child: FocusTraversalGroup(
              child: Column(
                children: List.generate(_items.length, (index) {
                  final item = _items[index];
                  return SidebarItem(
                    icon: item['icon'] as IconData,
                    label: item['title'] as String,
                    focusNode: _focusNodes[index],
                    onSelect: () => _handleItemSelection(item),
                    isSelected: _currentMenuItem == item['title'],
                    isExpanded: _isExpanded,
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
} 