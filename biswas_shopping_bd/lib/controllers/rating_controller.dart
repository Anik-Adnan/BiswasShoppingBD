
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CalculateProductRatingCotroller extends GetxController{
  final String productId;

  RxDouble avgRating = 0.0.obs;

  CalculateProductRatingCotroller(this.productId);

  @override
  void onInit() {
    calculateAvgRating();
    super.onInit();
  }

  void calculateAvgRating() async{
    await FirebaseFirestore.instance.collection('product')
        .doc(productId)
        .collection('reviews')
        .snapshots()
        .listen(
        (snapshot) {
          if(snapshot.docs.isNotEmpty){
            double totalrating = 0.0;
            int numberOfReviews = 0;

            snapshot.docs.forEach(
                (doc){
                  final rating = doc['rating'] as double;
                  // final rating = double.tryParse(ratingAsString);

                  if(rating != null){
                     totalrating += rating;
                     numberOfReviews++;
                     print(rating);
                  }
                });
            if(numberOfReviews != 0){
              avgRating.value = totalrating / numberOfReviews;
            }else{
              avgRating.value = 1.0;
            }

          }else{
            avgRating.value = 1.0;
          }
        });
    await FirebaseFirestore.instance.collection('product')
        .doc(productId)
        .update({'avgRating': avgRating});
  }

}