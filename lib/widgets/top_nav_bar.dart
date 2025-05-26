import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget {
  final FocusNode searchFocusNode;

  const TopNavBar({
    super.key,
    required this.searchFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.grey[900],
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Logo
          SizedBox(
            width: 120,
            child: Text(
              'TV App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Search Bar
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: FocusableActionDetector(
                  focusNode: searchFocusNode,
                  actions: <Type, Action<Intent>>{
                    DirectionalFocusIntent: CallbackAction<DirectionalFocusIntent>(
                      onInvoke: (intent) {
                        return FocusScope.of(context).focusInDirection(intent.direction);
                      },
                    ),
                  },
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Empty space to balance the logo
          const SizedBox(width: 120),
        ],
      ),
    );
  }
} 