

// ignore_for_file: prefer_const_constructors

import 'package:app_latihan/main.dart';
import 'package:app_latihan/page2.dart';
import 'package:flutter/material.dart';

class Page3 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman 3"),
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
                Navigator.pop(context);
              }, child: Text('Back')),
            ),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            }, child: Text('Back Home'))
          ],
        ),
      ),
    );
  }
}