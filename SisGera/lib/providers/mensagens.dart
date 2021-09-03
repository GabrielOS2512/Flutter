import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../exceptions/http_exception.dart';
import '../utils/constants.dart';

class Mensagem with ChangeNotifier {
  final String id;
  final String data;
  final String autor;
  final String corpo;
  final String mensagem;

  Mensagem({
    required this.id,
    required this.data,
    required this.autor,
    required this.mensagem,
    required this.corpo,
  });

  factory Mensagem.fromJson(Map<String, dynamic> json) {
    return Mensagem (
      id: json['id'],
      data: json['data'],
      autor: json['autor'],
      mensagem: json['mensagem'],
      corpo: json['corpo'],
    );
  }

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() => {
    'id:': id,
    'data': data,
    'autor': autor,
    'mensagem': mensagem,
    'corpo': corpo,
  };

}

class Mensagems with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_API_URL}/mensagens';
  List<Mensagem> _msg = [];

  List<Mensagem> get items => [..._msg];

  int get msgCount {
    return _msg.length;
  }

  Future<void> loadMSGs(String corpo) async {
    final response = await http.get(Uri.parse("$_baseUrl.json"));
    var currentUser = FirebaseAuth.instance.currentUser!.uid.toString();
    Map<String, dynamic> data = json.decode(response.body);

    _msg.clear();
    if (data != null) {
      data.forEach((productId, productData) {
        if(productData['corpo'].toString() == corpo || productData['corpo'].toString() == 'ADMIN') {
          _msg.add(Mensagem(
            id: productId,
            data: productData['data'],
            autor: productData['autor'],
            mensagem: productData['mensagem'],
            corpo: productData['corpo'],
          ));
        }
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> loadMSGsAll() async {
    final response = await http.get(Uri.parse("$_baseUrl.json"));
    Map<String, dynamic> data = json.decode(response.body);

    _msg.clear();
    if (data != null) {
      data.forEach((productId, productData) {
        _msg.add(Mensagem(
          id: productId,
          data: productData['data'],
          autor: productData['autor'],
          mensagem: productData['mensagem'],
          corpo: productData['corpo'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> enviarMSG(Mensagem newMSG) async {
    final response = await http.post(
        Uri.parse("$_baseUrl.json"),
      body: json.encode({
        'data': newMSG.data,
        'autor': newMSG.autor,
        'mensagem': newMSG.mensagem,
        'corpo': newMSG.corpo,
      }),
    );

    _msg.add(Mensagem(
      id: json.decode(response.body)['autor'],
      data: newMSG.data,
      autor: newMSG.autor,
      mensagem: newMSG.mensagem,
      corpo: newMSG.corpo,
    ));
    notifyListeners();
  }
}
