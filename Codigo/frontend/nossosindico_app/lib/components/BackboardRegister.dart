import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nossosindico_app/components/Backboard.dart';
import 'package:nossosindico_app/modules/SizeConfig.dart';
import 'package:nossosindico_app/modules/Aviso.dart';
import 'package:nossosindico_app/modules/FieldValidator.dart';
import 'package:http/http.dart' as http;
import 'package:nossosindico_app/screens/Login.dart';

import '../modules/MenuPage.dart';
import '../screens/Layout.dart';

class BackboardRegister extends StatefulWidget {
  const BackboardRegister();
  @override
  State<BackboardRegister> createState() => _BackboardRegisterState();
}

class _BackboardRegisterState extends State<BackboardRegister> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controladorTitlo = TextEditingController(),
      _controladorDescricao = TextEditingController();

  void fetchPost(Aviso aviso) async {
    var Url = 'http://localhost:8080/cadastroAviso';
    var response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "titulo": aviso.titulo,
          "descricao": aviso.descricao,
        }));
    print(response.statusCode);
    Navigator.pop(context);
  }

  void onPressed(String titulo, String descricao) async {
    var response;
    var Url = 'http://localhost:8080/cadAviso';
    response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "id_condominio": condominio.id.toString(), "titulo": titulo, "conteudo": descricao
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _goToBackboard();
    }
  }

  void _goToBackboard() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(
            title: "Quadro de Avisos",
            body: Backboard(),
            menuPage: MenuPage.Backboard,
            register: true,
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
                  controller: _controladorTitlo,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: 'Título',
                      hintText: 'Título do Item',
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                  keyboardType: TextInputType.datetime,
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
                  keyboardType: TextInputType.name,
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
                  onPressed: () => { onPressed(_controladorTitlo.text, _controladorDescricao.text) },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}