import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wedeshi/models/product_model.dart';
import 'package:wedeshi/utils/api_provider.dart';

class ProductListPage extends StatelessWidget {
  final int selectedSubCategoryId;

  ProductListPage({this.selectedSubCategoryId});

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: ApiProvider.getProductList(selectedSubCategoryId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> data = snapshot.data
                    .where((item) => item.subCatId == selectedSubCategoryId)
                    .toList();
                return GridView.builder(
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (_, index) {
                      Product product = data[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: CachedNetworkImage(
                                    imageUrl: product.imagePath),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                  child: Text(
                                product.productName,
                                textAlign: TextAlign.center,
                              )),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
