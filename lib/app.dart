import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'screens/list_screen.dart';

class App extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  App({super.key});
  void logEvent() async {
    await analytics.logAppOpen();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    logEvent();
    return MaterialApp(
      title: 'Waste Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: const ListScreen(),
    );
  }
}