import 'package:flutter/material.dart';

import 'package:nossosindico_app/modules/SizeConfig.dart';
import 'package:nossosindico_app/screens/Login.dart';
import 'package:nossosindico_app/screens/Layout.dart';
import 'package:nossosindico_app/modules/Aviso.dart';

import '../screens/painelSindico.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Backboard extends StatefulWidget {
  const Backboard();
  @override
  State<Backboard> createState() => _BackboardState();
}

class _BackboardState extends State<Backboard> {
  List<Aviso> listaAvisos = [];

  Future<List<Aviso>> getAllAviso() async {
    var Url = 'http://localhost:8080/listAvisos';
    final response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "id": condominio.id.toString(),
          "nome": condominio.nome,
          "rua": condominio.rua,
          "bairro": condominio.bairro,
          "cidade": condominio.cidade,
          "cep": condominio.cep,
          "code": condominio.chave
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> parsedMapJson = json.decode(response.body);
      List<Aviso> avisos = [];
      for (int i = 0; i < parsedMapJson.length; i++) {
        Aviso aviso = Aviso.fromJson(parsedMapJson[i]);
        avisos.add(aviso);
        print(condominio);
      }
      return avisos;
    } else {
      throw Exception('DEU erro imbecil');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Align(
        alignment: Alignment.center,
        child: FutureBuilder(
            future: getAllAviso().then((value) => {
              listaAvisos = value,
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  width: SizeConfig.safeBlockHorizontal! * 85 < 400
                      ? SizeConfig.safeBlockHorizontal! * 85
                      : 400,
                  child: Column(children: [
                    SizedBox(
                        height: SizeConfig.safeBlockVertical! * 80,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: listaAvisos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              constraints: const BoxConstraints(minHeight: 100),
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color:
                                  const Color.fromARGB(255, 240, 240, 240),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              listaAvisos[index].titulo,
                                              style: const TextStyle(
                                                  fontFamily: 'Helvetica Neue',
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.info,
                                                color: Colors.black),
                                            onPressed: () {},
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                              child: Text(
                                                  listaAvisos[index].descricao))
                                        ],
                                      )
                                    ],
                                  )),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                        )),
                  ]),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            }));
  }
}