// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, avoid_web_libraries_in_flutter

import 'dart:convert';

import 'package:nossosindico_app/modules/SizeConfig.dart';

import 'package:flutter/material.dart';
import 'package:nossosindico_app/screens/Login.dart';
import 'package:http/http.dart' as http;

import '../components/listCondominium.dart';
import 'Layout.dart';

class CadastroCondominio extends StatefulWidget {
  const CadastroCondominio();
  @override
  State<CadastroCondominio> createState() => CadastroCondominioState();
}

class CadastroCondominioState extends State<CadastroCondominio> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _controladorNome = TextEditingController(),
      _controladorRua = TextEditingController(),
      _controladorNumero = TextEditingController(),
      _controladorBairro = TextEditingController(),
      _controladorCidade = TextEditingController(),
      _controladorCep = TextEditingController(),
      _controladorApartamento = TextEditingController();

  botaoAction() {
    print('Clicou no botao');
  }

  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
          const Layout(
            body: listCondominium(),
            menuIcon: false,
          )),
    );
  }

  Future<void> _cadastrarCondominio(String nome, String rua, String numero,
      String bairro, String cidade, String cep, String apartamento) async {
    var Url = 'http://localhost:8080/cadCond';
    var response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "nome": nome,
          "rua": rua,
          "numero": numero,
          "bairro": bairro,
          "cidade": cidade,
          "cep": cep,
          "numeroApto": apartamento,
          "id_usuario": usuario.id.toString()
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
        _goToRegister();
      } else {
      print('Errou a senha animal');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          width: SizeConfig.safeBlockHorizontal! * 85 < 400
              ? SizeConfig.safeBlockHorizontal! * 85
              : 400,
          //height: SizeConfig.blockSizeVertical! * 50,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 50),
                child: Text(
                  'Cadastre o seu condomínio',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FavoritPro'),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _controladorNome,
                  /*style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),*/
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Nome',
                      hintText: 'Nome do condomínio',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _controladorRua,
                  /*style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),*/
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Rua',
                      hintText: 'Rua do condomínio',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _controladorNumero,
                  /*style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),*/
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Numero',
                      hintText: 'Numero do Condominio',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _controladorBairro,
                  /*style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),*/
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Bairro',
                      hintText: 'Bairro do condomínio',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _controladorCidade,
                  /*style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),*/
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Cidade',
                      hintText: 'Cidade do condomínio',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _controladorCep,
                  /*style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),*/
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'CEP',
                      hintText: 'CEP do condomínio',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _controladorApartamento,
                  /*style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),*/
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Apartamento',
                      hintText: 'Número do apartamento',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 8),
                child: ElevatedButton(
                  child: const Align(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        'Salvar Cadastro',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onPressed: () => {
                    _cadastrarCondominio(
                        _controladorNome.text,
                        _controladorRua.text,
                        _controladorNumero.text,
                        _controladorBairro.text,
                        _controladorCidade.text,
                        _controladorCep.text,
                        _controladorApartamento.text)
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}