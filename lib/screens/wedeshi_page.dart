import 'package:flutter/material.dart';
import 'package:wedeshi/models/category_model.dart';
import 'package:wedeshi/utils/api_provider.dart';
import 'package:wedeshi/utils/constants.dart';

class WeDeshiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(Constants.CATEGORIES),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder(
                future: ApiProvider.getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (_, index) {
                          Category category = snapshot.data[index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    category.imagePath,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    category.name,
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
        ],
      ),
    );
  }
}
