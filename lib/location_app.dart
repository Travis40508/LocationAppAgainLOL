import 'package:flutter/material.dart';

import 'location_screen.dart';

class LocationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/location_screen',
      routes: {
        '/location_screen': (context) => LocationScreen(),
      },
    );
  }
}
