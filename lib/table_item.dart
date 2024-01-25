// ignore_for_file: sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Item {
  String namaItem;
  int hargaItem;
  bool status;

  Item(this.namaItem, this.hargaItem, this.status);
}

List<Item> dataItem = [
  Item("LG Smart TV", 100, true),
  Item("Samsung S22 Ultra", 50, false),
  Item("Room Door", 20, false),
  Item("Main Gate", 500, false),
  Item("Ipad Air 3", 150, true),
  Item("Asus ROG Zephyrus", 300, true),
];

class TableItem extends StatefulWidget {
  const TableItem({Key? key}) : super(key: key);

  @override
  State<TableItem> createState() => _TableItemState();
}

class _TableItemState extends State<TableItem> {
  TextEditingController nama = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController status = TextEditingController();

  late List<Item> displayedItems;
  bool isSortingByPrice = false;
  bool isSortingByStatus = false;

  @override
  void initState() {
    super.initState();
    displayedItems = List.of(dataItem);
  }

  void updateDisplayedItems(String query) {
    setState(() {
      displayedItems = dataItem
          .where((item) =>
              item.namaItem.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void sortDataByPrice() {
    setState(() {
      isSortingByStatus = false;
      isSortingByPrice = !isSortingByPrice;
      displayedItems.sort((a, b) =>
          isSortingByPrice ? b.hargaItem.compareTo(a.hargaItem) : a.hargaItem.compareTo(b.hargaItem));
    });
  }

  void sortDataByStatus() {
    setState(() {
      isSortingByPrice = false;
      isSortingByStatus = !isSortingByStatus;
      displayedItems.sort((a, b) =>
          isSortingByStatus ? a.status.toString().compareTo(b.status.toString()) : b.status.toString().compareTo(a.status.toString()));
    });
  }

  editData(int index) {
    dataItem[index].namaItem = nama.text;
    dataItem[index].hargaItem = int.tryParse(harga.text) ?? 0;
    dataItem[index].status = status.text.toLowerCase() == "true";
    Navigator.pushReplacementNamed(context, "/item");
  }

  deleteData(int index) {
    dataItem.removeAt(index);
    Navigator.pushReplacementNamed(context, "/item");
  }

  showModal(Item? data, int? index) {
    bool isAktif = data?.status ?? false;

    if (data != null) {
      nama.text = data.namaItem;
      harga.text = data.hargaItem.toString();
      status.text = data.status.toString();
    } else {
      nama.text = "";
      harga.text = "";
      status.text = "";
    }

    AlertDialog alert = AlertDialog(
      title: Text('Add Data'),
      content: Container(
        height: 200,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: nama,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: "Barang apa saja",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                controller: harga,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: "100",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        status.text = 'true';
                        isAktif = true;
                      });
                    },
                    child: Text('Aktif'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: status.text == 'true' ? Colors.green : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        status.text = 'false';
                        isAktif = false;
                      });
                    },
                    child: Text('Non-Aktif'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: status.text == 'false' ? Colors.red : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => data != null
              ? editData(index!)
              : nama.text != "" && harga.text != ""
                  ? saveData(isAktif)
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
    showDialog(context: context, builder: (context) => alert);
  }

  saveData(bool isAktif) {
    dataItem.add(Item(nama.text, int.tryParse(harga.text) ?? 0, isAktif));
    Navigator.pushReplacementNamed(context, "/item");
  }

  String getStatusString(bool status) {
    return status ? 'Aktif' : 'Non-Aktif';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Item'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nama,
                  onChanged: (value) {
                    updateDisplayedItems(value);
                  },
                  decoration:InputDecoration(
                    hintText: 'Search by Name',
                    border: OutlineInputBorder(),
                  ),
                  
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: sortDataByPrice,
                    child: Text(isSortingByPrice ? 'Sort: Harga Terendah' : 'Sort: Harga Tertinggi'),
                  ),
                  ElevatedButton(
                    onPressed: sortDataByStatus,
                    child: Text(isSortingByStatus ? 'Sort: Non-Aktif' : 'Sort: Aktif'),
                  ),
                ],
              ),
              displayedItems.length != 0
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: DataTable(
                        columnSpacing: 2,
                        columns: [
                          DataColumn(label: Text('No')),
                          DataColumn(label: Text('Item'),),
                          DataColumn(label: Text('Harga')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: List.generate(
                          displayedItems.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(Text((index + 1).toString())),
                              DataCell(Text(displayedItems[index].namaItem)),
                              DataCell(Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                    displayedItems[index].hargaItem.toString()),
                              )),
                              DataCell(Text(displayedItems[index].status
                                  ? 'Aktif'
                                  : 'Non-Aktif')),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                    onPressed: () => showModal(displayedItems[index], index),
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () => deleteData(index),
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
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
