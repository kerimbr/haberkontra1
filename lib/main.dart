import 'package:flutter/material.dart';
import 'package:haberkontra1/pages/HomePage.dart';
import 'package:timeago/timeago.dart' as timeago;


void main() {

  timeago.setLocaleMessages('tr', timeago.TrMessages());
  runApp(HaberKontra1());

}



class HaberKontra1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black
      ),
      home: HomePage(),
    );
  }
}
