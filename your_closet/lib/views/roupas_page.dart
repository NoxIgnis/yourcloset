import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:your_closet/model/roupas.dart';
import 'package:your_closet/repositories/roupasRepository.dart';

class RoupasPage extends StatefulWidget{

  RoupasPage ({Key?key}):super(key:key);

  @override
  State<RoupasPage> createState() => _RoupasPageState();
}

class _RoupasPageState extends State<RoupasPage> {
  final tabela = roupasRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Roupas> selecionadas = [];
  // late FavoritasRepository favoritas;

appBarDinamica(){
  if(selecionadas.isEmpty){
    return AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        title: const Text('NO-One'),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(0),
              )
        ),
    );
  }else{
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), 
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
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )
      ),
    );
  }
}

// mostrarDetalhes(Moeda moeda){
//   Navigator.push(context,
//     MaterialPageRoute(
//       builder: (_) => MoedasDetalhesPage(moeda: moeda),
//     ),
//   );
// }

limparSelecionadas(){
  selecionadas = [];
}

  @override
  Widget build(BuildContext context) {
    //favoritas = Provider.of<FavoritasRepository>(context);
    //favoritas = context.watch<FavoritasRepository>();

    return Scaffold(
      appBar: appBarDinamica(),
      body:GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Define o número de itens por linha (2 para dois itens por linha)
          crossAxisSpacing: 16.0, // Espaçamento horizontal entre os itens
          mainAxisSpacing: 16.0, // Espaçamento vertical entre os itens
        ),
        itemBuilder: (BuildContext context, int roupas) {
          return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListTile(
            leading: (selecionadas.contains(tabela[roupas]) )
              ? const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 18, 18, 18),
                child: Icon(Icons.check),
              )
              :SizedBox(
              width: 10,
              child: Image.asset(tabela[roupas].icone),
            ),
            title: Row(
              children: [
                Text(
                  tabela[roupas].nome, 
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // if (favoritas.lista.contains(tabela[moeda]))
                //   const Icon(Icons.star, color: Color.fromARGB(255, 255, 240, 79),size: 15)
              ],
            ),
            trailing: Row(
              children: [
                Text(
                  real.format(tabela[roupas].preco),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            selected: selecionadas.contains(tabela[roupas]),
            selectedColor: const Color.fromARGB(255, 255, 255, 255),
            selectedTileColor: Color.fromARGB(255, 114, 0, 163),
            onTap: (){
              setState(() {
                selecionadas.contains(tabela[roupas]) ? selecionadas.remove(tabela[roupas]):selecionadas.add(tabela[roupas]);
              });
            },
            onLongPress: () {},
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
          // favoritas.saveAll(selecionadas);
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