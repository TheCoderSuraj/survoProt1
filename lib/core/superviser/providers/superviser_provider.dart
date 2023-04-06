import 'package:flutter/material.dart';
import 'package:survo_protv1/core/server/functions/account/account_api.dart';
import 'package:survo_protv1/core/server/models/account_model.dart';

class SupervisorProvider extends ChangeNotifier {
  List<AccountModel> _users = [];
  List<AccountModel> get users => _users;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void init() {
    _getAllUsersDetails();
  }

  void _getAllUsersDetails() async {
    _isLoading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      notifyListeners();
    });
    _users = await AccountApi.getAllAccount();
    _isLoading = false;
    notifyListeners();
  }

  void addUser(AccountModel ac) {
    _users.add(ac);
    notifyListeners();
  }
}
