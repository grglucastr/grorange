import 'package:get/get.dart';
import 'package:grorange/models/user.dart';

class UserController extends GetxController {

  User? _user;
  bool _userSignedIn = false;

  User get user => _user!;
  set user(User value) {
    _user = value;
    update();
  }

  bool get userSignedIn => _userSignedIn;

  set userSignedIn(bool value) {
    _userSignedIn = value;
    update();
  }
}