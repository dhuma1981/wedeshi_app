import 'package:flutter/material.dart';
import 'package:wedeshi/models/subcategory_model.dart';
import 'package:wedeshi/utils/api_provider.dart';

class SubCategoryPage extends StatelessWidget {
  final int selectedCategoryId;

  SubCategoryPage({this.selectedCategoryId});

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
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                subCategory.imagePath,
                                height: 120,
                                width: 120,
                                fit: BoxFit.contain,
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
