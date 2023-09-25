import 'package:flutter/material.dart';
import 'package:your_closet/views/home_page.dart';

class LoginPage extends StatefulWidget{
  LoginPage ({Key?key}):super(key:key);
  


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final fomrKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  late bool isLogin = true;
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
      toggButton = 'Entre como Convidado';
    }else{
      titulo="Cadastrar";
      actionButton = 'Cadastrar';
      toggButton = 'Voltar ao login';
    }
  }

logar(){
  if(fomrKey.currentState!.validate()){
    Navigator.push(context,
      MaterialPageRoute(
        builder: (_) => HomePage(),
      ),
    );
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
                      if (value != 'admin@admin.com'){
                        return 'email incorreto';
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
                      if (value != '123456789'){
                        return 'senha incorreta';
                      }
                      return null;
                    },
                    cursorColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top:20,left: 100,right: 100),
                  child: ElevatedButton(
                    onPressed: ()=>logar(),
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
                ElevatedButton(
                  onPressed: () => setFormAction(!isLogin),
                  child: Text(toggButton),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, // Cor do fundo transparente
                    onPrimary: Colors.black, // Cor do texto preto
                    shadowColor: Colors.transparent,
                  ),
                ),  
              ],
            ),
          ),
        ),
      ),
    );
  }
}