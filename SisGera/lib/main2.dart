import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdm_sisgera/utils/app_routes.dart';

import 'main.dart';

//enum Tipo { outro, vistoria, transporte, resgate, cobertura, via}

class Main2 extends StatefulWidget{
  MainP createState()=> MainP();
}

class DrawerM extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    const primaryColor = const Color(0xFF840000);
    return Drawer(
      child: Container(
        //color: Color(0xFF404040),
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Administrador",style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("Admin"),
              ),
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              margin: EdgeInsets.all(0),
            ),
            Container(
              color: Color(0xFF1F1F1F),
              child: ListTile(
                title: Text('Menu de Navegação',style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(
              //color: Color(0xFF404040),
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Início'),
                onTap: () {
                  Navigator.pushNamed(context,'/admin');
                },
              ),
            ),
            Container(
              //color: Color(0xFF404040),
              child: ListTile(
                title: Text('Listar Ocorrências'),
                leading: Icon(Icons.article),
                onTap: () {
                  // Update the state of the app
                  Navigator.pushNamed(context,'/todasocorrencia');
                },
              ),
            ),

            Container(
              //color: Color(0xFF404040),
              child: ListTile(
                title: Text('Mensagens'),
                leading: Icon(Icons.mail_outline_outlined),
                onTap: () {
                  // Update the state of the app
                  Navigator.pushNamed(context,'/mensagensADM');
                },
              ),
            ),

            Container(
              color: Color(0xFF1F1F1F),
              child: ListTile(
                title: Text('Usuários',style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(
              //color: Color(0xFF404040),
              child: ListTile(
                leading: Icon(Icons.save_outlined),
                title: Text('Cadastrar Usuário'),
                onTap: () async{
                  // Update the state of the app
                  final result = await Navigator.of(context).pushNamed(AppRoutes.NOVOUSER);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('$result'),
                    duration: const Duration(seconds: 2),
                  ));

                },
              ),
            ),
            Container(
              //color: Color(0xFF404040),
              child: ListTile(
                title: Text('Listar Usuários'),
                leading: Icon(Icons.article_outlined),
                onTap: () {
                  // Update the state of the app
                  Navigator.pushNamed(context,'/todosUsers');
                },
              ),
            ),
            Container(
              color: Color(0xFF1F1F1F),
              child: ListTile(
                title: Text('Corporações',style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(
              //color: Color(0xFF404040),
              child: ListTile(
                title: Text('Cadastrar Corporação'),
                leading: Icon(Icons.save_outlined),
                onTap: () async{
                  // Update the state of the app
                  final result = await Navigator.of(context).pushNamed(AppRoutes.NEWCORP);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('$result'),
                    duration: const Duration(seconds: 2),
                  ));
                },
              ),
            ),
            Container(
              //color: Color(0xFF404040),
              child: ListTile(
                title: Text('Exibir Corporações'),
                leading: Icon(Icons.article_outlined),
                onTap: () {
                  // Update the state of the app
                  Navigator.pushNamed(context,'/corporacoes');
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class MainP extends State<Main2> {
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
      body: Center(
        child:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Wrap(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async{
                      // Update the state of the app
                      final result = await Navigator.of(context).pushNamed(AppRoutes.NOVOUSER);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('$result'),
                        duration: const Duration(seconds: 2),
                      ));
                    },
                    child: new Container(
                      constraints: BoxConstraints(maxWidth: 500),
                      height: 150.0,
                      margin: new EdgeInsets.all(20.0),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                        gradient: new LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.22, 0.1],
                            colors: [Color(0xFF715900),Color(0xFFAC8700)]
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Text('Cadastrar', style: new TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                                new Text('Usuário', style: new TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                                new SizedBox(height: 20.0,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/todasocorrencia'),
                    child: new Container(
                      constraints: BoxConstraints(maxWidth: 500),
                      height: 150.0,
                      margin: new EdgeInsets.all(20.0),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                        gradient: new LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.22, 0.1],
                            colors: [Color(0xFF000F86),Color(0xFF0011B6)]
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Text('Listar', style: new TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                                new Text('Ocorrências', style: new TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                                new SizedBox(height: 30.0,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/todosUsers'),
                    child: new Container(
                      constraints: BoxConstraints(maxWidth: 500),
                      height: 150.0,
                      margin: new EdgeInsets.all(20.0),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                        gradient: new LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.22, 0.1],
                            colors: [Color(0xFF008667),Color(0xFF00B682)]
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Text('Listar', style: new TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                                new Text('Usuários', style: new TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                                new SizedBox(height: 30.0,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{
                      // Update the state of the app
                      final result = await Navigator.of(context).pushNamed(AppRoutes.NEWCORP);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('$result'),
                        duration: const Duration(seconds: 2),
                      ));
                    },
                    child: new Container(
                      constraints: BoxConstraints(maxWidth: 500),
                      height: 150.0,
                      margin: new EdgeInsets.all(20.0),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                        gradient: new LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.22, 0.1],
                            colors: [Color(0xFF6D0086),Color(0xFF8F00B6)]
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Text('Cadastrar', style: new TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                                new Text('Corporação', style: new TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                                new SizedBox(height: 30.0,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
