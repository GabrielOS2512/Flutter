import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'providers/logado.dart';
import 'providers/mensagens.dart';

DateTime now = new DateTime.now();

class MSG extends StatefulWidget{
  CaixaMensagens createState()=> CaixaMensagens();
}

class CaixaMensagens extends State<MSG>{
  Future<void> _refresh(BuildContext context) {
    return Provider.of<Mensagems>(context, listen: false).loadMSGs(corpo);
  }
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  String autor =''; String corpo ='';
  bool _isLoading = false;

  Future<void> _saveForm() async {
    var isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    final product = Mensagem(
      id: corpo,
      data: now.toString(),
      autor: autor,
      mensagem: _formData['mensagem'].toString(),
      corpo: corpo,
    );

    setState(() {
      _isLoading = true;
    });

    final products = Provider.of<Mensagems>(context, listen: false);

    try {
      await products.enviarMSG(product);
      _refresh(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Mensagem Enviada'),
        duration: const Duration(seconds: 2),
      ));
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro ao enviar a mensagem!'),
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
    final msgData = Provider.of<Mensagems>(context);
    final msgs = msgData.items;final int n_msgs = msgData.msgCount;
    const primaryColor = const Color(0xFF840000);
    final uData = Provider.of<UsersLogado>(context);
    if(uData.items.isNotEmpty) {
      final USER = uData.items.first;
      autor = USER.nome; corpo = USER.corporacao;
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
      drawer: MeuDrawer(),

      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          :Center(
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
                        child:Text('Caixa de Mensagens',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                    ),
                    Divider(
                      color: primaryColor,
                      thickness: 5.0,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15,15,15,15),
                      child:Container(
                        height: 300,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: ListView.separated(
                                padding: const EdgeInsets.all(10),
                                itemCount: n_msgs,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF66E7C2),
                                      borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text('${msgs[index].mensagem} ',style: TextStyle(fontWeight: FontWeight.bold),),
                                        Text('${msgs[index].autor} - Em: ${msgs[index].data}'),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) => const Divider(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: primaryColor,
                      thickness: 5.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          onSaved: (value) => _formData['mensagem'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Nova Mensagem',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.message,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 30,
                      child:ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                        ),
                        onPressed: () {
                          final form = _formKey.currentState;
                          if(form!.validate()) {
                            _saveForm();
                          }
                        },
                        icon: Icon(Icons.send, size: 18),
                        label: Text("Enviar"),
                      ),
                    ),
                    SizedBox(
                        height: 10
                    ),
                    //
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }

}