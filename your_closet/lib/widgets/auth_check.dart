import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_closet/services/auth_service.dart';

import 'package:your_closet/views/login_page.dart';
import 'package:your_closet/views/home_page.dart';

class AuthCheck extends StatefulWidget{
// ignore: must_be_immutable
  AuthCheck ({Key?key}):super(key:key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {

    @override
    Widget build(BuildContext context){
      AuthService auth = Provider.of<AuthService>(context);

      if (auth.isLoading) return loading();
      else if (auth.usuario == null) return LoginPage();
      else return HomePage();
    }
    loading(){
      // ignore: prefer_const_constructors
      return Scaffold(
        body: const Center(
          child: CircularProgressIndicator(),
        )
      );
    }
}