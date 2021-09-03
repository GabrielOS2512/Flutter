import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdm_sisgera/providers/ocorrencia.dart';
import 'package:provider/provider.dart';

import 'listaOcorrencia.dart';
import 'main.dart';

enum Tipo { outro, vistoria, transporte, resgate, cobertura, via}

class EditOcoADM extends StatefulWidget{
  EditOcorrencia createState()=> EditOcorrencia();
}

class EditOcorrencia extends State<EditOcoADM>{
  Tipo _tipo = Tipo.outro;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;
  String ID='';String tipoocorrencia = 'Outro';
  TextEditingController dateinput = TextEditingController();
  TextEditingController nascimentoinput = TextEditingController();
  TextEditingController transmissaoinput = TextEditingController();
  TextEditingController chegadainput = TextEditingController();
  TextEditingController saidainput = TextEditingController();

  Future<void> _saveForm() async {
    var isValid = _formKey.currentState!.validate();
    var currentUser = FirebaseAuth.instance.currentUser!.uid.toString();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    final product = Oco(
      id: ID,
      responsavel: currentUser,
      data: _formData['data'].toString(),
      transmissao: _formData['transmissao'].toString(),
      chegada: _formData['chegada'].toString(),
      saida: _formData['saida'].toString(),
      equipe: _formData['equipe'].toString(),
      ocorrencia: tipoocorrencia + ': ' +_formData['detalhes'].toString(),
      endereco: _formData['endereco'].toString(),
      numero: int.parse(_formData['numero'].toString()),
      bairro: _formData['bairro'].toString(),
      complemento: _formData['complemento'].toString(),
      cidade: _formData['cidade'].toString(),
      referencia: _formData['referencia'].toString(),
      vit_nome: _formData['vit_nome'].toString(),
      vit_nascimento: _formData['vit_nascimento'].toString(),
      vit_endereco: _formData['vit_endereco'].toString(),
      vit_numero: int.parse(_formData['vit_numero'].toString()),
      vit_bairro: _formData['vit_bairro'].toString(),
      vit_complemento: _formData['vit_complemento'].toString(),
      vit_cidade: _formData['vit_cidade'].toString(),
      resumo: _formData['resumo'].toString(),
      observacoes: _formData['observacoes'].toString(),
    );

    setState(() {
      _isLoading = true;
    });

    final products = Provider.of<Ocos>(context, listen: false);

    try {
      await products.updateBO(product);
      Navigator.pop(context, 'Ocorrência atualizada com sucesso!');
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro pra salvar a Ocorrência!'),
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
    const primaryColor = const Color(0xFF840000);
    final Oco BOLETIM = ModalRoute.of(context)!.settings.arguments as Oco;
    ID = BOLETIM.id;
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
        child: Form(
          key: _formKey,
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
                          child:Text('Editar Ocorrência',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                      ),
                      Divider(
                        color: primaryColor,
                        thickness: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Dados do Atendimento',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          initialValue: BOLETIM.data,
                          onSaved: (value) => _formData['data'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Data da Ocorrência',
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
                          initialValue: BOLETIM.transmissao,
                          onSaved: (value) => _formData['transmissao'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Transmissão',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.access_time_outlined,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          initialValue: BOLETIM.chegada,
                          onSaved: (value) => _formData['chegada'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Chegada ao Local',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.access_time_outlined,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          initialValue: BOLETIM.saida,
                          onSaved: (value) => _formData['saida'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Saída do Local',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.access_time_outlined,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          initialValue: BOLETIM.equipe,
                          onSaved: (value) => _formData['equipe'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Equipe de Plantão',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.account_circle,
                            ),
                          ),
                        ),
                      ),

                      Divider(),

                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Dados da Ocorrência',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),

                      RadioListTile<Tipo>(
                        title: const Text('Cobertura em Evento'),
                        value: Tipo.cobertura,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tipoocorrencia ='Cobertura em Evento';
                          });
                        },
                      ),
                      RadioListTile<Tipo>(
                        title: const Text('Resgate e Salvamento'),
                        value: Tipo.resgate,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tipoocorrencia ='Resgate e Salvamento';
                          });
                        },
                      ),
                      RadioListTile<Tipo>(
                        title: const Text('Transporte Hospitalar'),
                        value: Tipo.transporte,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tipoocorrencia ='Transporte Hospitalar';
                          });
                        },
                      ),
                      RadioListTile<Tipo>(
                        title: const Text('Vistoria e Inspeção'),
                        value: Tipo.vistoria,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tipoocorrencia ='Vistoria e Inspeção';
                          });
                        },
                      ),
                      RadioListTile<Tipo>(
                        title: const Text('Desobstrução de Via'),
                        value: Tipo.via,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tipoocorrencia ='Desobstrução de Via';
                          });
                        },
                      ),
                      RadioListTile<Tipo>(
                        title: const Text('Outro'),
                        value: Tipo.outro,
                        groupValue: _tipo,
                        onChanged: (Tipo? value) {
                          setState((){
                            _tipo = value!;
                            tipoocorrencia ='Outro';
                          });
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          initialValue: BOLETIM.ocorrencia,
                          onSaved: (value) => _formData['detalhes'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Detalhes',
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
                          initialValue: BOLETIM.endereco,
                          onSaved: (value) => _formData['endereco'] = value!,
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
                          initialValue: BOLETIM.numero.toString(),
                          onSaved: (value) => _formData['numero'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Número',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.add_location,
                            ),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          keyboardType: TextInputType.number,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          initialValue: BOLETIM.bairro,
                          onSaved: (value) => _formData['bairro'] = value!,
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
                          initialValue: BOLETIM.complemento,
                          onSaved: (value) => _formData['complemento'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Complemento',
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
                          initialValue: BOLETIM.cidade,
                          onSaved: (value) => _formData['cidade'] = value!,
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
                          initialValue: BOLETIM.referencia,
                          onSaved: (value) => _formData['referencia'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Ponto de Referência',
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
                          'Dados da Vítima/Solicitante',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          initialValue: BOLETIM.vit_nome,
                          onSaved: (value) => _formData['vit_nome'] = value!,
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
                          style: TextStyle(color: Colors.black),
                          initialValue: BOLETIM.vit_nascimento,
                          onSaved: (value) => _formData['vit_nascimento'] = value!,
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
                          initialValue: BOLETIM.vit_endereco,
                          onSaved: (value) => _formData['vit_endereco'] = value!,
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
                          initialValue: BOLETIM.vit_numero.toString(),
                          onSaved: (value) => _formData['vit_numero'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Número',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.add_location,
                            ),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          keyboardType: TextInputType.number,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          onSaved: (value) => _formData['vit_bairro'] = value!,
                          initialValue: BOLETIM.vit_bairro,
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
                          onSaved: (value) => _formData['vit_complemento'] = value!,
                          initialValue: BOLETIM.vit_complemento,
                          decoration: InputDecoration(
                            labelText: 'Complemento',
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
                          initialValue: BOLETIM.vit_cidade,
                          onSaved: (value) => _formData['vit_cidade'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Cidade',
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
                          'Dados Adicionais',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          initialValue: BOLETIM.resumo,
                          onSaved: (value) => _formData['resumo'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Resumo',
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
                          initialValue: BOLETIM.observacoes,
                          onSaved: (value) => _formData['observacoes'] = value!,
                          decoration: InputDecoration(
                            labelText: 'Observações',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.article,
                            ),
                          ),
                        ),
                      ),

                      Row(
                        children: <Widget>[
                          SizedBox(
                              width: 40
                          ),
                          SizedBox(
                            width: 100,
                            height: 30,
                            child:ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.cancel, size: 18),
                              label: Text("Cancelar"),
                            ),
                          ),
                          SizedBox(
                              width: 20
                          ),
                          SizedBox(
                            width: 100,
                            height: 30,
                            child:ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                              ),
                              onPressed: () {
                                final form = _formKey.currentState;
                                if(form!.validate()) {
                                  _saveForm();
                                }
                              },
                              icon: Icon(Icons.save, size: 18),
                              label: Text("Salvar"),
                            ),
                          ),

                        ],
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
      ),
    );
  }

}



