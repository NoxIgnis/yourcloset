import 'package:your_closet/model/roupas.dart';

class roupasRepository{
  static List<Roupas> tabela = [
      Roupas(
        icone: 'images/chapeu.jpg',
        nome: 'Chapeu',
        preco: 25,
        sigla: 'PE',
        ),
        Roupas(
        icone: 'images/camisa.jpg',
        nome: 'Camisa',
        preco: 30,
        sigla: 'TK',
        ),
        Roupas(
        icone: 'images/shorts.jpg',
        nome: 'Shorts',
        preco: 80,
        sigla: 'OG',
        ),        
      ];

}