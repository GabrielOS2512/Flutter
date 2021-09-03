// @dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdm_sisgera/mensagemADM.dart';
import 'package:pdm_sisgera/perfilADM.dart';
import 'package:pdm_sisgera/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'detalheCorpoADM.dart';
import 'editOcorrenciaADM.dart';
import 'todasCorporacoes.dart';
import 'editCorporacao.dart';
import 'editUserAdmin.dart';
import 'editOcorrencia.dart';
import 'editPerfil.dart';
import 'login.dart';
import 'cadastroOcorrencia.dart';
import 'main2.dart';
import 'mensagem.dart';
import 'listaOcorrencia.dart';
import 'novoCorporacao.dart';
import 'novoUser.dart';
import 'detalheOcorrencia.dart';
import 'ocorrenciaAdmin.dart';
import 'perfil.dart';
import 'providers/auth.dart';
import 'providers/corporacao.dart';
import 'providers/logado.dart';
import 'providers/mensagens.dart';
import 'providers/ocorrencia.dart';
import 'providers/users.dart';
import 'todasOcorrencia.dart';
import 'todosUsers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Future<void> _carregar(BuildContext context) {
  return Provider.of<UsersLogado>(context, listen: false).usuarioLogado();
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => new Ocos(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => new Corporacaos(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => new Users(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => new UsersLogado(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => new Mensagems(),
        ),
      ],
      child:MaterialApp(
        title: 'SisGera',
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFE5E3E3)),
        initialRoute: '/login',
        routes: {
          AppRoutes.LOGIN:(context)=> Login(),
          AppRoutes.HOME:(context)=> MyHomePage(),
          AppRoutes.ADMIN:(context)=> Main2(),
          AppRoutes.BOLETIM : (context)=> Ocorrencia(),
          AppRoutes.BOLETIMEDIT : (context)=> EditOco(),
          AppRoutes.BOLETIMEDITADM : (context)=> EditOcoADM(),
          AppRoutes.LISTAOCO:(context)=> ListaOcorrencia(),
          AppRoutes.MSG:(context)=> MSG(),
          AppRoutes.PERFIL:(context)=> Perfil(),
          AppRoutes.PERFILADM:(context)=> PerfilADM(),
          AppRoutes.EDITPERFIL:(context)=> EditPerfil(),
          AppRoutes.DETALHESOCO:(context)=> DetalhesOco(),
          AppRoutes.DETALHESCORPOADM:(context)=> DetalhesCorpoADM(),
          AppRoutes.NOVOUSER:(context)=> NewUser(),
          AppRoutes.ALLOCO:(context)=> TodasOco(),
          AppRoutes.ALLUSER:(context)=> TodosUser(),
          AppRoutes.EDITUSERADM:(context)=> EditUserAdmin(),
          AppRoutes.DETALHESADM:(context)=> DetalhesOcoAdmin(),
          AppRoutes.NEWCORP:(context)=> NewCorpo(),
          AppRoutes.CORPS:(context)=> TelaCorporacoes(),
          AppRoutes.EDITCORPS:(context)=> EditCorpo(),
          AppRoutes.MSGADMIN:(context)=> MSGADMIN(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    _carregar(context);
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
              Wrap(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async{
                      // Update the state of the app
                      final result = await Navigator.of(context).pushNamed(AppRoutes.BOLETIM);

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
                            colors: [Color(0xFF237100),Color(0xFF38AC00)]
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Text('Registrar', style: new TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                                new Text('Ocorrência', style: new TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                                new SizedBox(height: 20.0,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/listaocorrencia'),
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
                    onTap: () => Navigator.pushNamed(context, '/mensagens'),
                    child: Mensagens(),
                  ),

                  MinhasInfo(),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class Sair extends StatelessWidget{
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
   return PopupMenuButton(
     icon: Icon(Icons.more_vert),
     onSelected: (result) async {
       if (result == 0) {
         dynamic result = await _auth.sairAuth();
         Navigator.popUntil(context, ModalRoute.withName('/login'));
       }
     },
     itemBuilder: (BuildContext context) => <PopupMenuEntry>[
       PopupMenuItem(
         value: 0,
         child: ListTile(
           title: Text('Sair'),
         ),
       ),
     ],
   );

  }
}

class MeuDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    const primaryColor = const Color(0xFF840000);
    final uData = Provider.of<UsersLogado>(context);
    if(uData.items.isNotEmpty) {
      final USER = uData.items.first;
      return Drawer(
        child: Container(
          //color: Color(0xFF404040),
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(USER.nome,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                accountEmail: Text(USER.corpo_nome + ' - ' + USER.corpo_cidade),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: CachedNetworkImage(
                    imageUrl: USER.foto,
                    placeholder: (context, url) => new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                margin: EdgeInsets.all(0),
              ),
              Container(
                color: Color(0xFF1F1F1F),
                child: ListTile(
                  title: Text('Menu de Navegação',
                    style: TextStyle(color: Colors.white),),
                ),
              ),
              Container(
                //color: Color(0xFF404040),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Início'),
                  onTap: () {
                    Navigator.pushNamed(context, '/inicio');
                  },
                ),
              ),
              Container(
                //color: Color(0xFF404040),
                child: ListTile(
                  leading: Icon(Icons.save_outlined),
                  title: Text('Registrar Ocorrência'),
                  onTap: () async{
                    // Update the state of the app
                    final result = await Navigator.of(context).pushNamed(AppRoutes.BOLETIM);

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
                  title: Text('Listar Ocorrências'),
                  leading: Icon(Icons.article),
                  onTap: () {
                    // Update the state of the app
                    Navigator.pushNamed(context, '/listaocorrencia');
                  },
                ),
              ),
              Container(
                color: Color(0xFF1F1F1F),
                child: ListTile(
                  title: Text(
                    'Pessoal', style: TextStyle(color: Colors.white),),
                ),
              ),
              Container(
                //color: Color(0xFF404040),
                child: ListTile(
                  title: Text('Meu Perfil'),
                  leading: Icon(Icons.account_circle),
                  onTap: () {
                    // Update the state of the app
                    Navigator.pushNamed(context, '/perfil');
                  },
                ),
              ),
              Container(
                //color: Color(0xFF404040),
                child: ListTile(
                  title: Text('Mensagens'),
                  leading: Icon(Icons.message_rounded),
                  onTap: () {
                    // Update the state of the app
                    Navigator.pushNamed(context, '/mensagens');
                  },
                ),
              ),

            ],
          ),
        ),
      );
    } else {
      return Drawer(
        child: Container(
          //color: Color(0xFF404040),
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Erro Inesperado!",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                accountEmail: Text("Erro Inesperado!"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                margin: EdgeInsets.all(0),
              ),
              Container(
                color: Color(0xFF1F1F1F),
                child: ListTile(
                  title: Text('Menu de Navegação',
                    style: TextStyle(color: Colors.white),),
                ),
              ),
              Container(
                //color: Color(0xFF404040),
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Início'),
                  onTap: () {
                    Navigator.pushNamed(context, '/inicio');
                  },
                ),
              ),
              Container(
                //color: Color(0xFF404040),
                child: ListTile(
                  leading: Icon(Icons.save_outlined),
                  title: Text('Registrar Ocorrência'),
                  onTap: () {
                    // Update the state of the app
                    Navigator.pushNamed(context, '/cadastroocorrencia');
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
                    Navigator.pushNamed(context, '/listaocorrencia');
                  },
                ),
              ),
              Container(
                color: Color(0xFF1F1F1F),
                child: ListTile(
                  title: Text(
                    'Pessoal', style: TextStyle(color: Colors.white),),
                ),
              ),
              Container(
                //color: Color(0xFF404040),
                child: ListTile(
                  title: Text('Meu Perfil'),
                  leading: Icon(Icons.account_circle),
                  onTap: () {
                    // Update the state of the app
                    Navigator.pushNamed(context, '/perfil');
                  },
                ),
              ),
              Container(
                //color: Color(0xFF404040),
                child: ListTile(
                  title: Text('Mensagens'),
                  leading: Icon(Icons.message_rounded),
                  onTap: () {
                    // Update the state of the app
                    Navigator.pushNamed(context, '/mensagens');
                  },
                ),
              ),

            ],
          ),
        ),
      );
    }
  }
}

class MinhasInfo extends StatelessWidget{//TODO
  String corpo = '';

  @override
  Widget build(BuildContext context) {
    const primaryColor = const Color(0xFF840000);
    final uData = Provider.of<UsersLogado>(context);

    if(uData.items.isNotEmpty) {
      final USER = uData.items.first;
      corpo = USER.corporacao;
      return Container(
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
                    height: 300,
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
                              color: Color(0xffc62828)
                          ),
                          child: CachedNetworkImage(
                            imageUrl: USER.corpo_logo,
                            placeholder: (context, url) => new CircularProgressIndicator(),
                            errorWidget: (context, url, error) => new Icon(Icons.error),
                          ),
                        ),
                        new Text(USER.corpo_nome + ' - ' + USER.corpo_cidade,
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

                        Divider(),

                        new Row(children: <Widget>[
                          Text("Nome: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.nome, style: TextStyle(fontSize: 15.0)),
                        ]),
                        new Row(children: <Widget>[
                          Text("Data de Nascimento: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.data, style: TextStyle(fontSize: 15.0)),
                        ]),
                        new Row(children: <Widget>[
                          Text("Telefone: ", style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text(USER.telefone, style: TextStyle(fontSize: 15.0)),
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
      _carregar(context);
      return Container(
        child: new Container(
            constraints: BoxConstraints(minWidth: 200,maxWidth: 500),
            margin: new EdgeInsets.all(20.0),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
              color: Color(0xFFF6F2F2),
              boxShadow: [
                new BoxShadow(color: Colors.black12, blurRadius: 15.0,)
              ],
            ),
            child: Row(children: <Widget>[
              Text('Recarregando...',style: TextStyle(color: Colors.orange, fontSize: 20.0)),
              Text('Erro Inesperado',style: TextStyle(color: Colors.red, fontSize: 18.0))
            ]),
        ),
      );
    }
  }
}

class Mensagens extends StatelessWidget{
  String corpo = '';
  Future<void> _refresh(BuildContext context) {
    return Provider.of<Mensagems>(context, listen: false).loadMSGs(corpo);
  }

  @override
  Widget build(BuildContext context) {
    final uData = Provider.of<UsersLogado>(context);
    if(uData.items.isNotEmpty) {
      corpo = uData.items.first.corporacao;
    }
    _refresh(context);
    const primaryColor = const Color(0xFF840000);
    final msgData = Provider.of<Mensagems>(context);
    final msgs = msgData.items;final int n = msgData.msgCount;

    return Container(
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
                                itemCount: n,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.all(5),
                                       // height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF85EECD),
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
            ],
          ),
        ),
      ),
    );
  }
}


