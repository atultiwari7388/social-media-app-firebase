import 'package:flutter/widgets.dart';
import 'package:instagram_clone/Models/user.model.dart';
import 'package:instagram_clone/resources/auth_method.resource.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = (await _authMethods.getUserDetails()) as User;
    _user = user;
    notifyListeners();
  }
}
