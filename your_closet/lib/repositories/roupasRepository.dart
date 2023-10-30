import 'package:your_closet/model/roupas.dart';

class roupasRepository{
  static List<Roupas> tabela = [
      Roupas(
        icone: 'images/chapeu.jpg',
        nome: 'Chapeu',
        preco: 25,
        id: '02PE',
        ),
        Roupas(
        icone: 'images/camisa.jpg',
        nome: 'Camisa',
        preco: 30,
        id: 'TK01',
        ),
        Roupas(
        icone: 'images/shorts.jpg',
        nome: 'Shorts',
        preco: 80,
        id: 'OG01',
        ),        
      ];

void editaRoupa(Roupas roupaEditada){
 tabela.forEach((roupa) {
      if (roupa.id == roupaEditada.id) {
        tabela[tabela.indexOf(roupa)] = roupaEditada;
      }
    });
}
}