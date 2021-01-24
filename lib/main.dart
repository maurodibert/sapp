import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/ui/screens/home_screen/home_screen.dart';
import 'package:sapp/ui/screens/home_screen/home_viewmodel.dart';
import 'package:sapp/ui/screens/show_screen/show_screen.dart';
import 'package:sapp/ui/screens/show_screen/show_viewmodel.dart';
import 'package:sapp/service_lcoator.dart';

void main() {
  setupLocator();
  runApp(SeriousApp());
}

class SeriousApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider<ShowViewModel>(
          create: (_) => ShowViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Serious, a series app',
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/show': (context) => ShowScreen(),
        },
      ),
    );
  }
}
