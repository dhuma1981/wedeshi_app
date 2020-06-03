import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wedeshi/common/custom_appbar.dart';
import 'package:wedeshi/models/subcategory_model.dart';
import 'package:wedeshi/screens/sub_sub_category_page.dart';
import 'package:wedeshi/utils/api_provider.dart';

class SubCategoryPage extends StatelessWidget {
  final int selectedCategoryId;

  SubCategoryPage({this.selectedCategoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.getCustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: ApiProvider.getSubCategories(selectedCategoryId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<SubCategory> data = snapshot.data
                    .where((item) => item.categoryId == selectedCategoryId)
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
                                      imageUrl: subCategory.imagePath),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                    child: Text(
                                  subCategory.description,
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
