import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:your_closet/model/roupas.dart';
import 'package:your_closet/repositories/favoritasRepository.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RoupasCard extends StatefulWidget{
  Roupas roupa;
  RoupasCard ({Key?key, required this.roupa}):super(key:key);

  @override
  _RoupasCardState createState() => _RoupasCardState();
}

class _RoupasCardState extends State<RoupasCard> {
  int usadas = 0;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  static Map<String,Color> preColor = <String,Color>{
    'up': Colors.teal,
    'down': Colors.indigo,
  };


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 12),
      elevation: 2,
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.only(top:20,bottom: 20,left:20),
          child: Row(
            children: [
              Image.asset(widget.roupa.icone,height: 40,),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.roupa.nome,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.roupa.id,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ), 
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                decoration: BoxDecoration(
                  color: preColor['down']!.withOpacity(0.05),
                  border: Border.all(
                    color: preColor['down']!.withOpacity(0.04),
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: InkWell(
                  onTap: () {
                    // Incrementa o contador toda vez que o InkWell for pressionado
                    setState(() {
                      usadas++;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10,left: 10), // Define a margem para todos os lados
                    child: Text(
                    'Usar   $usadas',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),),
                ),
              ),
              PopupMenuButton(icon: Icon(Icons.more_vert),
                itemBuilder: (context)=>[
                  PopupMenuItem(child: ListTile(
                    title: Text('Remover das Favoritas'),
                    onTap: () {
                      Navigator.pop(context);
                      Provider.of<FavoritasRepository>(context,listen: false).remove(widget.roupa);
                    },
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}