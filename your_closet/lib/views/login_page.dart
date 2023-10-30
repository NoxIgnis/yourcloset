import 'package:flutter/material.dart';
import 'package:your_closet/views/home_page.dart';
import 'package:your_closet/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget{
  LoginPage ({Key?key}):super(key:key);
  


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final fomrKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  late bool isLogin;
  late String titulo = '';
  late String actionButton = '';
  late String toggButton = '';
  
  var child;

@override
  void initState() {
    setFormAction(true);
    super.initState();
  }

  setFormAction(bool acao){
    isLogin = acao;
    if (isLogin){
      titulo="Bem vindo";
      actionButton = 'login';
      toggButton = 'Cadastrar';
    }else{
      titulo="Cadastrar";
      actionButton = 'Cadastrar';
      toggButton = 'Voltar ao login';
    }
  }
login() async{
   try{
      await context.read<AuthService>().login(email.text,senha.text);
    }on AuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.message)));      
    }
}
cadastrar() async{
  try{
      await context.read<AuthService>().cadastrar(email.text,senha.text);
    }on AuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.message)));      
    }
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding:  EdgeInsets.only(top:120),
          child: Form(
            key: fomrKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 500,
                    child: Image.asset('images/logo.png'),
                  ),
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.5,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top:10,left: 30,right: 30),
                  child: TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if (value!.isEmpty){
                        return 'Informe o Email';
                      }
                      
                      return null;
                    },
                    cursorColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top:20,left: 30,right: 30),
                  child: TextFormField(
                    controller: senha,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Senha',
                    ),
                    validator: (value){
                      if (value!.isEmpty){
                        return 'Informe a Senha';
                      }
                      if (value.length<8){
                        return 'Senha deve ter no mínimo 8 caracteres';
                      }
                     
                      return null;
                    },
                    cursorColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top:20,left: 100,right: 100),
                  child: ElevatedButton(
                    onPressed: (){
                      if (fomrKey.currentState!.validate()){
                        if(isLogin){
                          login();
                        }else{
                          cadastrar();
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check),
                        Padding(padding: EdgeInsets.all(14),
                          child: Text(
                            actionButton,
                            style: TextStyle( fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        setFormAction(!isLogin);
                      });
                    },
                    child: Text(toggButton),
                ),  
              ],
            ),
          ),
        ),
      ),
    );
  }
}