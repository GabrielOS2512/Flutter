import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdm_sisgera/providers/auth.dart';
import 'package:pdm_sisgera/providers/corporacao.dart';
import '../exceptions/http_exception.dart';
import '../utils/constants.dart';

class User with ChangeNotifier {
  final String id;
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

  User({
    required this.id,
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
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User (
      id: json['id'],
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
    );
  }

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() => {
    'id': id,
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
  };

}

class Users with ChangeNotifier {
  final AuthService _auth = AuthService();
  final String _baseUrl = '${Constants.BASE_API_URL}/usuarios';
  List<User> _bos = [];

  List<User> get items => [..._bos];

  int get boCount {
    return _bos.length;
  }

  Future<void> loadUser() async {
    final response = await http.get(Uri.parse("$_baseUrl.json"));
    Map<String, dynamic> data = json.decode(response.body);

    _bos.clear();
    if (data != null) {
      data.forEach((Id, Data) {
        _bos.add(User(
          id: Id,
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
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> novoUser(User newUser) async {
    dynamic result = await _auth.registrarAuth(newUser.email, newUser.senha);
    String name = newUser.nome;
    final String _url = '${Constants.BASE_API_URL}/corporacoes';
    List<Corporacao> _corps = [];String retorno = '';

    final response1 = await http.get(Uri.parse("$_url.json"));
    Map<String, dynamic> data = json.decode(response1.body);

    _corps.clear();
    if (data != null) {
      data.forEach((Id, Data) {
        if(Data['nome']== newUser.corporacao) {
          retorno = Id;
        }
      });
      notifyListeners();
    }

    final response = await http.post(Uri.parse("$_baseUrl.json"),
      body: json.encode({
        'id': result.toString(),
        'data':newUser.data,
        'telefone':newUser.telefone,
        'nome':newUser.nome,
        'endereco':newUser.endereco,
        'numero':newUser.numero,
        'bairro':newUser.bairro,
        'cidade':newUser.cidade,
        'tiposangue':newUser.tiposangue,
        'cpf':newUser.cpf,
        'corporacao':retorno,
        'email':newUser.email,
        'senha':newUser.senha,
        'foto':newUser.foto,

      }),
    );

    _bos.add(User(
      id: result.toString(),
      data:newUser.data,
      telefone:newUser.telefone,
      nome:newUser.nome,
      endereco:newUser.endereco,
      numero:newUser.numero,
      bairro:newUser.bairro,
      cidade:newUser.cidade,
      tiposangue:newUser.tiposangue,
      cpf:newUser.cpf,
      corporacao:newUser.corporacao,
      email:newUser.email,
      senha:newUser.senha,
      foto:newUser.foto,
    ));
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    if (user == null || user.id == null) {
      return;
    }

    final index = _bos.indexWhere((prod) => prod.id == user.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse("$_baseUrl/${user.id}.json"),
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
      notifyListeners();
    }
  }

  Future<void> deleteUser(String id) async {
    final index = _bos.indexWhere((bo) => bo.id == id);
    if (index >= 0) {
      final ocorrencia = _bos[index];
      _bos.remove(ocorrencia);
      notifyListeners();

      final response = await http.delete(Uri.parse("$_baseUrl/${ocorrencia.id}.json"));

      if (response.statusCode >= 400) {
        _bos.insert(index, ocorrencia);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do usuário.');
      }
    }
  }
}
