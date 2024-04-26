import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter/material.dart';
import '../Services/add_service.dart';
import 'home_screen.dart';

class AddListScreen extends StatefulWidget {
  const AddListScreen({super.key});

  @override
  State<AddListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<AddListScreen> {
  final TextEditingController _controller = TextEditingController();
  final ProductService _productService = ProductService();
  final TextEditingController _add = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Produk"),
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Masukkan Kode Barang"),
                  ),),
                ],
              ),
              Row(
                children: [
                  Expanded(child: TextField(
                    controller: _add,
                    decoration: const InputDecoration(
                      hintText: "Masukkan Nama Barang"),
                  ),),
                ],
              ),
            ],
          ),
          ),
          TextButton(onPressed: () {
            _productService.addProductItem(
              _controller.text,
              _add.text,
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => const homescreen()),);
            _controller.clear();
            _add.clear();
          },
          child: Text("Tambah Data"),
          style: ButtonStyle(
            alignment: Alignment.centerRight,
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.zero,
            ),
          ),
          ),
          Expanded(child: StreamBuilder<Map<String, String>>(
            stream: _productService.getProductList(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                Map<String, String> items = snapshot.data!;
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final key = items.keys.elementAt(index);
                      final item = items[key];
                      return ListTile(
                        title: Text(item!),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: (){
                            _productService.removeProductItem(key);
                          },
                        ),
                      );
                    },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        ],
      ),
    );
  }
}
