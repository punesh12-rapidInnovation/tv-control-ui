import 'package:flutter/material.dart';
import 'package:tv_control_ui/widgets/image/image_thumbnail.dart';
import '../widgets/content_card_row.dart';
import '../widgets/hero_banner.dart';
import '../widgets/focusable_wrapper.dart';
import '../widgets/event_card.dart';

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

    final savedEventsAndOffers = [
      {
        'title': 'Summer Sale',
        'subtitle': 'Up to 50% off on selected items',
        'imageUrl': 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?auto=format&fit=crop&w=600&q=80',
        'endDate': '2024-08-31',
        'discount': '50%',
        'friendsSaved': 6,
      },
      {
        'title': 'Weekend Special',
        'subtitle': 'Buy 1 Get 1 Free',
        'imageUrl': 'https://images.unsplash.com/photo-1607082349566-187342175e2f?auto=format&fit=crop&w=600&q=80',
        'endDate': '2024-07-15',
        'discount': 'B1G1',
        'friendsSaved': 3,
      },
      {
        'title': 'Flash Sale',
        'subtitle': 'Limited time offer',
        'imageUrl': 'https://images.unsplash.com/photo-1607082349566-187342175e2f?auto=format&fit=crop&w=600&q=80',
        'endDate': '2024-07-10',
        'discount': '30%',
        'friendsSaved': 8,
      },
      {
        'title': 'Holiday Special',
        'subtitle': 'Special holiday rates',
        'imageUrl': 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?auto=format&fit=crop&w=600&q=80',
        'endDate': '2024-12-25',
        'discount': '25%',
        'friendsSaved': 4,
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroBanner(
              imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1920&q=80',
              title: 'Featured Content',
              subtitle: 'Watch the latest and greatest content',
              autofocus: true,
              onTap: () {
                // Handle hero banner tap
              },
            ),
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
              title: 'Saved Events and Offers',
              cardsPerView: 2,
              handleApiCall: (page) async {
                await Future.delayed(const Duration(milliseconds: 100));
                return Paginated<Map<String, dynamic>>(
                  count: savedEventsAndOffers.length,
                  data: savedEventsAndOffers.cast<Map<String, dynamic>>().toList(),
                );
              },
              cardBuilder: (context, item, width, index) {
                return EventCard(
                  imageUrl: item['imageUrl'],
                  title: item['title'],
                  subtitle: item['subtitle'],
                  endDate: item['endDate'],
                  discount: item['discount'],
                  friendsSaved: item['friendsSaved'] ?? 0,
                  onSavedTap: () {
                    // Handle saved button tap
                    debugPrint('Saved button tapped');
                  },
                );
              },
            ),
            ContentCardRow(
              title: 'Recommended for You',
              handleApiCall: (page) async {
                await Future.delayed(const Duration(milliseconds: 100));
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
                  count: continueWatchingItems.length,
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
