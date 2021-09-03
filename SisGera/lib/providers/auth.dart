import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../exceptions/http_exception.dart';
import '../utils/constants.dart';
import 'logado.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //criar obj


  //logar
  Future logarAuth(String email,String senha) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: senha
      );
      //print('U:'+userCredential.user!.uid.toString());
      return userCredential.user!.uid.toString();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        //print('Wrong password provided for that user.');
      }
    }
  }

  //registrar
  Future registrarAuth(String email,String senha) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email,
          password: senha
      );
      return userCredential.user!.uid.toString();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
       // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  //Deletar Usuario
  Future deletarAuth() async{
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print('The user must reauthenticate before this operation can be executed.');
      }
    }
  }
  //sair
  Future sairAuth() async{
    await FirebaseAuth.instance.signOut();
  }

  Future alterarSenha(String newPassword) async {
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      print('Erro ao alterar a senha');
    }
  }

}