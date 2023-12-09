import 'package:get/get.dart';

class AppBarController extends GetxController {
  RxString _title = ''.obs;

  RxString get title => _title;

  set title(RxString value) {
    _title = value;
  }
}