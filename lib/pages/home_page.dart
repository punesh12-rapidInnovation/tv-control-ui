import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.home,
            size: 64,
            color: Colors.purple,
          ),
          const SizedBox(height: 16),
          Text(
            'Welcome Home',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your entertainment hub starts here',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Last updated: ${DateTime.now().toString()}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
} 