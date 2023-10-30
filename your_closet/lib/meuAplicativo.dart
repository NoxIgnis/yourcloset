import 'package:flutter/material.dart';
import 'package:your_closet/views/login_page.dart';
import 'package:your_closet/widgets/auth_check.dart';

class meuAplicativo extends StatelessWidget{
  const meuAplicativo({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255)),
      home: AuthCheck(),
    );
  }
} 