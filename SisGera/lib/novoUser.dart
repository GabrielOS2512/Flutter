import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdm_sisgera/providers/corporacao.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'main2.dart';
import 'providers/auth.dart';
import 'providers/users.dart';

enum Tipo { A, An, B, Bn, AB, ABn, O, On}

class NewUser extends StatefulWidget{
  _NewUser createState()=> _NewUser();
}

class _NewUser extends State<NewUser>{
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;
  TextEditingController dateinput = TextEditingController();
  final AuthService _auth = AuthService();
  String imgURL = ''; String tiposanguineo = 'A+';

  Future<void> _refreshCorpo(BuildContext context) {
    return Provider.of<Corporacaos>(context, listen: false).loadCorpo();
  }

  String dropdownValue = 'Selecione';
  Tipo _tipo = Tipo.A;


  @override
  void initState() {
    dateinput.text = "";
    super.initState();
    _imageUrlFocusNode.addListener(_updateImage);
  }

  void _updateImage() {
    if (isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

  bool isValidImageUrl(String url) {
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    bool endsWithPng = url.toLowerCase().endsWith('.png');
    bool endsWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endsWithJpeg = url.toLowerCase().endsWith('.jpeg');
    return (startWithHttp || startWithHttps) &&
        (endsWithPng || endsWithJpg || endsWithJpeg);
  }


  Future<void> _saveForm() async {
    var isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    final product = User(
      id: _formData['uid'].toString(),
      foto: _formData['foto'].toString(),
      data: _formData['data'].toString(),
      nome: _formData['nome'].toString(),
      cpf: _formData['cpf'].toString(),
      telefone: _formData['telefone'].toString(),
      endereco: _formData['endereco'].toString(),
      numero: int.parse(_formData['numero'].toString()),
      bairro: _formData['bairro'].toString(),
      cidade: _formData['cidade'].toString(),
      corporacao: dropdownValue,
      tiposangue: tiposanguineo,
      email: _formData['email'].toString(),
      senha: _formData['senha'].toString(),
    );

    setState(() {
      _isLoading = true;
    });

    final products = Provider.of<Users>(context, listen: false);

    try {
      await products.novoUser(product);
      Navigator.pop(context, 'Usuário cadastrado com sucesso!');
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro ao registrar o usuário!'),
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
    _refreshCorpo(context);
    final corpoData = Provider.of<Corporacaos>(context);
    final cps = corpoData.items;final int n = corpoData.corpoCount;
    const primaryColor = const Color(0xFF840000);
    List<String> listaCorpo = ['Selecione'];

    for(int i =0;i<n;i++){
      //listaCorpo.add(cps[i].id);
      listaCorpo.add(cps[i].nome);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('SisGera'),
        actions: [

          Sair()
        ],

      ),
      drawer: DrawerM(),

      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          :Center(
        child:Form(
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
                          child:Text('Cadastrar Usuário',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                      ),
                      Divider(
                        color: primaryColor,
                        thickness: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Informações Pessoais',
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
                              return 'Informe o Nome';
                            }
                          },
                          onSaved: (value) => _formData['nome'] = value!,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: dateinput,
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
                                dateinput.text = formattedDate;
                              });
                            }else{

                            }
                          },

                          validator: (value){
                            if(value!.isEmpty){
                              return 'Informe a Data de Nascimento';
                            }
                          },
                          onSaved: (value) => _formData['data'] = value!,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Telefone',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Informe o Telefone';
                            }
                          },
                          onSaved: (value) => _formData['telefone'] = value!,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'CPF',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.article,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Informe o CPF';
                            }
                          },
                          onSaved: (value) => _formData['cpf'] = value!,
                        ),
                      ),

                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Tipo Sanguineo',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),

                      RadioListTile<Tipo>(
                        title: const Text('A+'),
                        value: Tipo.A,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tiposanguineo = 'A+';
                          });
                        },
                      ),
                      RadioListTile<Tipo>(
                        title: const Text('A-'),
                        value: Tipo.An,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tiposanguineo = 'A-';
                          });
                        },
                      ),
                      RadioListTile<Tipo>(
                        title: const Text('B+'),
                        value: Tipo.B,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tiposanguineo = 'B+';
                          });
                        },
                      ),
                      RadioListTile<Tipo>(
                        title: const Text('B-'),
                        value: Tipo.Bn,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tiposanguineo = 'B-';
                          });
                        },
                      ),
                      RadioListTile<Tipo>(
                        title: const Text('AB+'),
                        value: Tipo.AB,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tiposanguineo = 'AB+';
                          });
                        },
                      ),
                      RadioListTile<Tipo>(
                        title: const Text('AB-'),
                        value: Tipo.ABn,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tiposanguineo = 'AB-';
                          });
                        },
                      ),
                      RadioListTile<Tipo>(
                        title: const Text('O+'),
                        value: Tipo.O,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tiposanguineo = 'O+';
                          });
                        },
                      ),
                      RadioListTile<Tipo>(
                        title: const Text('O-'),
                        value: Tipo.On,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tiposanguineo = 'O-';
                          });
                        },
                      ),

                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Endereço',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Endereço',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.add_location,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Informe o Endereço';
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
                            labelText: 'Bairro',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.add_location,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Informe a bairro';
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
                            labelText: 'Número',
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

                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Corporação',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),

                      DropdownButtonFormField<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        // underline: Container(
                        //   height: 2,
                        //   color: Colors.black,
                        // ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: listaCorpo
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Selecione a Corporação';
                          }
                          if(value == 'Selecione'){
                            return 'Selecione a Corporação';
                          }
                        },
                      ),

                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Dados de Login',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.account_box,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Informe o Email';
                            }
                          },
                          onSaved: (value) => _formData['email'] = value!,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Informe a senha';
                            }
                            if(value.length < 6){
                              return 'Senha deve ter mais que 6 digitos';
                            }
                          },
                          onSaved: (value) => _formData['senha'] = value!,
                        ),
                      ),

                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Foto',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Insira Foto',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.add_location,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Insira a foto';
                            }
                          },
                          onChanged: (value) {
                            imgURL = value;
                            _updateImage();
                          },
                          onSaved: (value) => _formData['foto'] = value!,
                        ),
                      ),

                      Container(
                        constraints: BoxConstraints(maxWidth: 100,maxHeight: 100),
                        decoration: new BoxDecoration(
                          color: Colors.white
                        ),
                        child:CachedNetworkImage(
                          imageUrl: imgURL,
                          placeholder: (context, url) => new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                        ),
                      ),

                      SizedBox(
                          height: 8
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
                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Main2()));
                            }
                          },
                          icon: Icon(Icons.save, size: 18),
                          label: Text("Salvar"),
                        ),
                      ),

                      SizedBox(
                          height: 8
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
