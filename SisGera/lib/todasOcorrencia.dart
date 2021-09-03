import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdm_sisgera/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'exceptions/http_exception.dart';
import 'main.dart';
import 'main2.dart';
import 'providers/ocorrencia.dart';

class TodasOco extends StatelessWidget{
  Future<void> _refreshBO(BuildContext context) {
    return Provider.of<Ocos>(context, listen: false).loadBOs();
  }

  @override
  Widget build(BuildContext context) {
    final boData = Provider.of<Ocos>(context);
    final bos = boData.items;final int n = boData.boCount;
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
        onRefresh: () => _refreshBO(context),
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
                      child:Text('Lista de Ocorrências',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                  ),
                  Divider(
                    color: primaryColor,
                    thickness: 5.0,
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: boData.boCount,
                    itemBuilder: (ctx, i) => Column(
                      children: <Widget>[
                        BOItem(bos[i]),
                        Divider(),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child:Text(n.toString() + ' - Ocorrências Carregadas',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
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

class BOItem extends StatelessWidget {
  final Oco BOLETIM;

  BOItem(this.BOLETIM);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(BOLETIM.vit_nome),
      subtitle: Text(BOLETIM.data),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.BOLETIMEDIT, arguments: BOLETIM);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
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
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.of(context).pushNamed(AppRoutes.DETALHESADM, arguments: BOLETIM);
      },
    );
  }
}