// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_latihan/page1.dart';
import 'package:app_latihan/page2.dart';
import 'package:app_latihan/page3.dart';
import 'package:app_latihan/table_user.dart';
import 'package:app_latihan/table_item.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        // '/' :(context) => MyHomePage(),
        '/hal1' :(context) => Page1(),
        '/hal2' :(context) => Page2(),
        '/hal3' :(context) => Page3(),
        '/user' :(context) => TableUser(),
        '/item' :(context) => TableItem(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(onPressed: () {
                Navigator.pushNamed(context,'/hal1',arguments: 'Zefa Hudzaifah');
              }, child: Text('Next Page')),
            ),
            ElevatedButton(onPressed: () {
                Navigator.pushNamed(context,'/user',);
              }, child: Text('Table User')),
            
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(onPressed: () {
                Navigator.pushNamed(context,'/item');
              }, child: Text('Table Item')),
            ),
          ],
        ),
      ),
    );
  }
}
