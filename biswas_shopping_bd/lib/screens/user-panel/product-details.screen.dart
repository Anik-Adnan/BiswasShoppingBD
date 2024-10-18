
import 'package:biswas_shopping_bd/models/product-model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app-constant.dart';

class ProductDetailsScreen extends StatefulWidget{
  ProductModel productModel;
  ProductDetailsScreen({super.key,required this.productModel });

  @override
  State<StatefulWidget> createState() => _ProductDetailsScreenState();
  
}
class _ProductDetailsScreenState extends State<ProductDetailsScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Info'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: Get.height/80.0),
              CarouselSlider(
                items: widget.productModel.productImages.map((imgUrls)=>
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: imgUrls,
                        fit: BoxFit.cover,
                        width: Get.width-10.0,
                        placeholder: (context,url)=>
                            ColoredBox(
                              color: Colors.white,
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),),
                        errorWidget: (context,url,error) => Icon(Icons.error),
                      ),
                    ),).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.5,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1,
                  height: 200,
                ),
              ),
        
              Padding(
                padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                child: Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text("CategoryID: ${widget.productModel.categoryId}"),
                            ),
                          ),
                          Icon(Icons.favorite_outline),
                          
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                            child: Text("ProductID: ${widget.productModel.productId}"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text("ProductName: ${widget.productModel.productName}"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text("Category: ${widget.productModel.categoryName}"),
                        ),
                      ),
        
        
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              widget.productModel.isSale == true && widget.productModel.salePrice != ''
                              ? Text("Price: "+ widget.productModel.salePrice+"Tk",style: TextStyle(fontWeight: FontWeight.bold),)
                              : Text("Price: ${widget.productModel.fullPrice} Tk",style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: Container(
                      //     alignment: Alignment.topLeft,
                      //
                      //     child: Row(
                      //       children: [
                      //         Text('Full Price: '),
                      //         Text("${widget.productModel.fullPrice} Tk",style: TextStyle(fontWeight: FontWeight.bold),),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                              "Product Description: ${widget.productModel.productDescription}",
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      child: Container(
                        width: Get.width * 0.35,
                        height: Get.height / 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: AppConstant.WhatsAppColor,
                        ),
                        child: TextButton(
                          child: const Text("Whats App",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          onPressed: () {
                        
                          },
                        ),
                      ),
                    ),
                    Material(
                      child: Container(
                        width: Get.width * 0.35,
                        height: Get.height / 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: AppConstant.appSecondaryColor,
                        ),
                        child: TextButton(
                          child: const Text("Add to cart",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          onPressed: () {
                        
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        
        
        ),
      ),
    );
  }
  
}