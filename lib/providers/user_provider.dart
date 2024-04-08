import 'package:flutter/widgets.dart';
import 'package:edmax/models/user.dart';
import 'package:edmax/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  OurUser? _user;
  final AuthMethods _authMethods = AuthMethods();

  OurUser get getUser => _user!;

  Future<void> refreshUser() async {
    OurUser user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}