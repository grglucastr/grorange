import 'package:get/get.dart';
import 'package:grorange/models/slot.dart';

class SlotController extends GetxController {

  Slot? _slot;
  List<Slot> _slots = List.empty(growable: true);

  Slot get slot => _slot!;
  set slot(Slot? value) {
    _slot = value;
    update();
  }

  List<Slot> get slots => _slots;
  set slots(List<Slot> value) {
    _slots = value;
    update();
  }

  void add(Slot slot){
    List<Slot> slots = this.slots;
    slots.add(slot);
    this.slots = slots;
  }

  void delete(Slot slot){
    List<Slot> slots = this.slots.where((s) => s.id != slot.id)
        .toList(growable: true);
    this.slots = slots;
    this.slot = null;
  }

}