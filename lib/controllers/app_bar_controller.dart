import 'package:get/get.dart';

class AppBarController extends GetxController {
  RxString _title = ''.obs;

  RxString get title => _title;

  set title(RxString value) {
    _title = value;
  }

  String _titleText = '';

  String get titleText => _titleText;

  set titleText(String value) {
    _titleText = value;
    update();
  }
}