import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'exceptions/http_exception.dart';
import 'main.dart';
import 'main2.dart';
import 'providers/corporacao.dart';
import 'utils/app_routes.dart';

class DetalhesCorpoADM extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final Corporacao CORPO = ModalRoute.of(context)!.settings.arguments as Corporacao;

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
                            child:Text('Detalhes da Corporação',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
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
                                new Container(
                                  width: 60,
                                  height: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffbb0707)
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: CORPO.logo,
                                    placeholder: (context, url) => new CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => new Icon(Icons.error),
                                  ),
                                ),
                                new Text(CORPO.nome +' - '+CORPO.cidade, style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),

                                Divider(),

                                new Row(children: <Widget>[
                                  Text("Código: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(CORPO.id, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("E-Mail: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(CORPO.email, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Telefone: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(CORPO.telefone, style: TextStyle(fontSize: 15.0)),
                                ]),

                                Divider(),

                                new Row(children: <Widget>[
                                  Text("Endereço: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(CORPO.endereco, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Bairro: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(CORPO.bairro, style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Nº: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(CORPO.numero.toString(), style: TextStyle(fontSize: 15.0)),
                                ]),
                                new Row(children: <Widget>[
                                  Text("Cidade: ", style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                  Text(CORPO.cidade, style: TextStyle(fontSize: 15.0)),
                                ]),

                                Divider(),

                                new Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 10,
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
                                        icon: Icon(Icons.cancel, size: 18),
                                        label: Text("Voltar"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                      height: 50,
                                    ),
                                    SizedBox(
                                      width: 80,
                                      height: 30,
                                      child:ElevatedButton.icon(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                                        ),
                                        onPressed: () async{
                                          final result = await Navigator.of(context).pushNamed(AppRoutes.EDITCORPS, arguments: CORPO);
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text('$result'),
                                            duration: const Duration(seconds: 2),
                                          ));
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
                                      width: 80,
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
                                                await Provider.of<Corporacaos>(context, listen: false)
                                                    .deleteCorpo(CORPO.id);
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