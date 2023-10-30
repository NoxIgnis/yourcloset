import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class AuthException implements Exception{
  String message;
  AuthException(this.message);
}
class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService(){
    _authCheck();
  }
  _authCheck(){
    _auth.authStateChanges().listen((User?user){
     usuario =(user == null)?null:user;
     isLoading = false;
     notifyListeners(); 
    });
  }
_getUser(){
 usuario = _auth.currentUser;
 notifyListeners();
}
  cadastrar(String email, String senha)async{
    try{
      await _auth.createUserWithEmailAndPassword(email:email,password:senha);
      _getUser();
    }on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        throw AuthException('Senha fraca');
      }if(e.code == 'email-already-in-use'){
        throw AuthException('email já cadastrado');
      }
    }
  }

  login(String email, String senha)async{
    try{
      await _auth.signInWithEmailAndPassword(email:email,password:senha);
      _getUser();
    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found' ||  e.code == 'wrong-password'){
        throw AuthException(e.code);
      }
    }
  }

  logout() async{
    await _auth.signOut();
  }
}