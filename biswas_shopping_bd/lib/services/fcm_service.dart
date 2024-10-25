
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService{
  static void firebaseInit(){
    FirebaseMessaging.onMessage.listen(
        (RemoteMessage message){
          print('Got a message whilst in the foreground!');
          print('Message data: ${message.data}');

          print(message.notification!.title);
          print(message.notification!.body);

          if (message.notification != null) {
            print('Message also contained a notification: ${message.notification}');
          }
        }
    );
  }
}