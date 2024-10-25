
import 'package:biswas_shopping_bd/models/user-model.dart';
import 'package:biswas_shopping_bd/utils/app-constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;


  //for password visibility
  var isPasswordVisible = false.obs;

  Future<UserCredential?> signUpMethod(
      String userName,
      String userEmail,
      String userPhone,
      String userCity,
      String userPassword,
      String userDeviceToken,
      )async{

    try{
      EasyLoading.show(status: "Please wait");
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);

      // send mail verification
      userCredential.user!.sendEmailVerification();
      
      UserModel userModel = UserModel(
          uId: userCredential.user!.uid,
          userName: userName,
          email: userEmail,
          phone: userPhone,
          userImg: '',
          userDeviceToken: userDeviceToken,
          userCity: userCity,
          country: '',
          userAddress: '',
          street: '',
          isAdmin: false,
          isActive: true,
          createdOn: DateTime.now()
      );

      //user data send to the database
      _fireStore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap()
      );

      EasyLoading.dismiss();
      return userCredential;

    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Get.snackbar("Error", "The password provided is too weak.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppConstant.appSecondaryColor,
            colorText: AppConstant.apptextColor);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.snackbar("Error", "The account already exists for that email.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppConstant.appSecondaryColor,
            colorText: AppConstant.apptextColor);
      }
    } catch (e) {
      print(e);
    }
  }

}