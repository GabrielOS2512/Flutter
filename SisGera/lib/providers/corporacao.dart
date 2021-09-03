import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../exceptions/http_exception.dart';
import '../utils/constants.dart';

class Corporacao with ChangeNotifier {
  final String id;
  final String nome;
  final String email;
  final String telefone;
  final String endereco;
  final int numero;
  final String bairro;
  final String cidade;
  final String logo;

  Corporacao({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.endereco,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.logo,
  });

  factory Corporacao.fromJson(Map<String, dynamic> json) {
    return Corporacao (
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      telefone: json['telefone'],
      logo: json['logo'],
      cidade: json['cidade'],
      endereco: json['endereco'],
      numero: int.parse(json['numero']),
      bairro: json['bairro'],
    );
  }

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() => {
    'id': id,
    'nome':nome,
    'email':email,
    'telefone':telefone,
    'endereco':endereco,
    'numero':numero,
    'bairro':bairro,
    'cidade':cidade,
    'logo':logo,
  };

}

class Corporacaos with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_API_URL}/corporacoes';
  List<Corporacao> _corps = [];

  List<Corporacao> get items => [..._corps];

  int get corpoCount {
    return _corps.length;
  }

  Future<void> loadCorpo() async {
    final response = await http.get(Uri.parse("$_baseUrl.json"));
    Map<String, dynamic> data = json.decode(response.body);

    _corps.clear();
    if (data != null) {
      data.forEach((Id, Data) {
        _corps.add(Corporacao(
          id: Id,
          email: Data['email'],
          telefone: Data['telefone'],
          nome: Data['nome'],
          endereco: Data['endereco'],
          numero: Data['numero'],
          bairro: Data['bairro'],
          cidade: Data['cidade'],
          logo: Data['logo'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> novaCorpo(Corporacao newCor) async {
    final response = await http.post(
        Uri.parse("$_baseUrl.json"),
      body: json.encode({
        'id': newCor.id,
        'email':newCor.email,
        'telefone':newCor.telefone,
        'nome':newCor.nome,
        'endereco':newCor.endereco,
        'numero':newCor.numero,
        'bairro':newCor.bairro,
        'cidade':newCor.cidade,
        'logo':newCor.logo,

      }),
    );

    _corps.add(Corporacao(
      id: json.decode(response.body)['data'],
      nome:newCor.nome,
      email:newCor.email,
      telefone:newCor.telefone,
      endereco:newCor.endereco,
      numero:newCor.numero,
      bairro:newCor.bairro,
      cidade:newCor.cidade,
      logo:newCor.logo,
    ));
    notifyListeners();
  }

  Future<void> updateCorpo(Corporacao corp) async {
    if (corp == null || corp.id == null) {
      return;
    }

    final index = _corps.indexWhere((prod) => prod.id == corp.id);
    if (index >= 0) {
      await http.patch(
        Uri.parse("$_baseUrl/${corp.id}.json"),
        body: json.encode({
          'id': corp.id,
          'email':corp.email,
          'telefone':corp.telefone,
          'nome':corp.nome,
          'endereco':corp.endereco,
          'numero':corp.numero,
          'bairro':corp.bairro,
          'cidade':corp.cidade,
          'logo':corp.logo,
        }),
      );
      _corps[index] = corp;
      notifyListeners();
    }
  }

  Future<void> deleteCorpo(String id) async {
    final index = _corps.indexWhere((bo) => bo.id == id);
    if (index >= 0) {
      final ocorrencia = _corps[index];
      _corps.remove(ocorrencia);
      notifyListeners();

      final response = await http.delete(Uri.parse("$_baseUrl/${ocorrencia.id}.json"));

      if (response.statusCode >= 400) {
        _corps.insert(index, ocorrencia);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão da corporação.');
      }
    }
  }

}
