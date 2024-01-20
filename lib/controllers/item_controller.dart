import 'package:amplify_core/amplify_core.dart';
import 'package:get/get.dart';
import 'package:grorange/models/Item.dart';

class ItemController extends GetxController {
  Item? _item;
  List<Item> _items = List.empty(growable: true);
  List<Item> _filteredItems = List.empty(growable: true);

  Item get item => _item!;

  set item(Item? value) {
    _item = value!;
  }

  set items(List<Item> value) {
    _items = value;
    _filteredItems = _items;
    update();
  }

  List<Item> get items => _items;


  List<Item> get filteredItems => _filteredItems;

  set filteredItems(List<Item> value) {
    _filteredItems = value;
    update();
  }

  void remove(Item item){
    _items = _items
        .where((it) => it.id != item.id)
        .toList(growable: true);
    _filteredItems = items;
    _item = null;
    update();
  }

  void updateItem(Item item){
    final int index = _items.indexOf(item);
    remove(item);
    final List<Item> items = _items;
    items.insert(index, item);
    _items = items;
    _filteredItems = _items;

    safePrint(_items);
  }

  void clear(){
    _items = List.empty(growable: true);
    _item = null;
  }
}