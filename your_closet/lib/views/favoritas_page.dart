import 'package:flutter/material.dart';
import 'package:your_closet/repositories/favoritasRepository.dart';
import 'package:provider/provider.dart';
import 'package:your_closet/widgets/roupas_card.dart';


class FavoritasPage extends StatefulWidget{

  FavoritasPage ({Key?key}):super(key:key);

  @override
  State<FavoritasPage> createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Roupas Favoritas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              )
        ),
      ),
      body: Container(
        color: Colors.indigo.withOpacity(0.05),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child:
          Consumer<FavoritasRepository>(
            builder: (context, favoritas, child) {
              return favoritas.lista.isEmpty
              ? const ListTile(
                leading: Icon(Icons.star),
                title: Text('Não há roupas Favoritas'),
              )
              :ListView.builder(itemCount: favoritas.lista.length,
                itemBuilder:(_,index){
                  return RoupasCard(roupa: favoritas.lista[index]);
                }
              );
            },
        ),
      ),
    );
  }
}