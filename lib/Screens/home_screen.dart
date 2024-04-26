import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_screen.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(child: const Text('Tambah Data'),
          onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddListScreen()),
          );
          },
        ),
      ),
    );
  }
}
