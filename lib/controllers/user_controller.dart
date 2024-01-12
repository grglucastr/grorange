import 'package:get/get.dart';
import 'package:grorange/models/User.dart';

class UserController extends GetxController {
  User? _user;
  String _name = "";
  bool _userSignedIn = false;
  bool _loginInProgress = false;
  bool _logoutInProgress = false;

  User get user => _user ?? User(name: 'none');

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
    User usr = _user ?? User(name: 'none');
    _name = value;
    _user = User(
      id: usr.id,
      name: _name,
      inserted_at: usr.inserted_at,
      updated_at: usr.updated_at,
    );
    update();
  }

  String get firstName {
    if (_name.isEmpty) {
      return "";
    }
    return _name.split(" ")[0];
  }
}
