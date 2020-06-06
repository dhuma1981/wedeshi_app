import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wedeshi/models/product_model.dart';
import 'package:wedeshi/screens/product_detail_page.dart';
import 'package:wedeshi/utils/api_provider.dart';
import 'package:wedeshi/utils/debouncer.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isloading = false;
  TextEditingController searchController = TextEditingController();
  List<Product> products = [];

  final _debouncer = Debouncer(milliseconds: 500);

  void fetchProducts(String query) async {
    setState(() {
      isloading = true;
    });
    products = await ApiProvider.searchProducts(query);
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Image.network(
          "https://wedeshi.in/uploads/app/logo.png",
          width: 80,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (text) {
                      _debouncer.run(() => fetchProducts(text));
                    },
                    decoration: InputDecoration(hintText: "I am looking for"),
                  ),
                ),
              ],
            ),
          ),
          isloading
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(),
                ))
              : Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          itemCount: products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (_, index) {
                            Product product = products[index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ProductDetailPage(
                                          productId: product.productId,
                                        )));
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: CachedNetworkImage(
                                            imageUrl: product.productImagePath),
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
                              ),
                            );
                          })))
        ],
      ),
    );
  }
}
