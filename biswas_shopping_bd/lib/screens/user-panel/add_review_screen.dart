
import 'package:biswas_shopping_bd/models/order-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddReviewScreen extends StatefulWidget{
  final OrderModel orderModel;
  const AddReviewScreen({super.key, required this.orderModel});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();

}

class _AddReviewScreenState  extends State<AddReviewScreen>{
  TextEditingController feedbackController = TextEditingController();
  double productRating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Add Reviews"),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Rate Your Experience && Review"),
            SizedBox(height: 20.0,),

            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              tapOnlyMode: true,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
                productRating = rating;
                setState(() {
                });
              },
            ),
            SizedBox(height: 20.0,),
            Text("Feedback",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(height: 20.0,),
            TextFormField(
              controller: feedbackController,
              decoration: InputDecoration(
                label: Text("Share your Feedback",style: TextStyle(color: Colors.black,),),
              ) ,
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){}, child: Text("Cancel",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                ElevatedButton(onPressed: (){
                  String feedback = feedbackController.text.trim();
                  print(feedback);
                }, child: Text("Submit",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
              ],
            ),

          ],

        ),
      ),
    );
  }
}