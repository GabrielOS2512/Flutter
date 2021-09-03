import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'exceptions/http_exception.dart';
import 'main.dart';
import 'main2.dart';
import 'providers/corporacao.dart';
import 'utils/app_routes.dart';

class TelaCorporacoes extends StatelessWidget{
  Future<void> _refreshCorpo(BuildContext context) {
    return Provider.of<Corporacaos>(context, listen: false).loadCorpo();
  }

  @override
  Widget build(BuildContext context) {
    final corpoData = Provider.of<Corporacaos>(context);
    final cps = corpoData.items;final int n = corpoData.corpoCount;
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

      body: RefreshIndicator(
        onRefresh: () => _refreshCorpo(context),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
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
                      child:Text('Lista de Corporações',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                  ),
                  Divider(
                    color: primaryColor,
                    thickness: 5.0,
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: corpoData.corpoCount,
                    itemBuilder: (ctx, i) => Column(
                      children: <Widget>[
                        CorpoItem(cps[i]),
                        Divider(),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child:Text(n.toString() + ' - Corporações Carregadas',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                  ),
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child:Text('Puxe do topo ao centro para atualizar',style: TextStyle(fontSize: 12),)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class CorpoItem extends StatelessWidget {
  final Corporacao CORPO;

  CorpoItem(this.CORPO);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: CORPO.logo,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
      title: Text(CORPO.nome),
      subtitle: Text(CORPO.cidade),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.EDITCORPS, arguments: CORPO);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir Corporação'),
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
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.of(context).pushNamed(AppRoutes.DETALHESCORPOADM, arguments: CORPO);
      },
    );
  }
}