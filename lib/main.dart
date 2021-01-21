import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapp/main/library/screens/home_screen/home_screen.dart';
import 'package:sapp/main/library/screens/home_screen/home_viewmodel.dart';

void main() {
  runApp(SeriesApp());
}

class SeriesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Series App',
          home: HomeScreen()),
    );
  }
}
