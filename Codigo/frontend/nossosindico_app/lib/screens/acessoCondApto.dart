// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, avoid_web_libraries_in_flutter
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nossosindico_app/components/Backboard.dart';
import 'package:nossosindico_app/screens/Login.dart';

import '../modules/MenuPage.dart';
import 'Layout.dart';

void main() => runApp(AcessApto());

class AcessApto extends StatefulWidget {
  const AcessApto();

  @override
  State<AcessApto> createState() => _AcessAptoState();
}


  class _AcessAptoState extends State<AcessApto> {

    TextEditingController
    _controladorApto = TextEditingController(),
        _controladorCodigo = TextEditingController();

    Future<void> odioDisso(String apto, String Codigo) async {
      var Url = 'http://localhost:8080/entraCond';
      var response = await http.post(Uri.parse(Url), headers: <String, String>{"Content-Type":"application/json"}, body: jsonEncode(<String, String>{
        "numeroApto":apto, "id_usuario": usuario.id.toString(), "acesso":Codigo
      }));
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200){
        _goToBackboard();
      }
    }

    void _goToBackboard() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Layout(body: Backboard(), menuPage: MenuPage.Backboard)),
      );
    }


    @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 50),
          child: Text(
            'Entrar no seu condomínio',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'FavoritPro'
            ),
          ),
        ),



        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: TextFormField(
            controller: _controladorApto,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Número - Apto.',
                hintText: 'Digite aqui o número do seu apto.',
                hintStyle: TextStyle(color: Colors.blueGrey[100])),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: TextFormField(
            controller: _controladorCodigo,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Codigo Condominio',
                hintText: 'Digite aqui o número do seu apto.',
                hintStyle: TextStyle(color: Colors.blueGrey[100])),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 8),
          child: ElevatedButton(
            child: const Align(
              alignment: Alignment.center,
              child: Padding(padding:EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  'Entrar no condomínio',
                  style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
              onPressed: () => {
              odioDisso(_controladorApto.text, _controladorCodigo.text) }
          ),
        ),
      ]),
    );
  }
}

