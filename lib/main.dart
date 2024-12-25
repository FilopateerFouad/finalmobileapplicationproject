import 'package:finalproject/matches.dart';
import 'package:finalproject/matches_repo.dart';
import 'package:finalproject/news.dart';
import 'package:finalproject/todaynews.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FootballApp());
}

class FootballApp extends StatelessWidget {
  const FootballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: TodayMatches(todayMatchesRepo: TodayMatchesRepo())
       home: NewsScreen(todayNewsRepo: Todaynews()),
    );
  }
}
