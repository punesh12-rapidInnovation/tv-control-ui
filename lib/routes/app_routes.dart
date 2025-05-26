import 'package:flutter/material.dart';
import '../layouts/base_layout.dart';
import '../pages/home_page.dart';
import '../pages/library_page.dart';
import '../pages/login_page.dart';
import '../pages/search_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String gameInterstitial = '/game-interstitial';
  static const String library = '/library';
  static const String friends = '/friends';
  static const String following = '/following';
  static const String account = '/account';
  static const String search = '/search';
  static const String video = '/video';
  static const String playerProfile = '/player-profile';
  static const String publisherProfile = '/publisher-profile';
  static const String login = '/sign-up';

  //-------------------------------- below pages are not confirmed yet --------------------------------

  static const String registration = '/registration';
  static const String game = '/game';
  static const String quest = '/quest';
  static const String questDetails = '/quest-details';
  static const String support = '/support';
  static const String termsAndConditions = '/terms-and-conditions';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget wrap(Widget child, {LayoutType layoutType = LayoutType.standard}) => 
      BaseLayout(layoutType: layoutType, child: child);

    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => wrap( HomePage()),
          settings: settings,
        );
      case library:
        return MaterialPageRoute(
          builder: (_) => wrap( LibraryPage()),
          settings: settings,
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => wrap( LoginPage()),
          settings: settings,
        );
      case search:
        return MaterialPageRoute(
          builder: (_) => wrap( SearchPage()),
          settings: settings,
        );
      case account:
        return MaterialPageRoute(
          builder: (_) => wrap( HomePage()), // Temporary, replace with AccountPage when created
          settings: settings,
        );
      case following:
        return MaterialPageRoute(
          builder: (_) => wrap( HomePage()), // Temporary, replace with FollowingPage when created
          settings: settings,
        );
      case friends:
        return MaterialPageRoute(
          builder: (_) => wrap( HomePage()), // Temporary, replace with FriendsPage when created
          settings: settings,
        );
      case gameInterstitial:
        return MaterialPageRoute(
          builder: (_) => wrap(
             HomePage(), // Replace with GameInterstitialPage when created
            layoutType: LayoutType.fullScreen,
          ),
          settings: settings,
        );
      default:
        return _errorRoute("Route '${settings.name}' not found");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => BaseLayout(
        layoutType: LayoutType.minimal,
        child: Scaffold(
          appBar: AppBar(title: const Text("Error")),
          body: Center(child: Text(message)),
        ),
      ),
    );
  }
} 