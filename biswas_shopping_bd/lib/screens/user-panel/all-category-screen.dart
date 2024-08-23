
import 'package:biswas_shopping_bd/screens/user-panel/all-single-category-products-screen.dart';
import 'package:biswas_shopping_bd/utils/app-constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../models/category-model.dart';

class AllCategoryScreen extends StatefulWidget{
  const AllCategoryScreen({super.key});
  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
  
}
class _AllCategoryScreenState extends State<AllCategoryScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prodcuts Categories'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('categoris').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No category found!"),
            );
          }

          if (snapshot.data != null) {
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  CategoriesModel categoriesModel = CategoriesModel(
                    categoryId: snapshot.data!.docs[index]['categoryId'],
                    categoryImg: snapshot.data!.docs[index]['categoryImg'],
                    categoryName: snapshot.data!.docs[index]['categoryName'],
                    createdAt: snapshot.data!.docs[index]['createdAt'],
                    updatedAt: snapshot.data!.docs[index]['updatedAt'],
                  );
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(AllSingleCategoryProductsScreen(categoryId: categoriesModel.categoryId)),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            child: FillImageCard(
                              borderRadius: 20.0,
                              width: Get.width / 3.5,
                              heightImage: Get.height / 8,
                              imageProvider: CachedNetworkImageProvider(
                                categoriesModel.categoryImg,
                              ),
                              title: Center(
                                child: Text(
                                  categoriesModel.categoryName,
                                  style: TextStyle(fontSize: 12.0),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
            );
          }

          return Container();
        },
      ),
    );
  }
  
}