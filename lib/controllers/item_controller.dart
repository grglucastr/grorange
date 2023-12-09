import 'package:get/get.dart';
import 'package:grorange/models/item.dart';

class ItemController extends GetxController {
  late Item _item;

  Item get item => _item;

  set item(Item value) {
    _item = value;
  }
}