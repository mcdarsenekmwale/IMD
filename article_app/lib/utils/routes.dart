import 'package:article_app/pages/account_management/account_page.dart';
import 'package:article_app/pages/account_management/edit_account_page.dart';
import 'package:article_app/pages/article_page.dart';
import 'package:article_app/pages/auth/create_account_page.dart';
import 'package:article_app/pages/auth/login_page.dart';
import 'package:article_app/pages/author_profile_page.dart';
import 'package:article_app/pages/notifications_page.dart';
import 'package:article_app/pages/profile_page.dart';
import 'package:article_app/pages/browse_category_page.dart';
import 'package:article_app/pages/create_new_article_page.dart';
import 'package:article_app/pages/home_page.dart';
import 'package:article_app/pages/search_page.dart';
import 'package:article_app/pages/settings_page.dart';
import 'package:article_app/pages/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => WelcomePage()
        );
        break;
      case '/home':
        return PageTransition(
            child: HomePage(),
            type: PageTransitionType.scale,
            duration: Duration(milliseconds: 800),
            curve: Curves.easeIn,
          settings: settings
        );
        break;
      case "/full-article":
        Map _args = args;
        return PageTransition(
            child: ArticlePage(article: _args['article'], tag: _args['tag'],  ),
            type: PageTransitionType.rightToLeftWithFade,
            curve: Curves.easeIn,
            settings: settings
        );
        break;
      case "/search":
        return PageTransition(
            child: SearchPage(),
            type: PageTransitionType.rightToLeftWithFade,
            curve: Curves.easeIn,
            settings: settings
        );
        break;
      case '/create-newArticle':
        return PageTransition(
            child: CreateNewArticlePage(),
            type: PageTransitionType.scale,
            curve: Curves.easeIn,
            settings: settings
        );
        break;
      case '/browse-category':
        return PageTransition(
            child: BrowseCategoryPage(),
            type: PageTransitionType.rightToLeftWithFade,
            curve: Curves.easeIn,
            settings: settings
        );
        break;
      case '/profile':
        return PageTransition(
            child: ProfilePage(),
            type: PageTransitionType.rightToLeftWithFade,
            curve: Curves.easeIn,
            settings: settings
        );
        break;
      case '/my-account':
        return PageTransition(
            child: AccountPage(),
            type: PageTransitionType.rightToLeftWithFade,
            curve: Curves.easeIn,
            settings: settings
        );
        break;
      case '/edit-profile':
        return PageTransition(
            child: EditAccountPage(),
            type: PageTransitionType.rightToLeftWithFade,
            curve: Curves.easeIn,
            settings: settings
        );
        break;
      case '/settings':
        return PageTransition(
            child: SettingsPage(),
            type: PageTransitionType.rightToLeftWithFade,
            curve: Curves.easeIn,
            settings: settings
        );
        break;
      case '/login':
        return PageTransition(
            child: LoginPage(),
            type: PageTransitionType.rightToLeftWithFade,
            curve: Curves.easeIn,
            settings: settings
        );
        break;
      case '/create-account':
        return PageTransition(
            child: CreateAccountPage(),
            type: PageTransitionType.rightToLeftWithFade,
            curve: Curves.easeIn,
            settings: settings
        );
        break;
      case '/notifications':
        return PageTransition(
            child: NotificationsPage(),
            type: PageTransitionType.rightToLeftWithFade,
            curve: Curves.easeIn,
            settings: settings
        );
        break;
      case '/authors':
        return PageTransition(
            child: AuthorProfilePage(author: args,),
            type: PageTransitionType.rightToLeftWithFade,
            curve: Curves.easeIn,
            settings: settings
        );
        break;
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}