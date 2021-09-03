import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'main2.dart';

enum Tipo { A, An, B, Bn, AB, ABn, O, On}

class EditUserAdmin extends StatefulWidget{
  EditUserADM createState()=> EditUserADM();
}

class EditUserADM extends State<EditUserAdmin>{
  String dropdownValue = 'Selecione';
  Tipo _tipo = Tipo.A;
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
          ]

      ),
      drawer: DrawerM(),

      body: Center(
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
                        child:Text('Editar Usuário',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                    ),
                    Divider(
                      color: primaryColor,
                      thickness: 5.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Informações Pessoais',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        initialValue: 'Gabriel Oliveira Silva',
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.account_box,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        initialValue: '25/12/1997',
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Data de Nascimento',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.calendar_today_outlined,
                          ),
                        ),
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
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Identidade',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.article,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Cat. Habilitação',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.article,
                          ),
                        ),
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
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'CEP',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.add_location,
                          ),
                        ),
                      ),
                    ),

                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Corporação',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      ),
                    ),

                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Selecione','CBV - São Domingos do Prata', 'ABV - Barão de Cocais', 'Servor - João Monlevade']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Dados de Login',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Matrícula',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.account_box,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Nova Senha',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                        ),
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
                          Navigator.pushNamed(context,'/todosUsers');
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
    );
  }

}
