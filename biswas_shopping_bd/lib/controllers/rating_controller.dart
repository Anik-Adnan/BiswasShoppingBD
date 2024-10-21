
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CalculateProductRatingCotroller extends GetxController{
  final String productId;

  RxDouble avgRating = 0.0.obs;

  CalculateProductRatingCotroller(this.productId);

  @override
  void onInit() {
    super.onInit();
    calculateAvgRating();
  }

  void calculateAvgRating(){
    FirebaseFirestore.instance.collection('product')
        .doc(productId)
        .collection('reviews')
        .snapshots()
        .listen(
        (snapshots) {
          if(snapshots.docs.isNotEmpty){
            double totalrating = 0.0;
            int numberOfReviews = 0;

            snapshots.docs.forEach(
                (doc){
                  final ratingAsString = doc['rating'] as String;
                  final rating = double.tryParse(ratingAsString);

                  if(rating != null){
                     totalrating += rating;
                     numberOfReviews++;
                  }
                });
            if(numberOfReviews != 0){
              avgRating.value = totalrating / numberOfReviews;
            }else{
              avgRating.value = 0.0;
            }

          }else{
            avgRating.value = 0.0;
          }
        });
  }
}