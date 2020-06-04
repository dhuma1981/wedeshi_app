import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:wedeshi/models/product_model.dart';
import 'package:wedeshi/screens/search_page.dart';
import 'package:wedeshi/utils/api_provider.dart';
import 'package:wedeshi/utils/constants.dart';

class ProductListPage extends StatefulWidget {
  final int selectedSubCategoryId;
  final int selectedSubSubCategoryId;

  ProductListPage({this.selectedSubCategoryId, this.selectedSubSubCategoryId});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  bool isLoading = false;

  List<Product> desiProductList = [], weDeshiProductList = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    List<Product> data = await ApiProvider.getProductList(
        subcategoryId: widget.selectedSubCategoryId.toString() ?? "",
        subsubCategoryId: widget.selectedSubSubCategoryId.toString());
    desiProductList = data
        .where(
            (e) => e.brandId == 5 && e.sscId == widget.selectedSubSubCategoryId)
        .toList();
    weDeshiProductList = data
        .where(
            (e) => e.brandId == 6 && e.sscId == widget.selectedSubSubCategoryId)
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
        appBar: AppBar(
          centerTitle: false,
          title: Text("We Deshi"),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SearchPage()));
                }),
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share(
                      "विदेशी नहीं वी-देशी  (स्वदेशी अपनाओ)\n\nबहोत हो गया बहार की चीजोको खरीदके, दूसरे देशको मुनाफा देना। अब सही समय है की हम सब एक होकर देश के प्रोडक्टस यानी की लोकल चीजों को खरीदे देश के प्रोडक्टस को अधिक महत्व देने का आग्रह रखे। इस एप के जरिए आप आसानीसे जान सकते है की कौन सा \"स्वदेशी\" प्रोडक्ट है और कौन सा \"विदेशी\" प्रोडक्ट। इतना ही नहीं, ये एप आपको कोई भी \"विदेशी\" प्रोडक्ट की जगह कौन सी \"स्वदेशी\" प्रोडक्ट खरीदनी चाहिए वो जानकारी भी देगा। कृपया इस ऐप को डाउनलोड करें।\n\nये एप्लीकेशन सभी देश वासियो तक पाहोचाए !\n\nhttps://play.google.com/store/apps/details?id=in.bi.wedeshi");
                }),
            IconButton(icon: Icon(Icons.notifications_none), onPressed: () {})
          ],
          bottom: TabBar(tabs: [
            Tab(
              text: Constants.SWADESHI,
            ),
            Tab(text: Constants.WEDESHI),
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
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: desiProductList.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (_, index) {
              Product product = desiProductList[index];
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
                        child: CachedNetworkImage(imageUrl: product.imagePath),
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
            }));
  }

  Widget getWeDeshiProductList() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: weDeshiProductList.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (_, index) {
              Product product = weDeshiProductList[index];
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
                        child: CachedNetworkImage(imageUrl: product.imagePath),
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
            }));
  }
}
