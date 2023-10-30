import 'package:flutter/material.dart';
import 'package:your_closet/repositories/favoritasRepository.dart';
import 'package:provider/provider.dart';
import 'package:your_closet/services/auth_service.dart';


class ConfiguracoesPage extends StatefulWidget{

  ConfiguracoesPage ({Key?key}):super(key:key);

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Configurações',
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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical:10),
        child: OutlinedButton(
          onPressed:()=> context.read<AuthService>().logout(),
          style: OutlinedButton.styleFrom(
            primary: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
          ),
          ), child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(16),
                child: Text('Sair da conta', 
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}