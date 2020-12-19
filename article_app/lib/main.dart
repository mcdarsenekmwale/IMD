import 'package:article_app/models/article.dart';
import 'package:article_app/models/category.dart';
import 'package:article_app/providers/articles_provider.dart';
import 'package:article_app/providers/category_provider.dart';
import 'package:article_app/services/authentication.dart';
import 'package:article_app/services/person_collection.dart';
import 'package:article_app/utils/routes.dart';
import 'package:article_app/utils/theme_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/person.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]
  ).then((_) =>
      runApp(new MainApp())
  );
}

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: Authentication().user,
        ),
        StreamProvider<Person>.value(
          value: PersonCollection().person,
          lazy: true,
        ),

        Provider(create: (context) => Article()),
        ChangeNotifierProxyProvider<Article, ArticlesProvider>(
          create: (context) => ArticlesProvider(),
          update: (context, article, provider) {
            provider.article = article;
            return provider;
          },
        ),

        Provider(create: (context) => Category()),
        ChangeNotifierProxyProvider<Category, CategoryProvider>(
          create: (context) => CategoryProvider(),
          update: (context, category, provider) {
            provider.category = category;
            return provider;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Articles ',
        debugShowCheckedModeBanner: false,
        theme: ThemeDetails.themeData,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}