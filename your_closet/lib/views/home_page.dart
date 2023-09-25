import 'package:flutter/material.dart';
import 'package:your_closet/views/roupas_page.dart';
import 'package:your_closet/views/favoritas_page.dart';

class HomePage extends StatefulWidget{

  HomePage ({Key?key}):super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int PaginaAtual = 0;
  late PageController page_controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page_controller = PageController(initialPage: PaginaAtual);
  }

  setPaginaAtual(pagina){
    setState(() {
      PaginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: page_controller,
        children: [
          RoupasPage(),
          FavoritasPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: PaginaAtual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas'),
        ],
        onTap: (pagina){
          page_controller.animateToPage(
            pagina, 
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOutCirc,
          );
        },
        fixedColor: Color.fromARGB(255, 114, 0, 163),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Color.fromARGB(200, 162, 162, 162),
      ),
    );
  }
}