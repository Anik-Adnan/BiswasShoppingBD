
import 'dart:convert';

import 'package:biswas_shopping_bd/services/get_server_key.dart';
import 'package:http/http.dart' as http;

class SendNotificationService{
  static Future<void> sendNotificationUsingApi({
    required String? token,
    required String? title,
    required String? body,
    required Map<String,dynamic>? data,
  }) async{
    String serverKey = await GetServerKey().getServerKeyToken();
    String url = "https://fcm.googleapis.com/v1/projects/biswasshoppingbd-5c83b/messages:send";

    print("server key : ${serverKey}");
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };

    Map<String,dynamic> message = {
      "message":{
        "token":token,
        "notification":{
          "body": body,
          "title": title,
        },
        "data": data,
      }
    };

    // hit api
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(message),
    );

    if(response.statusCode == 200){
      print("Notification Send Successfully!");
    }else{
      print("Failed to send notification. Status: ${response.statusCode}");
      print("Response body: ${response.body}");
    }

  }
}