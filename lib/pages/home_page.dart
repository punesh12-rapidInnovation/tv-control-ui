import 'package:flutter/material.dart';
import 'package:tv_control_ui/widgets/image/image_thumbnail.dart';
import '../widgets/content_card_row.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final trendingItems = [
      {
        'title': 'Popular Show 1',
        'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Popular Show 2',
        'imageUrl': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Popular Show 3',
        'imageUrl': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Popular Show 4',
        'imageUrl': 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Popular Show 5',
        'imageUrl': 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Popular Show 6',
        'imageUrl': 'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Popular Show 7',
        'imageUrl': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Popular Show 8',
        'imageUrl': 'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=600&q=80',
      },
    ];

    final recommendedItems = [
      {
        'title': 'Recommended 1',
        'imageUrl': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Recommended 2',
        'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Recommended 3',
        'imageUrl': 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Recommended 4',
        'imageUrl': 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=600&q=80',
      },
    ];

    final continueWatchingItems = [
      {
        'title': 'Continue 1',
        'imageUrl': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Continue 2',
        'imageUrl': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Continue 3',
        'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'Continue 4',
        'imageUrl': 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=600&q=80',
      },
    ];

    final newReleasesItems = [
      {
        'title': 'New Release 1',
        'imageUrl': 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'New Release 2',
        'imageUrl': 'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'New Release 3',
        'imageUrl': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=600&q=80',
      },
      {
        'title': 'New Release 4',
        'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=600&q=80',
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            ContentCardRow(
              title: 'Trending Now',
              handleApiCall: (page) async {
                await Future.delayed(const Duration(milliseconds: 100));
                return Paginated<Map<String, dynamic>>(
                  count: trendingItems.length,
                  data: trendingItems.cast<Map<String, dynamic>>().toList(),
                );
              },
              cardBuilder: (context, item, width, index) {
                return ImageThumbnail(imageUrl: item['imageUrl']);
              },
            ),
            ContentCardRow(
              title: 'Recommended for You',
              handleApiCall: (page) async {
                // Simulate an API call delay
                await Future.delayed(const Duration(milliseconds: 100));
                // Return a Paginated object as expected by ContentCardRow
                return Paginated<Map<String, dynamic>>(
                  count: recommendedItems.length,
                  data: recommendedItems.cast<Map<String, dynamic>>().toList(),
                );
              },
              cardBuilder: (context, item, width, index) {
                return ImageThumbnail(imageUrl: item['imageUrl'], width: 368, height: 207);
              },
            ),
            ContentCardRow(
              title: 'Continue Watching',
              handleApiCall: (page) async {
                await Future.delayed(const Duration(milliseconds: 100));
                return Paginated<Map<String, dynamic>>(
                  count: recommendedItems.length,
                  data: continueWatchingItems.cast<Map<String, dynamic>>().toList(),
                );
              },
              cardBuilder: (context, item, width, index) {
                return ImageThumbnail(imageUrl: item['imageUrl'], width: 368, height: 207);
              },
            ),
            ContentCardRow(
              title: 'New Releases',
              handleApiCall: (page) async {
                await Future.delayed(const Duration(milliseconds: 100));
                return Paginated<Map<String, dynamic>>(
                  count: newReleasesItems.length,
                  data: newReleasesItems.cast<Map<String, dynamic>>().toList(),
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
class UIConstants {
  // pagination
  static const int defaultPageSize = 10;
  static const int initialPage = 1;

  // Padding
  static const double cardSpacing = 32.0;
  static const double sectionSpacing = 32.0;

  // Cards per view
  static const int defaultCardsPerView = 4;
}
