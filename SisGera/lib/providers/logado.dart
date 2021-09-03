import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../exceptions/http_exception.dart';
import '../utils/constants.dart';

class UserLogado with ChangeNotifier {
  final String uid;
  final String nome;
  final String data;
  final String telefone;
  final String cpf;
  final String tiposangue;
  final String endereco;
  final String bairro;
  final int numero;
  final String cidade;
  final String corporacao;
  final String email;
  final String senha;
  final String foto;

  final int corpo_numero;
  final String corpo_endereco;
  final String corpo_bairro;
  final String corpo_cidade;
  final String corpo_nome;
  final String corpo_email;
  final String corpo_logo;
  final String corpo_telefone;

  UserLogado({
    required this.uid,
    required this.nome,
    required this.data,
    required this.telefone,
    required this.endereco,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.tiposangue,
    required this.corporacao,
    required this.cpf,
    required this.email,
    required this.senha,
    required this.foto,
    required this.corpo_numero,
    required this.corpo_endereco,
    required this.corpo_bairro,
    required this.corpo_cidade,
    required this.corpo_nome,
    required this.corpo_email,
    required this.corpo_logo,
    required this.corpo_telefone,
  });

  factory UserLogado.fromJson(Map<String, dynamic> json) {
    return UserLogado (
      uid: json['uid'],
      nome: json['nome'],
      data: json['data'],
      telefone: json['telefone'],
      cidade: json['cidade'],
      endereco: json['endereco'],
      bairro: json['bairro'],
      numero: int.parse(json['numero']),
      tiposangue: json['tiposangue'],
      cpf: json['cpf'],
      corporacao: json['corporacao'],
      email: json['email'],
      senha: json['senha'],
      foto: json['foto'],
      corpo_nome: json['corpo_nome'],
      corpo_logo: json['corpo_logo'],
      corpo_telefone: json['corpo_telefone'],
      corpo_cidade: json['corpo_cidade'],
      corpo_endereco: json['corpo_endereco'],
      corpo_bairro: json['corpo_bairro'],
      corpo_numero: int.parse(json['corpo_numero']),
      corpo_email: json['corpo_email'],
    );
  }

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() => {
    'uid': uid,
    'nome':nome,
    'data':data,
    'telefone':telefone,
    'endereco':endereco,
    'numero':numero,
    'bairro':bairro,
    'cidade':cidade,
    'tiposangue':tiposangue,
    'cpf':cpf,
    'corporacao':corporacao,
    'email':email,
    'senha':senha,
    'foto':foto,
    'corpo_email':corpo_email,
    'corpo_nome':corpo_nome,
    'corpo_logo':corpo_logo,
    'corpo_telefone':corpo_telefone,
    'corpo_endereco':corpo_endereco,
    'corpo_numero':corpo_numero,
    'corpo_bairro':corpo_bairro,
    'corpo_cidade':corpo_cidade,
  };

}

class UsersLogado with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_API_URL}/usuarios';
  List<UserLogado> _bos = [];
  List<UserLogado> get items => [..._bos];

  Future<void> usuarioLogado() async {
    var currentUser = FirebaseAuth.instance.currentUser!.uid.toString();
    final response = await http.get(Uri.parse("$_baseUrl.json"));
    Map<String, dynamic> data = json.decode(response.body);

    _bos.clear();
    if (data != null) {
      data.forEach((Id, Data) async {
        if(Data['id'].toString() == currentUser) {
          final resposta = await http.get(Uri.parse("${Constants.BASE_API_URL}/corporacoes/${Data['corporacao']}.json"));
          Map<String, dynamic>  dataCorpo = json.decode(resposta.body);
          if (dataCorpo != null) {
            _bos.add(UserLogado(
              uid: Id,
              data: Data['data'],
              telefone: Data['telefone'],
              nome: Data['nome'],
              endereco: Data['endereco'],
              numero: Data['numero'],
              bairro: Data['bairro'],
              cidade: Data['cidade'],
              tiposangue: Data['tiposangue'],
              cpf: Data['cpf'],
              corporacao: Data['corporacao'],
              email: Data['email'],
              senha: Data['senha'],
              foto: Data['foto'],
              corpo_nome: dataCorpo['nome'],
              corpo_logo: dataCorpo['logo'],
              corpo_telefone: dataCorpo['telefone'],
              corpo_cidade: dataCorpo['cidade'],
              corpo_endereco: dataCorpo['endereco'],
              corpo_bairro: dataCorpo['bairro'],
              corpo_numero: dataCorpo['numero'],
              corpo_email: dataCorpo['email'],
            ));
          }
        }
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> usuarioSaiu() async {
    _bos.clear();
  }

  Future<String> getCorpo() async {
    return _bos.first.corporacao.toString();
  }

  Future<void> updateUser1(UserLogado user) async {
    if (user == null || user.uid == null) {
      return;
    }

    final index = _bos.indexWhere((prod) => prod.uid == user.uid);
    if (index >= 0) {
      await http.patch(
        Uri.parse("$_baseUrl/${user.uid}.json"),
        body: json.encode({
          'data':user.data,
          'telefone':user.telefone,
          'nome':user.nome,
          'endereco':user.endereco,
          'numero':user.numero,
          'bairro':user.bairro,
          'cidade':user.cidade,
          'tiposangue':user.tiposangue,
          'cpf':user.cpf,
          'corporacao':user.corporacao,
          'email':user.email,
          'senha':user.senha,
          'foto':user.foto,
        }),
      );
      _bos[index] = user;
      try {
        await FirebaseAuth.instance.currentUser!.updatePassword(user.senha);
      } on FirebaseAuthException catch (e) {
        print('Erro ao alterar a senha');
      }
      try {
        await FirebaseAuth.instance.currentUser!.updateEmail(user.email);
      } on FirebaseAuthException catch (e) {
        print('Erro ao alterar o email');
      }
      notifyListeners();
    }
  }
}
