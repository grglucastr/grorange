import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:grorange/models/ModelProvider.dart';

class ItemDAO {
  Future<void> save(Item item) async {
    try {
      await Amplify.DataStore.save(item);
    } on DataStoreException catch (e) {
      safePrint('Something went wrong saving item: ${e.message}');
    }
  }

  Future<List<Item>?> findAll(Slot slot) async {
    try {
      return await Amplify.DataStore.query(Item.classType,
          where: Item.SLOT.eq(slot.id));
    } on DataStoreException catch (e) {
      safePrint('Something went wrong querying items: ${e.message}');
    }
    return null;
  }

  Future<void> delete(Item item) async {
    try {
      await Amplify.DataStore.delete(
        item,
        where: Item.ID.eq(item.id),
      );
    } on DataStoreException catch (e) {
      safePrint('Something went wrong when delete item: ${e.message}');
    }
  }

  Future<void> deleteAllUserItems(User user) async {
    try{
      List<Item>? items = await Amplify.DataStore.query(
          Item.classType,
          where: Item.USER.eq(user.id));

      for (var item in items) {
        await Amplify.DataStore.delete(item);
      }

    }on DataStoreException catch (e) {
      safePrint('Something went wrong querying items: ${e.message}');
    }
  }


  Future<void> update(Item item) async {
    try {
      await Amplify.DataStore.save(
        item,
        where: Item.ID.eq(item.id),
      );
    } on DataStoreException catch (e) {
      safePrint('Something went wrong when updating item: ${e.message}');
    }
  }
}
