import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:wedeshi/common/custom_appbar.dart';
import 'package:wedeshi/home_page.dart';
import 'package:wedeshi/models/subsubcategory_model.dart';
import 'package:wedeshi/screens/product_list_page.dart';
import 'package:wedeshi/utils/api_provider.dart';
import 'package:connectivity/connectivity.dart';

class SubSubCategoryPage extends StatefulWidget {
  final int selectedSubCategoryId;

  SubSubCategoryPage({this.selectedSubCategoryId});

  @override
  _SubSubCategoryPageState createState() => _SubSubCategoryPageState();
}

class _SubSubCategoryPageState extends State<SubSubCategoryPage> {
  bool isLoading = false;
  List<SubSubCategory> data;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    initReaction();
    fetchSubSubCategory();
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

  fetchSubSubCategory() async {
    setState(() {
      isLoading = true;
    });
    data = await ApiProvider.getSubSubCategories(widget.selectedSubCategoryId);
    if (data.isEmpty) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => ProductListPage(
                selectedSubCategoryId: widget.selectedSubCategoryId,
              )));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: Widgets.getCustomAppBar(context),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (_, index) {
                    SubSubCategory subsubCategory = data[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ProductListPage(
                                  selectedSubSubCategoryId:
                                      subsubCategory.subSubId,
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
                                width: 120,
                                height: 120,
                                child: CachedNetworkImage(
                                    imageUrl: subsubCategory.imagePath,
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
                                subsubCategory.name,
                                textAlign: TextAlign.center,
                              )),
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
    );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }
}
