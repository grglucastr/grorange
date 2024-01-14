import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:grorange/models/ModelProvider.dart';

class SlotDAO {
  Future<void> save(Slot slot) async {
    try {
      await Amplify.DataStore.save(slot);
    } on DataStoreException catch (e) {
      safePrint('Something went wrong saving slot: ${e.message}');
    }
  }

  Future<List<Slot>?> findAll(Workspace workspace) async {
    try {
      return await Amplify.DataStore.query(
        Slot.classType,
        where: Slot.WORKSPACE.eq(workspace.id)
      );
    } on DataStoreException catch (e) {
      safePrint('Something went wrong querying slots: ${e.message}');
    }
    return null;
  }

  Future<void> delete(Slot slot) async {
    try {
      await Amplify.DataStore.delete(
        slot,
        where: Slot.ID.eq(slot.id),
      );
    } on DataStoreException catch (e) {
      safePrint('Something went wrong when delete slot: ${e.message}');
    }
  }

  Future<void> update(Slot slot) async {
    try {
      await Amplify.DataStore.save(
        slot,
        where: Slot.ID.eq(slot.id),
      );
    } on DataStoreException catch (e) {
      safePrint('Something went wrong when updating slot: ${e.message}');
    }
  }
}