
import 'package:biswas_shopping_bd/models/car-model.dart';
import 'package:biswas_shopping_bd/models/product-model.dart';
import 'package:biswas_shopping_bd/models/review_model.dart';
import 'package:biswas_shopping_bd/screens/user-panel/cart_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app-constant.dart';

class ProductDetailsScreen extends StatefulWidget{
  ProductModel productModel;
  ProductDetailsScreen({super.key,required this.productModel });

  @override
  State<StatefulWidget> createState() => _ProductDetailsScreenState();
  
}
class _ProductDetailsScreenState extends State<ProductDetailsScreen>{

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Info'),
        actions:  [
          GestureDetector(
            onTap: ()=> Get.to(CartScreen()),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart,color: Colors.black,)),
          ),
        ],
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

                            sendMessageOnWhatsApp(productModel: widget.productModel);
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
                          onPressed: () async {

                            await checkProductExistence(uId: user!.uid);

                            Get.snackbar(
                              "Product added to the cart",
                              "Please! confrim the order.",
                              colorText: Colors.white,
                              duration: Duration(seconds: 1),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // reviews
              FutureBuilder(
                future: FirebaseFirestore.instance.collection('product').doc(widget.productModel.productId).collection('reviews').get(),
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
                      child: Text("No Reviews found!"),
                    );
                  }

                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),

                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];

                        ReviewModel reviewModel = ReviewModel(
                            customerName: data['customerName'],
                            customerPhone: data['customerPhone'],
                            customerDeviceToken: data['customerDeviceToken'],
                            customerId: data['customerId'],
                            feedback: data['feedback'],
                            rating: data['rating'],
                            createdAt: data['createdAt'],
                        );
                        
                        return Card(
                          elevation: 1,
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(reviewModel.customerName[0].toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0),),
                            ),
                            title: Text(reviewModel.customerName,style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(reviewModel.feedback,style: TextStyle(),),
                            trailing: Text(textAlign: TextAlign.justify, reviewModel.rating,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,),),
                          ),
                        );
                      },
                    );
                  }

                  return Container();
                },
              ),




            ],
          ),
        
        
        ),
      ),
    );
  }

  static Future<void> sendMessageOnWhatsApp({required ProductModel productModel}) async{

    final number = "+8801650107332";
    final message = "Hello ${AppConstant.appName}!\nI want to know about this product\nProduct Name: ${productModel.productName}\nProduct ID: ${productModel.productId}";
    final url = 'https://wa.me/$number?text=${Uri.encodeComponent(message)}';

    try {
      Uri requestedUri = Uri.parse(url);// .parse is the correct method

      if (await canLaunchUrl(requestedUri)) {
        await launchUrl(requestedUri);
      } else {
        throw  Exception('Could not launch $url');
      }
    } on PlatformException catch (e) {
      debugPrint("PlatformException launchInBrowser : $e");
    } on Exception catch (e) {
      debugPrint( "Exception launchInBrowser : $e");
    }

    //add androidmenifest.xml
    /*
    <!-- for Url Luncher -->
    <queries>
    <intent>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https" />
    </intent>
    </queries>
     */

  }


  Future<void> checkProductExistence({
    required String uId,
    int quantityIncrement = 1,
  }) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(widget.productModel.productId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(widget.productModel.isSale
          ? widget.productModel.salePrice
          : widget.productModel.fullPrice) *
          updatedQuantity;

      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice
      });

      print("product exists");
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uId).set(
        {
          'uId': uId,
          'createdAt': DateTime.now(),
        },
      );

      CartModel cartModel = CartModel(
        productId: widget.productModel.productId,
        categoryId: widget.productModel.categoryId,
        productName: widget.productModel.productName,
        categoryName: widget.productModel.categoryName,
        salePrice: widget.productModel.salePrice,
        fullPrice: widget.productModel.fullPrice,
        productImages: widget.productModel.productImages,
        deliveryTime: widget.productModel.deliveryTime,
        isSale: widget.productModel.isSale,
        productDescription: widget.productModel.productDescription,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        productQuantity: 1,
        productTotalPrice: double.parse(widget.productModel.isSale
            ? widget.productModel.salePrice
            : widget.productModel.fullPrice),
      );

      await documentReference.set(cartModel.toMap());

      print("product added");
    }
  }
  
}