import 'package:flutter/material.dart';
import 'package:your_closet/meuAplicativo.dart';
import 'package:your_closet/repositories/favoritasRepository.dart';
import 'package:provider/provider.dart';

void main() {
 runApp(
    ChangeNotifierProvider(
      create: (context)=>FavoritasRepository(),
      child:  const meuAplicativo(),
    ),
  );
}

