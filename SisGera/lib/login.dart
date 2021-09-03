import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';
import 'providers/auth.dart';
import 'providers/logado.dart';

class Login extends StatefulWidget{
  Logar createState()=> Logar();
}

class Logar extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String email = '';
  String senha = '';
  String erro = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF840000),
        title: Text('SisGera'),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: Container(
              constraints: BoxConstraints(maxHeight: 370,maxWidth: 450),
              decoration: new BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15.0,
                  ),
                ],
              ),
              child: Card(

                color: Color(0xFFDEDDDD),
                margin: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'SisGera',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36),
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
                            Icons.account_box,
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Informe o E-mail';
                          }
                        },
                        onChanged: (val){
                          setState(() => email = val);
                        }
                        //onSaved: (value) => _formData['email'] = value!,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        obscureText: true,
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
                          onChanged: (val){
                            setState(() => senha = val);
                        }
                        //onSaved: (value) => _formData['senha'] = value!,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 30,
                      child:ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                        ),
                        onPressed: () async {
                          final form = _formKey.currentState;
                          if(form!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(
                                children: <Widget>[
                                  new CircularProgressIndicator(),
                                  new Text("  Realizando Login...")
                                ]),
                              duration: Duration(seconds: 6),
                            ));
                            dynamic result = await _auth.logarAuth(email, senha);
                            if(result == null){
                              setState(() {
                                erro = 'E-Mail ou Senha inválidos!';
                              });
                            } else {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              if (email == 'admin@sisgeraflutter.com'){
                                Navigator.pushNamed(context, '/admin');
                              } else {
                                Navigator.pushNamed(context, '/inicio');
                              }
                            }

                          }
                        },
                        icon: Icon(Icons.arrow_forward_outlined, size: 18),
                        label: Text("Entrar"),
                      ),
                    ),
                    Text(erro,style: TextStyle(color: Colors.red, fontSize: 14.0),)
                  ],
                ),
              ),
            ),
          ) ,
        ),
    );
  }
}