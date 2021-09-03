import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../exceptions/http_exception.dart';
import '../utils/constants.dart';

class Oco with ChangeNotifier {
  final String id;
  final String responsavel;
  final String data;
  final String transmissao;
  final String chegada;
  final String saida;
  final String equipe;
  final String ocorrencia;
  final String endereco;
  final int numero;
  final String bairro;
  final String complemento;
  final String cidade;
  final String referencia;
  final String vit_nome;
  final String vit_nascimento;
  final String vit_endereco;
  final int vit_numero;
  final String vit_bairro;
  final String vit_complemento;
  final String vit_cidade;
  final String resumo;
  final String observacoes;

  Oco({
    required this.id,
    required this.responsavel,
    required this.referencia,
    required this.vit_nome,
    required this.vit_nascimento,
    required this.vit_endereco,
    required this.vit_numero,
    required this.vit_bairro,
    required this.vit_complemento,
    required this.vit_cidade,
    required this.resumo,
    required this.observacoes,
    required this.data,
    required this.transmissao,
    required this.chegada,
    required this.saida,
    required this.equipe,
    required this.ocorrencia,
    required this.endereco,
    required this.numero,
    required this.bairro,
    required this.complemento,
    required this.cidade,
  });

  factory Oco.fromJson(Map<String, dynamic> json) {
    return Oco (
      id: json['id'],
      responsavel: json['responsavel'],
      vit_numero: int.parse(json['vit_numero']),
      vit_endereco: json['vit_endereco'],
      transmissao: json['transmissao'],
      vit_cidade: json['vit_cidade'],
      cidade: json['cidade'],
      chegada: json['chegada'],
      complemento: json['complemento'],
      vit_complemento: json['vit_complemento'],
      saida: json['saida'],
      vit_nome: json['vit_nome'],
      referencia: json['referencia'],
      endereco: json['endereco'],
      vit_bairro: json['vit_bairro'],
      observacoes: json['observacoes'],
      data: json['data'],
      equipe: json['equipe'],
      numero: int.parse(json['numero']),
      resumo: json['resumo'],
      ocorrencia: json['ocorrencia'],
      vit_nascimento: json['vit_nascimento'],
      bairro: json['bairro'],
    );
  }

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() => {
    'id': id,'responsavel': responsavel,'data':data, 'transmissao':transmissao, 'chegada':chegada, 'saida':saida, 'equipe':equipe, 'ocorrencia':ocorrencia,
    'endereco':endereco, 'numero':numero, 'bairro':bairro, 'complemento':complemento,'cidade':cidade, 'referencia':referencia,'vit_nome':vit_nome,'vit_nascimento':vit_nascimento,
    'vit_endereco':vit_endereco, 'vit_numero':vit_numero, 'vit_bairro':bairro, 'vit_complemento':vit_complemento,'vit_cidade':cidade,'resumo':resumo,'observacoes':observacoes,

  };

}

class Ocos with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_API_URL}/ocorrencia';
  List<Oco> _bos = [];

  List<Oco> get items => [..._bos];

  int get boCount {
    return _bos.length;
  }

  Future<void> loadBOs() async {
    final response = await http.get(Uri.parse("$_baseUrl.json"));
    Map<String, dynamic> data = json.decode(response.body);

    _bos.clear();
    if (data != null) {
      data.forEach((Id, Data) {
        _bos.add(Oco(
          id: Id,
          responsavel: Data['responsavel'],
          data: Data['data'],
          transmissao: Data['transmissao'],
          chegada: Data['chegada'],
          saida: Data['saida'],
          equipe: Data['equipe'],
          ocorrencia: Data['ocorrencia'],
          endereco: Data['endereco'],
          numero: Data['numero'],
          bairro: Data['bairro'],
          complemento: Data['complemento'],
          cidade: Data['cidade'],
          referencia: Data['referencia'],
          vit_nome: Data['vit_nome'],
          vit_nascimento: Data['vit_nascimento'],
          vit_endereco: Data['vit_endereco'],
          vit_numero: Data['vit_numero'],
          vit_bairro: Data['vit_bairro'],
          vit_complemento: Data['vit_complemento'],
          vit_cidade: Data['vit_cidade'],
          resumo: Data['resumo'],
          observacoes: Data['observacoes'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> novoBO(Oco newBO) async {
    final response = await http.post(
        Uri.parse("$_baseUrl.json"),
      body: json.encode({
        'id': newBO.id,
        'data':newBO.data,
        'responsavel': newBO.responsavel,
        'transmissao':newBO.transmissao,
        'chegada':newBO.chegada,
        'saida':newBO.saida,
        'equipe':newBO.equipe,
        'ocorrencia':newBO.ocorrencia,
        'endereco':newBO.endereco,
        'numero':newBO.numero,
        'bairro':newBO.bairro,
        'complemento':newBO.complemento,
        'cidade':newBO.cidade,
        'referencia':newBO.referencia,
        'vit_nome':newBO.vit_nome,
        'vit_nascimento':newBO.vit_nascimento,
        'vit_endereco':newBO.vit_endereco,
        'vit_numero':newBO.vit_numero,
        'vit_bairro':newBO.bairro,
        'vit_complemento':newBO.complemento,
        'vit_cidade':newBO.cidade,
        'resumo':newBO.resumo,
        'observacoes':newBO.observacoes,

      }),
    );

    _bos.add(Oco(
      id: json.decode(response.body)['data'],
      responsavel:newBO.responsavel,
      data:newBO.data,
      transmissao:newBO.transmissao,
      chegada:newBO.chegada,
      saida:newBO.saida,
      equipe:newBO.equipe,
      ocorrencia:newBO.ocorrencia,
      endereco:newBO.endereco,
      numero:newBO.numero,
      bairro:newBO.bairro,
      complemento:newBO.complemento,
      cidade:newBO.cidade,
      referencia:newBO.referencia,
      vit_nome:newBO.vit_nome,
      vit_nascimento:newBO.vit_nascimento,
      vit_endereco:newBO.vit_endereco,
      vit_numero:newBO.vit_numero,
      vit_bairro:newBO.bairro,
      vit_complemento:newBO.complemento,
      vit_cidade:newBO.cidade,
      resumo:newBO.resumo,
      observacoes:newBO.observacoes,
    ));
    notifyListeners();
  }

  Future<void> updateBO(Oco boletim) async {
    if (boletim == null || boletim.id == null) {
      return;
    }
    print('OCO:'+boletim.id);

    final index = _bos.indexWhere((prod) => prod.id == boletim.id);
    if (index >= 0) {
      await http.patch(
          Uri.parse("$_baseUrl/${boletim.id}.json"),
        body: json.encode({
          'data':boletim.data,
          'transmissao':boletim.transmissao,
          'chegada':boletim.chegada,
          'saida':boletim.saida,
          'equipe':boletim.equipe,
          'ocorrencia':boletim.ocorrencia,
          'endereco':boletim.endereco,
          'numero':boletim.numero,
          'bairro':boletim.bairro,
          'complemento':boletim.complemento,
          'cidade':boletim.cidade,
          'referencia':boletim.referencia,
          'vit_nome':boletim.vit_nome,
          'vit_nascimento':boletim.vit_nascimento,
          'vit_endereco':boletim.vit_endereco,
          'vit_numero':boletim.vit_numero,
          'vit_bairro':boletim.bairro,
          'vit_complemento':boletim.complemento,
          'vit_cidade':boletim.cidade,
          'resumo':boletim.resumo,
          'observacoes':boletim.observacoes,
        }),
      );
      _bos[index] = boletim;
      notifyListeners();
    }
  }

  Future<void> deleteBO(String id) async {
    final index = _bos.indexWhere((bo) => bo.id == id);
    if (index >= 0) {
      final ocorrencia = _bos[index];
      _bos.remove(ocorrencia);
      notifyListeners();

      final response = await http.delete(Uri.parse("$_baseUrl/${ocorrencia.id}.json"));

      if (response.statusCode >= 400) {
        _bos.insert(index, ocorrencia);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do boletim.');
      }
    }
  }

  Future<void> carregarBO() async {
    final response = await http.get(Uri.parse("$_baseUrl.json"));
    Map<String, dynamic> data = json.decode(response.body);
    var currentUser = FirebaseAuth.instance.currentUser!.uid.toString();

    _bos.clear();
    if (data != null) {
      data.forEach((Id, Data) {
          if(Data['responsavel'].toString() == currentUser) {
            _bos.add(Oco(
              id: Id,
              responsavel: Data['responsavel'],
              data: Data['data'],
              transmissao: Data['transmissao'],
              chegada: Data['chegada'],
              saida: Data['saida'],
              equipe: Data['equipe'],
              ocorrencia: Data['ocorrencia'],
              endereco: Data['endereco'],
              numero: Data['numero'],
              bairro: Data['bairro'],
              complemento: Data['complemento'],
              cidade: Data['cidade'],
              referencia: Data['referencia'],
              vit_nome: Data['vit_nome'],
              vit_nascimento: Data['vit_nascimento'],
              vit_endereco: Data['vit_endereco'],
              vit_numero: Data['vit_numero'],
              vit_bairro: Data['vit_bairro'],
              vit_complemento: Data['vit_complemento'],
              vit_cidade: Data['vit_cidade'],
              resumo: Data['resumo'],
              observacoes: Data['observacoes'],
            ));
          }
      });
      notifyListeners();
    }
    return Future.value();
  }

}

