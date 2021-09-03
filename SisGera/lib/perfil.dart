import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdm_sisgera/providers/logado.dart';
import 'package:pdm_sisgera/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class MeuPerfil extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    const primaryColor = const Color(0xFF840000);
    final uData = Provider.of<UsersLogado>(context);
    if (uData.items.isNotEmpty) {
      final USER = uData.items.first;
      return Container(
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
                    child: Text('Minhas Informações', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),)
                ),
                Divider(
                  color: primaryColor,
                  thickness: 5.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Container(
                    //height: 300,
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(
                          new Radius.circular(6.0)),
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
                              color: Color(0xff93f5eb)
                          ),
                          child: CachedNetworkImage(
                            imageUrl: USER.foto,
                            placeholder: (context, url) => new CircularProgressIndicator(),
                            errorWidget: (context, url, error) => new Icon(Icons.error),
                          ),
                        ),
                        new Text(USER.nome, style: new TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),),
                        Divider(),
                        new Row(children: <Widget>[
                          Text("Data de Nascimento: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.data, style: TextStyle(fontSize: 15.0)),
                        ]),
                        new Row(children: <Widget>[
                          Text("Telefone: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.telefone,
                              style: TextStyle(fontSize: 15.0)),
                        ]),
                        new Row(children: <Widget>[
                          Text("E-Mail:  ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.email, style: TextStyle(fontSize: 15.0)),
                        ]),
                        new Row(children: <Widget>[
                          Text("Tipo Sanguíneo: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.tiposangue, style: TextStyle(fontSize: 15.0)),
                        ]),
                        new Row(children: <Widget>[
                          Text("CPF:  ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.cpf,
                              style: TextStyle(fontSize: 15.0)),
                        ]),

                        Divider(),

                        new Row(children: <Widget>[
                          Text("Endereço: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.endereco,
                              style: TextStyle(fontSize: 15.0)),
                        ]),
                        new Row(children: <Widget>[
                          Text("Bairro: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.bairro, style: TextStyle(fontSize: 15.0)),
                        ]),
                        new Row(children: <Widget>[
                          Text("Nº: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.numero.toString(), style: TextStyle(fontSize: 15.0)),
                        ]),
                        new Row(children: <Widget>[
                          Text("Cidade: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.cidade,
                              style: TextStyle(fontSize: 15.0)),
                        ]),

                        Divider(),

                        SizedBox(
                          width: 180,
                          height: 30,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                            ),
                            onPressed: () async{
                              //Navigator.of(context).pushNamed(AppRoutes.EDITPERFIL, arguments: USER);
                              final result = await Navigator.of(context).pushNamed(AppRoutes.EDITPERFIL, arguments: USER);

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('$result'),
                                duration: const Duration(seconds: 2),
                              ));

                            },
                            icon: Icon(Icons.perm_identity, size: 18),
                            label: Text("Editar Informações"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(

      );
    }
  }

}

class MinhaCorporacao extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    const primaryColor = const Color(0xFF840000);
    final uData = Provider.of<UsersLogado>(context);
    if (uData.items.isNotEmpty) {
      final USER = uData.items.first;
      return Container(
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
                    child: Text('Corporação', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),)
                ),
                Divider(
                  color: primaryColor,
                  thickness: 5.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Container(
                    //height: 300,
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.all(
                          new Radius.circular(6.0)),
                      color: Color(0xFFF6F2F2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(maxWidth: 100,maxHeight: 100),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffbb0707)
                          ),
                          child: CachedNetworkImage(
                            imageUrl: USER.corpo_logo,
                            placeholder: (context, url) => new CircularProgressIndicator(),
                            errorWidget: (context, url, error) => new Icon(Icons.error),
                          ),
                        ),
                        new Text(USER.corpo_nome + ' - ' + USER.corpo_cidade ,
                          style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),),
                        Divider(),
                        new Row(children: <Widget>[
                          Text("Endereço: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.corpo_endereco, style: TextStyle(fontSize: 15.0)),
                        ]),
                        new Row(children: <Widget>[
                          Text("Bairro: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.corpo_bairro, style: TextStyle(fontSize: 15.0)),
                        ]),
                        new Row(children: <Widget>[
                          Text("Nº: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.corpo_numero.toString(), style: TextStyle(fontSize: 15.0)),
                        ]),
                        new Row(children: <Widget>[
                          Text("E-mail: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.corpo_email,
                              style: TextStyle(fontSize: 15.0)),
                        ]),
                        new Row(children: <Widget>[
                          Text("Telefone: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.corpo_telefone,
                              style: TextStyle(fontSize: 15.0)),
                        ]),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(

      );
    }
  }
}

class Perfil extends StatelessWidget{

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
      body: Center(
        child:SingleChildScrollView(
          child: Column(
              children: <Widget>[
                MeuPerfil(),
                MinhaCorporacao(),
              ],
          ),
        ),
      ),
    );
  }

}