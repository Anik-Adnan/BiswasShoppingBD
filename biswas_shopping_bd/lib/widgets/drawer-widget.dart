
import '/utils/app-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/auth-ui/welcome-screen.dart';

class DrawerWidget extends StatefulWidget{
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();

}
class _DrawerWidgetState extends State<DrawerWidget>{
  @override
  Widget build(BuildContext context) {
    return Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Wrap(
          runSpacing: 10.0,
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 40.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("BiswasShoppingBD",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("version 1.0.1"),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstant.appSecondaryColor,
                  child:  Padding(
                      padding: EdgeInsets.all(8.0),
                    child: Text('B'),
                  ),
                ),

              )
            ),
            const Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0,),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Home",style: TextStyle(fontWeight: FontWeight.bold),),
                  leading: Icon(Icons.home),
                )
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0,),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Products",style: TextStyle(fontWeight: FontWeight.bold),),
                  leading: Icon(Icons.production_quantity_limits),
                )
            ),
           const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0,),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Orders",style: TextStyle(fontWeight: FontWeight.bold),),
                  leading: Icon(Icons.shopping_bag),
                )
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0,),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Contact",style: TextStyle(fontWeight: FontWeight.bold),),
                  leading: Icon(Icons.help_center),
                )
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: const Text("Logout",style: TextStyle(fontWeight: FontWeight.bold),),
                  leading: const Icon(Icons.logout),
                  onTap: () async{
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    FirebaseAuth auth = FirebaseAuth.instance;
                    await auth.signOut();
                    await googleSignIn.signOut();
                    Get.offAll(()=> WelcomeScreen());
                  },
                )
            ),

          ],
        ),
    );
  }

}