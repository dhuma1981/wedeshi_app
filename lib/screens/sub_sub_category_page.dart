import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wedeshi/common/custom_appbar.dart';
import 'package:wedeshi/models/subsubcategory_model.dart';
import 'package:wedeshi/screens/product_list_page.dart';
import 'package:wedeshi/utils/api_provider.dart';

class SubSubCategoryPage extends StatelessWidget {
  final int selectedSubCategoryId;

  SubSubCategoryPage({this.selectedSubCategoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.getCustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: ApiProvider.getSubSubCategories(selectedSubCategoryId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<SubSubCategory> data = snapshot.data.toList();
                return GridView.builder(
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
                                      imageUrl: subsubCategory.imagePath),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                    child: Text(
                                  subsubCategory.description,
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
}
