import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("We Deshi"),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {})
        ],
      ),
      body: Column(),
    );
  }
}
