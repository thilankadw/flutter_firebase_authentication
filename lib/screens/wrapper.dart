import 'package:firebase_auth_test/models/UserModel.dart';
import 'package:firebase_auth_test/screens/authenticate/authenticate.dart';
import 'package:firebase_auth_test/screens/authenticate/login.dart';
import 'package:firebase_auth_test/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //user data by provider
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
