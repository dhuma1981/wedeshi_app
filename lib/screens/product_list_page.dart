import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:share/share.dart';
import 'package:wedeshi/home_page.dart';
import 'package:wedeshi/models/product_model.dart';
import 'package:wedeshi/screens/product_detail_page.dart';
import 'package:wedeshi/screens/search_page.dart';
import 'package:wedeshi/utils/api_provider.dart';
import 'package:wedeshi/utils/constants.dart';
import 'package:connectivity/connectivity.dart';

class ProductListPage extends StatefulWidget {
  final int selectedSubCategoryId;
  final int selectedSubSubCategoryId;

  ProductListPage({this.selectedSubCategoryId, this.selectedSubSubCategoryId});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  bool isLoading = false;
  bool fromSubSub = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ReactionDisposer _disposer;

  List<Product> desiProductList = [], weDeshiProductList = [];

  @override
  void initState() {
    super.initState();
    initReaction();
    if (widget.selectedSubSubCategoryId != null) fromSubSub = true;
    fetchProducts();
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
        subcategoryId: widget.selectedSubCategoryId,
        subsubCategoryId: widget.selectedSubSubCategoryId);
    desiProductList = data
        .where((e) =>
            e.brandId == 5 &&
            (fromSubSub
                ? e.sscId == widget.selectedSubSubCategoryId
                : e.subCatId == widget.selectedSubCategoryId))
        .toList();
    weDeshiProductList = data
        .where((e) =>
            e.brandId == 6 &&
            (fromSubSub
                ? e.sscId == widget.selectedSubSubCategoryId
                : e.subCatId == widget.selectedSubCategoryId))
        .toList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: false,
          title: Image.network(
            "https://wedeshi.in/uploads/app/logo.png",
            width: 80,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share(
                      "विदेशी नहीं वी-देशी  (स्वदेशी अपनाओ)\n\nबहोत हो गया बहार की चीजोको खरीदके, दूसरे देशको मुनाफा देना। अब सही समय है की हम सब एक होकर देश के प्रोडक्टस यानी की लोकल चीजों को खरीदे देश के प्रोडक्टस को अधिक महत्व देने का आग्रह रखे। इस एप के जरिए आप आसानीसे जान सकते है की कौन सा \"स्वदेशी\" प्रोडक्ट है और कौन सा \"विदेशी\" प्रोडक्ट। इतना ही नहीं, ये एप आपको कोई भी \"विदेशी\" प्रोडक्ट की जगह कौन सी \"स्वदेशी\" प्रोडक्ट खरीदनी चाहिए वो जानकारी भी देगा। कृपया इस ऐप को डाउनलोड करें।\n\nये एप्लीकेशन सभी देश वासियो तक पाहोचाए !\n\nhttps://play.google.com/store/apps/details?id=in.bi.wedeshi");
                }),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SearchPage()));
                }),

            //IconButton(icon: Icon(Icons.notifications_none), onPressed: () {})
          ],
          bottom: TabBar(
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              indicatorWeight: 8,
              tabs: [
                Tab(
                  text: Platform.isIOS
                      ? Constants.SWADESHI_English
                      : Constants.SWADESHI,
                ),
                Tab(
                    text: Platform.isIOS
                        ? Constants.WEDESHI_English
                        : Constants.WEDESHI),
              ]),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [getDeshiProductList(), getWeDeshiProductList()]),
      ),
    );
  }

  Widget getDeshiProductList() {
    return desiProductList.length > 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                itemCount: desiProductList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (_, index) {
                  Product product = desiProductList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ProductDetailPage(
                                productId: product.productId,
                                localProducts: desiProductList,
                              )));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CachedNetworkImage(
                                  imageUrl: product.imagePath,
                                  errorWidget: (context, url, error) => Icon(
                                        Icons.not_interested,
                                        size: 80,
                                      )),
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
                }))
        : Center(
            child: Text(
                "No ${Platform.isIOS ? Constants.SWADESHI_English : Constants.SWADESHI} products found!"),
          );
  }

  Widget getWeDeshiProductList() {
    return weDeshiProductList.length > 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                itemCount: weDeshiProductList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (_, index) {
                  Product product = weDeshiProductList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ProductDetailPage(
                                productId: product.productId,
                                localProducts: desiProductList,
                              )));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CachedNetworkImage(
                                imageUrl: product.imagePath,
                                errorWidget: (context, url, error) => Icon(
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
                              product.productName,
                              textAlign: TextAlign.center,
                            )),
                          ],
                        ),
                      ),
                    ),
                  );
                }))
        : Center(
            child: Text("No  ${Constants.WEDESHI} products found!"),
          );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }
}
