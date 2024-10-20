
import 'package:biswas_shopping_bd/controllers/product_price_controller.dart';
import 'package:biswas_shopping_bd/models/car-model.dart';
import 'package:biswas_shopping_bd/screens/user-panel/checkout_screen.dart';
import 'package:biswas_shopping_bd/utils/app-constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController = Get.put(ProductPriceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Screen'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid)
            .collection('cartOrders')
            .snapshots(),
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
              child: Text("No products found!"),
            );
          }

          if (snapshot.data != null) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  CartModel cartModel = CartModel(
                    productId: productData['productId'],
                    categoryId: productData['categoryId'],
                    productName: productData['productName'],
                    categoryName: productData['categoryName'],
                    salePrice: productData['salePrice'],
                    fullPrice: productData['fullPrice'],
                    productImages: productData['productImages'],
                    deliveryTime: productData['deliveryTime'],
                    isSale: productData['isSale'],
                    productDescription: productData['productDescription'],
                    createdAt: productData['createdAt'],
                    updatedAt: productData['updatedAt'],
                    productQuantity: productData['productQuantity'],
                    productTotalPrice: double.parse(
                        productData['productTotalPrice'].toString()),
                  );

                  //calculate price
                  productPriceController.fetchProductPrice();
                  return SwipeActionCell(
                    key: ObjectKey(cartModel.productId),
                    trailingActions: [
                      SwipeAction(
                        title: "Delete",
                        forceAlignmentToBoundary: true,
                        performsFirstActionWithFullSwipe: true,
                        onTap: (CompletionHandler handler) async {
                          print('deleted');

                          await FirebaseFirestore.instance
                              .collection('cart')
                              .doc(user!.uid)
                              .collection('cartOrders')
                              .doc(cartModel.productId)
                              .delete();
                        },
                      )
                    ],
                    child: Card(
                      elevation: 5,
                      color: AppConstant.appStatusBarColor,
                      child: ListTile(
                        leading: CircleAvatar(
                          // backgroundColor: AppConstant.appMainColor,
                          child: ClipOval(
                            child: Image.network(
                              cartModel.productImages[0],
                              fit: BoxFit.cover,
                              width: 50.0,
                              height: 50.0,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // Image loaded successfully
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.0,
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error); // Handle image load error
                              },
                            ),
                          ),
                        ),
                        title: Text(cartModel.productName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0)),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${cartModel.productTotalPrice.toString()} Tk"),
                            SizedBox(
                              width: Get.width / 20.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (cartModel.productQuantity > 1) {
                                  await FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(user!.uid)
                                      .collection('cartOrders')
                                      .doc(cartModel.productId)
                                      .update({
                                    'productQuantity':
                                    cartModel.productQuantity - 1,
                                    'productTotalPrice':
                                    (double.parse(cartModel.fullPrice) *
                                        (cartModel.productQuantity - 1))
                                  });
                                }
                              },
                              child: CircleAvatar(
                                radius: 12.0,
                                backgroundColor: AppConstant.appMainColor,
                                child: Text('-',style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 60.0,
                            ),
                            Text("${cartModel.productQuantity.toString()}"),
                            SizedBox(
                              width: Get.width / 60.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (cartModel.productQuantity > 0) {
                                  await FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(user!.uid)
                                      .collection('cartOrders')
                                      .doc(cartModel.productId)
                                      .update({
                                    'productQuantity':
                                    cartModel.productQuantity + 1,
                                    'productTotalPrice':
                                    double.parse(cartModel.fullPrice) +
                                        double.parse(cartModel.fullPrice) *
                                            (cartModel.productQuantity)
                                  });
                                }
                              },
                              child: CircleAvatar(
                                radius: 12.0,
                                backgroundColor: AppConstant.appMainColor,
                                child: Text('+',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return Container();
        },
      ),


      bottomNavigationBar: Container(
        padding: EdgeInsets.all(8.0),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx( ()=> Text("Total: ${productPriceController.totalPrice.value.toStringAsFixed(2)} Tk",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0,),
              child: Material(
                child: Container(
                  width: Get.width / 4.0,
                  height: Get.height / 18,
                  decoration: BoxDecoration(
                    color: AppConstant.appSecondaryColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextButton(
                    child: Text(
                      "CheckOut",
                      style: TextStyle(color: AppConstant.apptextColor,fontWeight: FontWeight.bold,fontSize: 16.0),
                    ),
                    onPressed: () {
                      Get.to(() => CheckOutScreen());
                    },
                  ),
                ),
            ),
            ),
          ],
        ),
      ),
    );
  }

}