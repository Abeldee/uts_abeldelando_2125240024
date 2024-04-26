import 'package:firebase_database/firebase_database.dart';

class ProductService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('Product_list');

  Stream<Map<String, String>> getProductList(){
    return _database.onValue.map((event) {
      final Map<String, String> items = {};
      DataSnapshot snapshot = event.snapshot;
      if(snapshot.value != null){
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          items[key] = value['kode produk'] as String;
          items[key] = value['nama produk'] as String;
        });
      } return items;
    });
  }
  void addProductItem(String itemKode, String itemNama){
    _database.push().set({'kode produk' : itemKode});
    _database.push().set({'nama produk' : itemNama});

  }

  Future<void> removeProductItem(String key) async{
    await _database.child(key).remove();
  }
}