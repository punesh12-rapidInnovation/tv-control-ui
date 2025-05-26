import 'package:flutter/material.dart';
import 'package:tv_control_ui/widgets/image/image_thumbnail.dart';
import '../widgets/content_card_row.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final savedItems = [
      {
        'title': 'Saved Item 1',
        'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Saved Item 2',
        'imageUrl': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Saved Item 3',
        'imageUrl': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Saved Item 4',
        'imageUrl': 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=600&q=80',
      },
    ];

    final downloadedItems = [
      {
        'title': 'Downloaded Item 1',
        'imageUrl': 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Downloaded Item 2',
        'imageUrl': 'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Downloaded Item 3',
        'imageUrl': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Downloaded Item 4',
        'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      },
    ];

    final recentlyViewedItems = [
      {
        'title': 'Recently Viewed 1',
        'imageUrl': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Recently Viewed 2',
        'imageUrl': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Recently Viewed 3',
        'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Recently Viewed 4',
        'imageUrl': 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=600&q=80',
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            ContentCardRow(
              title: 'Saved Content',
              handleApiCall: (page) async {
                await Future.delayed(const Duration(milliseconds: 100));
                return Paginated<Map<String, dynamic>>(
                  count: savedItems.length,
                  data: savedItems.cast<Map<String, dynamic>>().toList(),
                );
              },
              cardBuilder: (context, item, width, index) {
                return ImageThumbnail(imageUrl: item['imageUrl']);
              },
            ),
            ContentCardRow(
              title: 'Downloaded Content',
              handleApiCall: (page) async {
                await Future.delayed(const Duration(milliseconds: 100));
                return Paginated<Map<String, dynamic>>(
                  count: downloadedItems.length,
                  data: downloadedItems.cast<Map<String, dynamic>>().toList(),
                );
              },
              cardBuilder: (context, item, width, index) {
                return ImageThumbnail(imageUrl: item['imageUrl'], width: 368, height: 207);
              },
            ),
            ContentCardRow(
              title: 'Recently Viewed',
              handleApiCall: (page) async {
                await Future.delayed(const Duration(milliseconds: 100));
                return Paginated<Map<String, dynamic>>(
                  count: recentlyViewedItems.length,
                  data: recentlyViewedItems.cast<Map<String, dynamic>>().toList(),
                );
              },
              cardBuilder: (context, item, width, index) {
                return ImageThumbnail(imageUrl: item['imageUrl'], width: 368, height: 207);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
} 