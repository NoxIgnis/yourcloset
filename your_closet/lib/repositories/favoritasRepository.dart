import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:your_closet/db/db_firestore.dart';
import 'package:your_closet/model/roupas.dart';
import 'package:your_closet/repositories/roupasrepository.dart';
import 'package:your_closet/services/auth_service.dart';
import 'package:flutter/material.dart';

class FavoritasRepository extends ChangeNotifier {
  List<Roupas> _lista = [];
  late FirebaseFirestore db;
  late AuthService auth;

  FavoritasRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readFavoritas();
  }

  _startFirestore() {
    db = DBFirestore.get();    
  }

 _readFavoritas() async {
  try {
    if (auth.usuario != null && _lista.isEmpty) {
      final snapshot = await db.collection('usuarios/${auth.usuario!.uid}/favoritas').get();

      snapshot.docs.forEach((doc) {
        Roupas roupa = roupasRepository.tabela
            .firstWhere((roupa) => roupa.id == doc.get('id'));
        _lista.add(roupa);
        notifyListeners();
      });
    }
  } catch (e) {
    print('Erro ao ler favoritas: $e');
  }
}


  UnmodifiableListView<Roupas> get lista => UnmodifiableListView(_lista);

  saveAll(List<Roupas> roupas) {
    roupas.forEach((roupa) async {
      if (!_lista.any((atual) => atual.id == roupa.id)) {
        _lista.add(roupa);
        await db
            .collection('usuarios/${auth.usuario!.uid}/favoritas')
            .doc(roupa.id)
            .set({
          'moeda': roupa.nome,
          'id': roupa.id,
          'preco': roupa.preco,
        });
      }
    });
    notifyListeners();
  }

  remove(Roupas roupa) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/favoritas')
        .doc(roupa.id)
        .delete();
    _lista.remove(roupa);
    notifyListeners();
  }
}