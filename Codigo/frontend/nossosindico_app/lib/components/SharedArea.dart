import 'package:flutter/material.dart';

import 'package:nossosindico_app/modules/SizeConfig.dart';
import 'package:nossosindico_app/screens/Login.dart';
import 'package:nossosindico_app/modules/Area.dart';
import 'package:nossosindico_app/screens/Layout.dart';
import 'package:nossosindico_app/components/Reservation.dart';
import 'package:nossosindico_app/modules/MenuPage.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SheradArea extends StatefulWidget {
  const SheradArea();
  @override
  State<SheradArea> createState() => _SheradAreaState();
}

class _SheradAreaState extends State<SheradArea> {
  List<Area> listaAreas = [];

  Future<List<Area>> getAllArea() async {
    var Url = 'http://localhost:8080/listEspaco';
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
      List<Area> areas = [];
      for (int i = 0; i < parsedMapJson.length; i++) {
        Area area = Area.fromJson(parsedMapJson[i]);
        areas.add(area);
        print(condominio);
      }
      return areas;
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
            future: getAllArea().then((value) => {
              listaAreas = value,
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
                        itemCount: listaAreas.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Layout(
                                      title: "Reserva ${listaAreas[index].nome}",
                                      body: Reservation(listaAreas[index]),
                                      menuPage: MenuPage.None,
                                      register: false,
                                    )),
                              );
                            },
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 100),
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color:
                                  const Color.fromARGB(255, 240, 240, 240),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Text(
                                    listaAreas[index].nome,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Capacidade: ${listaAreas[index].capacidade}',
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    listaAreas[index].descricao,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                      ),
                    ),
                  ]),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            }));
  }
}