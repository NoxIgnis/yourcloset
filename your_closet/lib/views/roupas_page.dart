import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:your_closet/model/roupas.dart';
import 'package:your_closet/repositories/roupasRepository.dart';
import 'package:your_closet/repositories/favoritasRepository.dart';
import 'package:provider/provider.dart';
class RoupasPage extends StatefulWidget{

  RoupasPage ({Key?key}):super(key:key);

  @override
  State<RoupasPage> createState() => _RoupasPageState();
}

class _RoupasPageState extends State<RoupasPage> {
  final tabela = roupasRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Roupas> selecionadas = [];
  late FavoritasRepository favoritas;

appBarDinamica(){
  if(selecionadas.isEmpty){
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Image.asset(
                      'images/logo.png',
                      height: 50,
                    ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              )
        ),
    );
  }else{
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close), 
        onPressed: (){
          setState(() {
            selecionadas = [];
          });
        },
      ),
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
      title: Text('${selecionadas.length} selecionadas'),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              )
      ),
    );
  }
}


limparSelecionadas(){
  selecionadas = [];
}

  @override
  Widget build(BuildContext context) {
    //favoritas = Provider.of<FavoritasRepository>(context);
    favoritas = context.watch<FavoritasRepository>();

    return Scaffold(
      appBar: appBarDinamica(),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Define o número de itens por linha (2 para dois itens por linha)
          crossAxisSpacing: 15.0, // Espaçamento horizontal entre os itens
          mainAxisSpacing: 15.0, // Espaçamento vertical entre os itens
        ),
        itemBuilder: (BuildContext context, int roupa) {
          return InkWell(
            onTap: () {
              setState(() {
                selecionadas.contains(tabela[roupa]) ? selecionadas.remove(tabela[roupa]):selecionadas.add(tabela[roupa]);
              });            },
            child: Container(
            width: 200,
            height: 250,
            decoration: BoxDecoration(
              color: selecionadas.contains(tabela[roupa]) ? const Color.fromARGB(255, 114, 0, 163) : Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow:[ 
                BoxShadow(
                  color: const Color.fromARGB(255, 131, 131, 131).withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: (selecionadas.contains(tabela[roupa]))
            ?  const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 114, 0, 163),
                child: Icon(Icons.check,size:50),
              )
            : Padding(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: Column(
                children: [
                  Image.asset(
                      tabela[roupa].icone,
                      height: 100,
                    ),
                  const Padding(padding: EdgeInsets.only(top:5)),
                  Text(tabela[roupa].nome,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top:10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(real.format(tabela[roupa].preco).toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if(favoritas.lista.contains(tabela[roupa]))
                        const Icon(Icons.star, color: Color.fromARGB(255, 233, 201, 59), size: 15,)
                    ],
                  )
                ],
              ),
            ),
          ),
          );
        },
        padding: const EdgeInsets.all(16),
        //separatorBuilder: (_, ___) => const Divider(),
        itemCount: tabela.length, 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: selecionadas.isNotEmpty 
      ?FloatingActionButton.extended(
        onPressed: (){
          favoritas.saveAll(selecionadas);
          limparSelecionadas();
        }, label: const Icon(
          Icons.favorite,
          color: Color.fromARGB(255, 18, 18, 18),
          size: 30.0,
        ),
        backgroundColor: const Color.fromARGB(255, 114, 0, 163),
      ):null,
    );    
  }
}