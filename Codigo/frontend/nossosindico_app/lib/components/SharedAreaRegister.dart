import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nossosindico_app/components/SharedArea.dart';
import 'package:nossosindico_app/modules/SizeConfig.dart';
import 'package:nossosindico_app/modules/Area.dart';
import 'package:nossosindico_app/modules/FieldValidator.dart';
import 'package:http/http.dart' as http;

import '../screens/Layout.dart';
import '../screens/Login.dart';

class SheradAreaRegister extends StatefulWidget {
  const SheradAreaRegister();
  @override
  State<SheradAreaRegister> createState() => _SheradAreaRegisterState();
}

class _SheradAreaRegisterState extends State<SheradAreaRegister> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controladorNome = TextEditingController(),
      _controladorDescricao= TextEditingController(),
      _controladorCapacidade= TextEditingController();

  void fetchPost(Area area) async {
    var Url = 'http://localhost:8080/createEspaco';
    var response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "nome" : area.nome,
          "descricao" : area.descricao,
          "capacidadeMax" : area.capacidade.toString(),
          "id_condominio": condominio.id.toString()
        }));
    print(response.statusCode);
    print(response.body);
    _goToCadastroCondominio(context);
  }

  void onPressed() {
    if (_formKey.currentState!.validate()) {
      Area area = Area(0, _controladorNome.text, _controladorDescricao.text, int.parse(_controladorCapacidade.text));
      fetchPost(area);
    }
  }

  void _goToCadastroCondominio(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(
              body: SheradArea(),
              menuIcon: false
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      key: _formKey,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          width: SizeConfig.safeBlockHorizontal! * 85 < SizeConfig.screenWidth!
              ? SizeConfig.safeBlockHorizontal! * 85
              : SizeConfig.screenWidth!,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller: _controladorNome,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: 'Nome',
                      hintText: 'Nome do Area',
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                  keyboardType: TextInputType.name,
                  validator: FieldValidator.ValidarSenha,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller: _controladorDescricao,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: 'Descrição',
                      hintText: 'Descrição do Item',
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                  keyboardType: TextInputType.multiline,
                  validator: FieldValidator.ValidarSenha,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller: _controladorCapacidade,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: 'Capacidade',
                      hintText: 'Capacidade de pessoas',
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                  keyboardType: TextInputType.number,
                  validator: FieldValidator.ValidarSenha,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: ElevatedButton(
                  child: const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        'Sign-up',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}