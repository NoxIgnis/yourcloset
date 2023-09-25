import 'package:flutter/material.dart';
import 'package:your_closet/views/roupas_page.dart';

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
          // FavoritasPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: PaginaAtual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas'),
        ],
        onTap: (pagina){
          page_controller.animateToPage(
            pagina, 
            duration: Duration(milliseconds: 250),
            curve: Curves.ease,
          );
        },
        fixedColor: Color.fromARGB(255, 114, 0, 163),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        unselectedItemColor: Color.fromARGB(255, 72, 72, 72),
      ),
    );
  }
}