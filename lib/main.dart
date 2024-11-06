import 'package:flutter/material.dart';
import 'package:news_app/core/favourite_provider.dart';
import 'package:news_app/screen/news_app_screen.dart';
import 'package:provider/provider.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>FavouriteProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NewsAppScreen(),
      ),
    );
  }
}


