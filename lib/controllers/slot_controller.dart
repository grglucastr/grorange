import 'package:get/get.dart';
import 'package:grorange/models/slot.dart';

class SlotController extends GetxController {

  Slot? _slot;

  Slot get slot => _slot!;

  set slot(Slot value) {
    _slot = value;
    update();
  }
}