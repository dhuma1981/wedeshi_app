import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:wedeshi/common/custom_appbar.dart';
import 'package:wedeshi/home_page.dart';
import 'package:wedeshi/models/subcategory_model.dart';
import 'package:wedeshi/screens/sub_sub_category_page.dart';
import 'package:wedeshi/utils/api_provider.dart';
import 'package:connectivity/connectivity.dart';

class SubCategoryPage extends StatefulWidget {
  final int selectedCategoryId;

  SubCategoryPage({this.selectedCategoryId});

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    initReaction();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: Widgets.getCustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: ApiProvider.getSubCategories(widget.selectedCategoryId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<SubCategory> data = snapshot.data
                    .where(
                        (item) => item.categoryId == widget.selectedCategoryId)
                    .toList();
                return GridView.builder(
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (_, index) {
                      SubCategory subCategory = data[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => SubSubCategoryPage(
                                    selectedSubCategoryId:
                                        subCategory.subCategoryId,
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
                                      imageUrl: subCategory.imagePath,
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                            Icons.not_interested,
                                            size: 80,
                                          )),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                    child: Text(
                                  subCategory.subCategoryName,
                                  textAlign: TextAlign.center,
                                )),
                              ],
                            ),
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

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }
}
