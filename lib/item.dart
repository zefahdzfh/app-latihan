class Item {
  String namaItem;
  int hargaItem;
  bool status;

  Item(this.namaItem, this.hargaItem,this.status);
}

List<Item> dataItem = [
  Item("Smart TV",100, true),
  Item("Handphone",50, false),
];