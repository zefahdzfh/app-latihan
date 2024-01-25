

// ignore_for_file: prefer_const_constructors

import 'dart:js';

import 'package:app_latihan/page2.dart';
import 'package:app_latihan/page3.dart';
import 'package:app_latihan/user.dart';
import 'package:flutter/material.dart';

class Page2 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final data = ModalRoute.of(context)!.settings.arguments as User1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman 2"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text('Berikut data yang dikirim kantor anda di ${data.kantor}'),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, '/hal3');
              }, child: Text('Next Page')),
            ),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text('Back'))
          ],
        ),
      ),
    );
  }
}