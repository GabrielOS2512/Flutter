import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'exceptions/http_exception.dart';
import 'main.dart';
import 'main2.dart';
import 'providers/logado.dart';
import 'providers/ocorrencia.dart';
import 'utils/app_routes.dart';

class DetalhesOcoAdmin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final Oco BOLETIM = ModalRoute.of(context)!.settings.arguments as Oco;

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

      body: Center(
        child:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: new Container(
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
                            child:Text('Detalhes da Ocorrência',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                        ),
                        Divider(
                          color: primaryColor,
                          thickness: 5.0,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15,0,15,15),
                          child:Container(
                            //height: 300,
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                              color: Color(0xFFF6F2F2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: <Widget>[

                                new Row(children: <Widget>[
                                  Text("Código: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.id, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Data da Ocorrencia: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.data, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Transmissão: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.transmissao, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Chegada ao Local: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.chegada, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Saída do Local: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.saida, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Equipe de Plantão:  ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.equipe, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Responsável:  ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.responsavel, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Wrap(children: <Widget>[
                                  Text("Tipo de Ocorrência:  ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.ocorrencia, style: TextStyle(fontSize: 15.0)),
                                ]),

                                Divider(),

                                new Row(children: <Widget>[
                                  Text("Endereço: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.endereco, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Bairro: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.bairro, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Nº: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.numero.toString(), style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Cidade: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.cidade, style: TextStyle(fontSize: 15.0)),
                                ]),

                                Divider(),

                                new Row(children: <Widget>[
                                  Text("Vítima/Solicitante: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.vit_nome, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Data de Nascimento: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.vit_nascimento, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Bairro: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.vit_bairro, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Nº: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.vit_numero.toString(), style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Cidade: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.cidade, style: TextStyle(fontSize: 15.0)),
                                ]),
                                Divider(),

                                new Wrap(children: <Widget>[
                                  Text("Resumo: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.resumo, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Wrap(children: <Widget>[
                                  Text("Observações: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(BOLETIM.observacoes, style: TextStyle(fontSize: 15.0)),
                                ]),

                                new Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 30,
                                      height: 50,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: 30,
                                      child:ElevatedButton.icon(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(Icons.arrow_back, size: 18),
                                        label: Text("Voltar"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                      height: 50,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: 30,
                                      child:ElevatedButton.icon(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(AppRoutes.BOLETIMEDIT, arguments: BOLETIM);
                                        },
                                        icon: Icon(Icons.article_sharp, size: 18),
                                        label: Text("Editar"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                      height: 50,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: 30,
                                      child:ElevatedButton.icon(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: Text('Excluir Ocorrencia'),
                                              content: Text('Tem certeza?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('Não'),
                                                  onPressed: () => Navigator.of(context).pop(false),
                                                ),
                                                TextButton(
                                                  child: Text('Sim'),
                                                  onPressed: () => Navigator.of(context).pop(true),
                                                ),
                                              ],
                                            ),
                                          ).then((value) async {
                                            if (value) {
                                              try {
                                                await Provider.of<Ocos>(context, listen: false)
                                                    .deleteBO(BOLETIM.id);
                                              } on HttpException catch (error) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text(error.toString()),
                                                  ),
                                                );
                                              }
                                            }
                                          });
                                        },
                                        icon: Icon(Icons.web_sharp, size: 18),
                                        label: Text("Excluir"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
