import 'package:flutter/material.dart';
import 'package:your_closet/meuAplicativo.dart';
import 'package:your_closet/repositories/favoritasRepository.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:your_closet/services/auth_service.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


 runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context)=>AuthService()),
        ChangeNotifierProvider(create: (context)=>FavoritasRepository()),
      ],
      child:  const meuAplicativo(),
    ),
  );
}

