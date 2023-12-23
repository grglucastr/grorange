import 'package:get/get.dart';
import 'package:grorange/models/user.dart';

class UserController extends GetxController {

  User? _user;
  String _name = "";
  bool _userSignedIn = false;
  bool _loginInProgress = false;
  bool _logoutInProgress = false;

  User get user => _user!;
  set user(User? value) {
    _user = value;
    update();
  }

  bool get userSignedIn => _userSignedIn;

  set userSignedIn(bool value) {
    _userSignedIn = value;
    update();
  }

  bool get loginInProgress => _loginInProgress;

  set loginInProgress(bool value) {
    _loginInProgress = value;
    update();
  }

  bool get logoutInProgress => _logoutInProgress;

  set logoutInProgress(bool value) {
    _logoutInProgress = value;
    update();
  }

  String get name => _name;

  set name(String value) {
    User usr = _user!;
    _name = value;
    _user = User(usr.id, _name, usr.insertDateTime, usr.updateDateTime);
    update();
  }

  String get firstName {
    if(_name.isEmpty){
      return "";
    }
    return _name.split(" ")[0];
  }
}