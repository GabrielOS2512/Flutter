import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdm_sisgera/providers/auth.dart';
import 'package:pdm_sisgera/providers/logado.dart';
import 'package:provider/provider.dart';

import 'main.dart';

enum Tipo { A, An, B, Bn, AB, ABn, O, On}

class EditPerfil extends StatefulWidget{
  Edit createState()=> Edit();
}

class Edit extends State<EditPerfil>{
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  TextEditingController dateinput = TextEditingController();
  bool _isLoading = false;
  String imgURL = ''; String tiposanguineo = 'A+';String Ucorporacao='';String UID='';
  String corpo_logo='';String corpo_nome='';String corpo_endereco='';String corpo_bairro='';String corpo_email='';String corpo_cidade='';String corpo_telefone='';int corpo_numero=0;

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  Future<void> _saveForm() async {
    var isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    final product = UserLogado(
      uid: UID,
      foto: _formData['foto'].toString(),
      data: _formData['data'].toString(),
      nome: _formData['nome'].toString(),
      cpf: _formData['cpf'].toString(),
      telefone: _formData['telefone'].toString(),
      endereco: _formData['endereco'].toString(),
      numero: int.parse(_formData['numero'].toString()),
      bairro: _formData['bairro'].toString(),
      cidade: _formData['cidade'].toString(),
      corporacao: Ucorporacao,
      tiposangue: tiposanguineo,
      email: _formData['email'].toString(),
      senha: _formData['senha'].toString(),
      corpo_logo: corpo_logo,
      corpo_cidade: corpo_cidade,
      corpo_endereco: corpo_endereco,
      corpo_email: corpo_email,
      corpo_bairro: corpo_bairro,
      corpo_telefone: corpo_telefone,
      corpo_numero: corpo_numero,
      corpo_nome: corpo_nome,
    );

    setState(() {
      _isLoading = true;
    });

    final products = Provider.of<UsersLogado>(context, listen: false);

    try {
      await products.updateUser1(product);
      Navigator.pop(context, 'Usuário atualizado com sucesso!');
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro ao salvar!' + error.toString()),
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

  Tipo _tipo = Tipo.A;
  @override
  Widget build(BuildContext context) {
    final UserLogado USER = ModalRoute.of(context)!.settings.arguments as UserLogado;tiposanguineo = USER.tiposangue;UID = USER.uid;
    Ucorporacao=USER.corporacao;corpo_logo=USER.corpo_logo;corpo_cidade=USER.cidade;corpo_endereco=USER.corpo_endereco;corpo_email=USER.corpo_email;corpo_bairro=USER.corpo_bairro;corpo_telefone=USER.corpo_telefone;corpo_numero=USER.corpo_numero;corpo_nome=USER.corpo_nome;
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

      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      ):Center(
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
                          child:Text('Editar Perfil',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                      ),
                      Divider(
                        color: primaryColor,
                        thickness: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Minhas Informações',
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
                            initialValue: USER.nome,
                          onSaved: (value) => _formData['nome'] = value!,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: 'Data de Nascimento',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.calendar_today_outlined,
                              ),
                            ),
                            initialValue: USER.data,
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
                            initialValue: USER.telefone,
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
                            initialValue: USER.cpf,
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
                            initialValue: USER.endereco,
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
                            initialValue: USER.bairro,
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
                            initialValue: USER.numero.toString(),
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
                            initialValue: USER.cidade,
                            onSaved: (value) => _formData['cidade'] = value!,
                        ),
                      ),

                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Alterar Login',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          initialValue: USER.email,
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.mail,
                            ),
                          ),
                          onSaved: (value) => _formData['email'] = value!,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          initialValue: USER.senha,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                          ),
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
                          initialValue: USER.foto,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Insira Foto',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.add_location,
                            ),
                          ),
                          onSaved: (value) => _formData['foto'] = value!,
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
                            _saveForm();
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
