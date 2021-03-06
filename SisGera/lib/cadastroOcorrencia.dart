import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'main.dart';
import 'providers/ocorrencia.dart';

enum Tipo { outro, vistoria, transporte, incendio, resgate, cobertura, via}

class Ocorrencia extends StatefulWidget{
  _Ocorrencia createState()=> _Ocorrencia();
}

class _Ocorrencia extends State<Ocorrencia>{
  Tipo _tipo = Tipo.outro;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;
  String tipoocorrencia = 'Outro';
  TextEditingController dateinput = TextEditingController();
  TextEditingController nascimentoinput = TextEditingController();
  TextEditingController transmissaoinput = TextEditingController();
  TextEditingController chegadainput = TextEditingController();
  TextEditingController saidainput = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    nascimentoinput.text = "";
    transmissaoinput.text = "";
    chegadainput.text = "";
    saidainput.text = "";
    super.initState();
  }

  Future<void> _saveForm() async {
    var isValid = _formKey.currentState!.validate();
    var currentUser = await FirebaseAuth.instance.currentUser!.uid.toString();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    final product = Oco(
      id: _formData['id'].toString(),
      responsavel: currentUser,
      data: _formData['data'].toString(),
      transmissao: _formData['transmissao'].toString(),
      chegada: _formData['chegada'].toString(),
      saida: _formData['saida'].toString(),
      equipe: _formData['equipe'].toString(),
      ocorrencia: tipoocorrencia + ': ' +_formData['detalhes'].toString(),
      endereco: _formData['endereco'].toString(),
      numero: int.parse(_formData['numero'].toString()),
      bairro: _formData['bairro'].toString(),
      complemento: _formData['complemento'].toString(),
      cidade: _formData['cidade'].toString(),
      referencia: _formData['referencia'].toString(),
      vit_nome: _formData['vit_nome'].toString(),
      vit_nascimento: _formData['vit_nascimento'].toString(),
      vit_endereco: _formData['vit_endereco'].toString(),
      vit_numero: int.parse(_formData['vit_numero'].toString()),
      vit_bairro: _formData['vit_bairro'].toString(),
      vit_complemento: _formData['vit_complemento'].toString(),
      vit_cidade: _formData['vit_cidade'].toString(),
      resumo: _formData['resumo'].toString(),
      observacoes: _formData['observacoes'].toString(),
    );

    setState(() {
      _isLoading = true;
    });

    final products = Provider.of<Ocos>(context, listen: false);

    try {
      await products.novoBO(product);
      Navigator.pop(context, 'Ocorr??ncia registrada com sucesso!');
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro pra salvar a Ocorr??ncia!'),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = const Color(0xFF840000);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('SisGera'),
        actions: [
          Sair()
        ],

      ),
      drawer: MeuDrawer(),

      body:_isLoading
          ? Center(
        child: CircularProgressIndicator(),
      ) : Center(
          child: Form(
            key: _formKey,
            child:SingleChildScrollView(
              child: Container(
                child: new Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  margin: new EdgeInsets.all(20.0),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                    color: Color(0xFFF6F2F2),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child:Text('Registrar Ocorr??ncia',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                        ),
                        Divider(
                          color: primaryColor,
                          thickness: 5.0,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Dados do Atendimento',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: dateinput,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Data da Ocorr??ncia',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.calendar_today_outlined,
                              ),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context, initialDate: DateTime.now(),
                                  firstDate: DateTime(2019),
                                  lastDate: DateTime(2025)
                              );

                              if(pickedDate != null ){
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  dateinput.text = formattedDate;
                                });
                              }else{

                              }
                            },
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe a data';
                              }
                            },
                            onSaved: (value) => _formData['data'] = value!,

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: transmissaoinput,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Transmiss??o',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.access_time_outlined,
                              ),
                            ),

                            onTap: () async {
                              TimeOfDay time = TimeOfDay.now();
                              FocusScope.of(context).requestFocus(new FocusNode());

                              TimeOfDay? picked =
                              await showTimePicker(context: context, initialTime: time);
                              if (picked != null && picked != time) {
                                transmissaoinput.text = picked.format(context);
                                setState(() {
                                  time = picked;
                                });
                              }
                            },

                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe a transmissao';
                              }
                            },
                            onSaved: (value) => _formData['transmissao'] = value!,

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: chegadainput,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Chegada ao Local',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.access_time_outlined,
                              ),
                            ),

                            onTap: () async {
                              TimeOfDay time = TimeOfDay.now();
                              FocusScope.of(context).requestFocus(new FocusNode());

                              TimeOfDay? picked =
                              await showTimePicker(context: context, initialTime: time);
                              if (picked != null && picked != time) {
                                chegadainput.text = picked.format(context);
                                setState(() {
                                  time = picked;
                                });
                              }
                            },

                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe a chegada';
                              }
                            },
                            onSaved: (value) => _formData['chegada'] = value!,

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: saidainput,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Sa??da do Local',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.access_time_outlined,
                              ),
                            ),

                            onTap: () async {
                              TimeOfDay time = TimeOfDay.now();
                              FocusScope.of(context).requestFocus(new FocusNode());

                              TimeOfDay? picked =
                              await showTimePicker(context: context, initialTime: time);
                              if (picked != null && picked != time) {
                                saidainput.text = picked.format(context);
                                setState(() {
                                  time = picked;
                                });
                              }
                            },

                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe a saida';
                              }
                            },
                            onSaved: (value) => _formData['saida'] = value!,

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Equipe de Plant??o',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.account_circle,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe a equipe em plant??o';
                              }
                            },
                            onSaved: (value) => _formData['equipe'] = value!,

                          ),
                        ),

                        Divider(),

                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Dados da Ocorr??ncia',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                          ),
                        ),

                        RadioListTile<Tipo>(
                          title: const Text('Cobertura em Evento'),
                          value: Tipo.cobertura,
                          groupValue: _tipo,
                          onChanged: (Tipo? value) {
                            setState((){
                              _tipo = value!;
                              tipoocorrencia = 'Cobertura em Evento';
                            });
                          },
                        ),
                        RadioListTile<Tipo>(
                          title: const Text('Resgate e Salvamento'),
                          value: Tipo.resgate,
                          groupValue: _tipo,
                          onChanged: (Tipo? value) {
                            setState((){
                              _tipo = value!;
                              tipoocorrencia = 'Resgate e Salvamento';
                            });
                          },
                        ),
                        RadioListTile<Tipo>(
                          title: const Text('Transporte Hospitalar'),
                          value: Tipo.transporte,
                          groupValue: _tipo,
                          onChanged: (Tipo? value) {
                            setState((){
                              _tipo = value!;
                              tipoocorrencia = 'Transporte Hospitalar';
                            });
                          },
                        ),
                        RadioListTile<Tipo>(
                          title: const Text('Combate ?? Inc??ndio'),
                          value: Tipo.incendio,
                          groupValue: _tipo,
                          onChanged: (Tipo? value) {
                            setState((){
                              _tipo = value!;
                              tipoocorrencia = 'Combate ?? Inc??ndio';
                            });
                          },
                        ),
                        RadioListTile<Tipo>(
                          title: const Text('Vistoria e Inspe????o'),
                          value: Tipo.vistoria,
                          groupValue: _tipo,
                          onChanged: (Tipo? value) {
                            setState((){
                              _tipo = value!;
                              tipoocorrencia = 'Vistoria e Inspe????o';
                            });
                          },
                        ),
                        RadioListTile<Tipo>(
                          title: const Text('Desobstru????o de Via'),
                          value: Tipo.via,
                          groupValue: _tipo,
                          onChanged: (Tipo? value) {
                            setState((){
                              _tipo = value!;
                              tipoocorrencia = 'Desobstru????o de Via';
                            });
                          },
                        ),
                        RadioListTile<Tipo>(
                          title: const Text('Outro'),
                          value: Tipo.outro,
                          groupValue: _tipo,
                          onChanged: (Tipo? value) {
                            setState((){
                              _tipo = value!;
                              tipoocorrencia = 'Outro';
                            });
                          },
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Detalhes',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.article,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe o dado';
                              }
                            },
                            onSaved: (value) => _formData['detalhes'] = value!,

                          ),
                        ),

                        Divider(),

                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Local da Ocorr??ncia',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Endere??o',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.add_location,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe o endereco';
                              }
                            },
                            onSaved: (value) => _formData['endereco'] = value!,

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'N??mero',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.add_location,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe o numero';
                              }
                            },
                            onSaved: (value) => _formData['numero'] = value!,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Bairro',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.add_location,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe o bairro';
                              }
                            },
                            onSaved: (value) => _formData['bairro'] = value!,

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Complemento',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.add_location,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe o complemento';
                              }
                            },
                            onSaved: (value) => _formData['complemento'] = value!,

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Cidade',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.add_location,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe a cidade';
                              }
                            },
                            onSaved: (value) => _formData['cidade'] = value!,

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Ponto de Refer??ncia',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.add_location,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe a referencia';
                              }
                            },
                            onSaved: (value) => _formData['referencia'] = value!,

                          ),
                        ),

                        Divider(),

                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Dados da V??tima/Solicitante',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Nome',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.account_box,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe o nome';
                              }
                            },
                            onSaved: (value) => _formData['vit_nome'] = value!,

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: nascimentoinput,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Data de Nascimento',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.calendar_today_outlined,
                              ),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context, initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                              );

                              if(pickedDate != null ){
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  nascimentoinput.text = formattedDate;
                                });
                              }else{

                              }
                            },
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe a data';
                              }
                            },
                            onSaved: (value) => _formData['vit_nascimento'] = value!,

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Endere??o',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.add_location,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe o endere??o';
                              }
                            },
                            onSaved: (value) => _formData['vit_endereco'] = value!,

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'N??mero',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.add_location,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe o numero';
                              }
                            },
                            onSaved: (value) => _formData['vit_numero'] = value!,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            keyboardType: TextInputType.number,

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Bairro',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.add_location,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe o bairro';
                              }
                            },
                            onSaved: (value) => _formData['vit_bairro'] = value!,

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Complemento',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.add_location,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe';
                              }
                            },
                            onSaved: (value) => _formData['vit_complemento'] = value!,

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Cidade',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.add_location,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe a Cidade da vitima';
                              }
                            },
                            onSaved: (value) => _formData['vit_cidade'] = value!,

                          ),
                        ),

                        Divider(),

                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Dados Adicionais',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Resumo',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.article,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe a resumo';
                              }
                            },
                            onSaved: (value) => _formData['resumo'] = value!,

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Observa????es',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.article,
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Informe a observacoes';
                              }
                            },
                            onSaved: (value) => _formData['observacoes'] = value!,

                          ),
                        ),

                        SizedBox(
                          width: 100,
                          height: 30,
                          child:ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              final form = _formKey.currentState;
                              if(form!.validate()) {
                                _saveForm();
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
                              }
                            },
                            icon: Icon(Icons.save, size: 18),
                            label: Text("Salvar"),
                          ),
                        ),
                        SizedBox(
                            height: 10
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }

}



