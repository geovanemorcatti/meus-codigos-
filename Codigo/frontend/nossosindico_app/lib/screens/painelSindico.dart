// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:nossosindico_app/components/Backboard.dart';
import 'package:nossosindico_app/screens/Layout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nossosindico_app/screens/Login.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import '../components/listCondominium.dart';



class PainelSindico extends StatefulWidget {
  const PainelSindico();
  @override
  State<PainelSindico> createState() => _PainelSindicoState();
}


class _PainelSindicoState extends State<PainelSindico> {
  TextEditingController _Titulo = TextEditingController(),
  _Descricao = TextEditingController();

  TextEditingController _titulo = TextEditingController(),
      _descricao = TextEditingController();

      TextEditingController _valor = TextEditingController(),
      _nome = TextEditingController(),
      _rua = TextEditingController(),
      _bairro = TextEditingController(),
      _cidade = TextEditingController(),
      _cep = TextEditingController(),
  _data = TextEditingController();

  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 50),
                child: Text(
                  'Painel do Sindico',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FavoritPro'
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                child: Text(
                  'Criar Avisos',
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
                  controller: _Titulo,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Título',
                      hintText: 'Título do aviso',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _Descricao,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Descrição',
                      hintText: 'Descrição do aviso',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 8),
                child: ElevatedButton(
                  child: const Align(
                    alignment: Alignment.center,
                    child: Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        'Criar Aviso',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onPressed: () => { criarAviso(_Titulo.text, _Descricao.text) },
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
                child: Text(
                  'Criar Despesas',
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
                  controller: _titulo,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Título',
                      hintText: 'Título da despesa',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _descricao,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Descrição',
                      hintText: 'Descrição da despesa',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _valor,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Valor',
                      hintText: 'Valor da despesa',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(children: <Widget>[
                    Text('Insira a data (${format.pattern})', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    DateTimeField(
                      controller: _data,
                      format: format,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                  ])
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 8),
                child: ElevatedButton(
                  child: const Align(
                    alignment: Alignment.center,
                    child: Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        'Criar Despesa',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onPressed: () => { criarDespesa(_titulo.text, _descricao.text, _valor.text, _data.text) }
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
                child: Text(
                  'Editar condomínio',
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
                  controller: _nome,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: condominio.nome,
                      hintText: 'Nome do condomínio',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _rua,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: condominio.rua,
                      hintText: 'Rua do condomínio',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _bairro,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: condominio.bairro,
                      hintText: 'Bairro do condomínio',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _cidade,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: condominio.cidade,
                      hintText: 'Cidade do condomínio',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  controller: _cep,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: condominio.cep,
                      hintText: 'CEP do condomínio',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 8),
                child: ElevatedButton(
                  child: const Align(
                    alignment: Alignment.center,
                    child: Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        'Salvar alterações do condomínio',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onPressed: () => { attCondominio(_nome.text, _rua.text, _bairro.text, _cidade.text, _cep.text) },
                ),
              ),
            ]),
          ),
        )
    );
  }

  void attCondominio(String nome, String rua, String bairro, String cidade, String cep) async {
    var response;
    if(nome == "") nome = condominio.nome;
    if(rua == "") rua = condominio.rua;
    if(bairro == "") bairro = condominio.bairro;
    if(cidade == "") cidade = condominio.cidade;
    if(cep == "") cep = condominio.cep;
    var Url = 'http://localhost:8080/attCond';
    response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "id": condominio.id.toString(),
          "nome": nome,
          "rua": rua,
          "bairro": bairro,
          "cidade": cidade,
          "cep": cep,
          "code": condominio.chave
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _goToListCondominio();
    }
  }

  void criarAviso(String titulo, String descricao) async {
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
      _goToListCondominio();
    }
  }

  void _goToListCondominio() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(
              body: Backboard(),
              menuIcon: false
          )),
    );
  }

  criarDespesa(String titulo, String descricao, String valor, String data) async {
    var response;
    var Url = 'http://localhost:8080/cadDespessa';
    response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "id_condominio": condominio.id.toString(), "titulo": titulo, "descricao": descricao, "valor": valor, "data_referente": data
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _goToListCondominio();
    }
  }

}