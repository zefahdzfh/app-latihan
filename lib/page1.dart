

// ignore_for_file: prefer_const_constructors

import 'package:app_latihan/page2.dart';
import 'package:app_latihan/user.dart';
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final data = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman 1"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text('Halo,Selamat Datang Kembali Tuan $data'),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(onPressed: () {
                Navigator.pushNamed(context, '/hal2',arguments:User1('zefa@gmail.com', 'Jln Washington Raya') );
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