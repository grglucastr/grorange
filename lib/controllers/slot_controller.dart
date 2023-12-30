import 'package:get/get.dart';
import 'package:grorange/models/slot.dart';

class SlotController extends GetxController {

  Slot? _slot;
  List<Slot> _slots = List.empty(growable: true);

  Slot get slot => _slot!;
  set slot(Slot value) {
    _slot = value;
    update();
  }

  List<Slot> get slots => _slots;
  set slots(List<Slot> value) {
    _slots = value;
    update();
  }
}