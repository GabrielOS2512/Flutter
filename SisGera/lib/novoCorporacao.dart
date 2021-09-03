import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'main2.dart';
import 'providers/corporacao.dart';

class NewCorpo extends StatefulWidget{
  Corpo createState()=> Corpo();
}

class Corpo extends State<NewCorpo>{
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;
  String imgURL = '';

  @override
  void initState() {
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

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImage);
    _imageUrlFocusNode.dispose();
  }

  Future<void> _saveForm() async {
    var isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    final product = Corporacao(
      id: _formData['id'].toString(),
      logo: _formData['logo'].toString(),
      nome: _formData['nome'].toString(),
      email: _formData['email'].toString(),
      telefone: _formData['telefone'].toString(),
      endereco: _formData['endereco'].toString(),
      numero: int.parse(_formData['numero'].toString()),
      bairro: _formData['bairro'].toString(),
      cidade: _formData['cidade'].toString(),
    );

    setState(() {
      _isLoading = true;
    });

    final products = Provider.of<Corporacaos>(context, listen: false);

    try {
      await products.novaCorpo(product);
      Navigator.pop(context, 'Corporação cadastrada com sucesso!');
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro pra salvar a Corporação!'),
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
      drawer: DrawerM(),

      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          :Center(
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
                          child:Text('Nova Corporação',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                      ),
                      Divider(
                        color: primaryColor,
                        thickness: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Informações',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Nome da Corporação',
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
                          onSaved: (value) => _formData['nome'] = value!,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.mail_outline,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Informe o E-mail';
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
                            labelText: 'Telefone',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Informe o telefone';
                            }
                          },
                          onSaved: (value) => _formData['telefone'] = value!,
                        ),
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
                              return 'Informe o endereço';
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
                          'Logo',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Insira Logo',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.add_location,
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Insira o Logo';
                            }
                          },
                          onChanged: (value) {
                            imgURL = value;
                            _updateImage();
                            },
                          onSaved: (value) => _formData['logo'] = value!,
                        ),
                      ),

                      CachedNetworkImage(
                        imageUrl: imgURL,
                        placeholder: (context, url) => new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
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
