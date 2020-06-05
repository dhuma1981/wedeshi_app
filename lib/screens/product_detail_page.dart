import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wedeshi/common/custom_appbar.dart';
import 'package:wedeshi/models/product_model.dart';
import 'package:wedeshi/utils/api_provider.dart';
import 'package:wedeshi/utils/constants.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;
  final List<Product> localProducts;

  ProductDetailPage({this.productId, this.localProducts});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<Product> relatedLocalProducts;

  @override
  Widget build(BuildContext context) {
    relatedLocalProducts = widget.localProducts.toList();
    relatedLocalProducts
        .removeWhere((prod) => prod.productId == widget.productId);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Widgets.getCustomAppBar(context, onShare: () {
        print("SHARE PRODUCT");
      }),
      body: FutureBuilder(
          future: ApiProvider.getProduct(productId: widget.productId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Product product = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      product.productName,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    subtitle: Text(product.productDescription),
                  ),
                  Card(
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Container(
                          width: width,
                          child: Center(
                            child: Image.network(
                              product.imagePath,
                              height: height * 0.30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Chip(
                            backgroundColor: Colors.red,
                            label: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                product.brandId == 5
                                    ? Constants.SWADESHI
                                    : Constants.WEDESHI,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  product.productOrigin != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            left: 10.0,
                            right: 10.0,
                          ),
                          child: Center(
                              child: Text(
                                  "Brand Origin: " + product.productOrigin)),
                        )
                      : Container(),
                  Divider(),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Related local products",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  relatedLocalProducts.length > 0
                      ? Expanded(
                          child: GridView.builder(
                              itemCount: relatedLocalProducts.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (_, index) => Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  relatedLocalProducts[index]
                                                      .imagePath,
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                Icons.not_interested,
                                                size: 80,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Expanded(
                                              child: Text(
                                            relatedLocalProducts[index]
                                                .productName,
                                            textAlign: TextAlign.center,
                                          )),
                                        ],
                                      ),
                                    ),
                                  )))
                      : Center(
                          child: Text("No local products found!"),
                        )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
