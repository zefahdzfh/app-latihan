// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_is_empty, sort_child_properties_last

import 'package:app_latihan/user.dart';
import 'package:flutter/material.dart';

class TableUser extends StatefulWidget {
  const TableUser({Key? key}) : super(key: key);

  @override
  State<TableUser> createState() => _TableUserState();
}

class _TableUserState extends State<TableUser> {
  editData(int index) {
    dataUser[index].email = email.text;
    dataUser[index].password = pw.text;
    Navigator.pushReplacementNamed(context, "/user");
  }

  deleteData(int index) {
    dataUser.removeAt(index);
    Navigator.pushReplacementNamed(context, "/user");
  }

  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();

  showModal(User? data, int? index) {
    if (data != null) {
      email.text = data.email;
      pw.text = data.password;
    } else {
      email.text = "";
      pw.text = "";
    }
    AlertDialog alert = AlertDialog(
      title: Text('Add Data'),
      content: Container(
        height: 150,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: email,
                decoration: InputDecoration(hintText: "example@email.com"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: pw,
                obscureText: true,
                decoration: InputDecoration(hintText: "*********"),
              ),
            )
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => data != null
              ? editData(index!)
              : email.text != "" && pw.text != ""
                  ? saveData()
                  : null,
          child: Text(
            'Save',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        )
      ],
    );
    return showDialog(context: context, builder: (context) => alert);
  }

  saveData() {
    dataUser.add(User(email.text, pw.text));
    Navigator.pushReplacementNamed(context, "/user");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data User'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              dataUser.length != 0
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: DataTable(
                          columns: [
                            DataColumn(label: Text('No')),
                            DataColumn(label: Text('Email')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: List.generate(
                              dataUser.length,
                              (index) => DataRow(cells: [
                                    DataCell(Text((index + 1).toString())),
                                    DataCell(Text(dataUser[index].email)),
                                    DataCell(Row(
                                      children: [
                                        IconButton(
                                            onPressed: () => showModal(
                                                dataUser[index], index),
                                            icon: Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: ()=> deleteData(index),
                                            icon: Icon(Icons.delete)),
                                      ],
                                    ))
                                  ]))),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(child: Text("Data Kosong")),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModal(null, null),
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
