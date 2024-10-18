
import 'dart:math';

String generateOrderId(){
  DateTime now = DateTime.now();

  int randomNumbers = Random().nextInt(100000);
  String id = '${now.microsecondsSinceEpoch}_$randomNumbers';
  return id;
}