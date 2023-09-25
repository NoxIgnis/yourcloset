import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:your_closet/model/roupas.dart';

class FavoritasRepository extends ChangeNotifier{

  List<Roupas> _lista = [];

  UnmodifiableListView<Roupas> get lista => UnmodifiableListView(_lista);

  saveAll(List<Roupas> roupa){
    roupa.forEach((roupa) {
      if(!_lista.contains(roupa)) _lista.add(roupa);
    });
    notifyListeners();
  }
  remove(Roupas roupa){
    _lista.remove(roupa);
    notifyListeners();
  }
}