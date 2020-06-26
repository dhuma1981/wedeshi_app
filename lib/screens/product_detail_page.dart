import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:share/share.dart';
import 'package:wedeshi/common/custom_appbar.dart';
import 'package:wedeshi/home_page.dart';
import 'package:wedeshi/models/product_model.dart';
import 'package:wedeshi/utils/api_provider.dart';
import 'package:wedeshi/utils/constants.dart';
import 'package:connectivity/connectivity.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;
  final List<Product> localProducts;
  final int subCategoryId;
  final int subSubCategoryId;

  ProductDetailPage({
    this.productId,
    this.localProducts,
    this.subCategoryId,
    this.subSubCategoryId,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<Product> relatedLocalProducts;
  Product product;
  bool isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    initReaction();
    if (widget.localProducts != null) {
      relatedLocalProducts = widget.localProducts.toList();
      relatedLocalProducts
          .removeWhere((prod) => prod.productId == widget.productId);
    } else {
      fetchProducts();
    }
  }

  void initReaction() {
    _disposer = reaction(
        (_) => store.connectivityStream.value,
        (result) => _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(result == ConnectivityResult.none
                ? 'You\'re offline'
                : 'You\'re online'))),
        delay: 4000);
  }

  void fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    List<Product> data = await ApiProvider.getProductList(
        subcategoryId: widget.subCategoryId ?? "",
        subsubCategoryId: widget.subSubCategoryId ?? "");
    relatedLocalProducts = data.where((e) => e.brandId == 5).toList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: Widgets.getCustomAppBar(context, onShare: () {
        if (product != null)
          Share.share(Constants.getProductShareMessage(product));
      }),
      body: FutureBuilder(
          future: ApiProvider.getProduct(productId: widget.productId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              product = snapshot.data;
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
                              child: CachedNetworkImage(
                            height: height * 0.30,
                            imageUrl: product.imagePath,
                            errorWidget: (context, url, error) => Icon(
                              Icons.not_interested,
                              size: 80,
                            ),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Chip(
                            backgroundColor: product.brandId == 5
                                ? Colors.green
                                : Colors.red,
                            label: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                product.brandId == 5
                                    ? Platform.isIOS
                                        ? Constants.SWADESHI_English
                                        : Constants.SWADESHI
                                    : Platform.isIOS
                                        ? Constants.WEDESHI_English
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
                        Platform.isIOS
                            ? Constants.RELATED_LOCAL_PRODUCTS_English
                            : Constants.RELATED_LOCAL_PRODUCTS,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : relatedLocalProducts.length > 0
                          ? Expanded(
                              child: GridView.builder(
                                  itemCount: relatedLocalProducts.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  itemBuilder: (_, index) => InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      ProductDetailPage(
                                                        productId:
                                                            relatedLocalProducts[
                                                                    index]
                                                                .productId,
                                                        localProducts: widget
                                                            .localProducts,
                                                      )));
                                        },
                                        child: Card(
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
                                                        relatedLocalProducts[
                                                                index]
                                                            .imagePath,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
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
                                        ),
                                      )))
                          : Center(
                              child: Text(Platform.isIOS
                                  ? Constants.NO_PRODUCT_FOUND_English
                                  : Constants.NO_PRODUCT_FOUND),
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

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }
}
