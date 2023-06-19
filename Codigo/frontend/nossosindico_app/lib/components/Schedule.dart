import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nossosindico_app/modules/SizeConfig.dart';
import 'package:nossosindico_app/modules/Evento.dart';
import 'package:http/http.dart' as http;
import '../modules/NroApto.dart';
import '../screens/Login.dart';

class Schedule extends StatefulWidget {
  const Schedule();
  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  List<Evento> listaEvento = [];

  Future<List<Evento>> _getListEvento() async {
    listaEvento.clear();
    var url = 'http://localhost:8080/listReserva';
    final Response = await http.post(Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "id": condominio.id.toString(),
          "nome": condominio.nome,
          "rua": condominio.rua,
          "numero": condominio.numero.toString(),
          "bairro": condominio.bairro,
          "cidade": condominio.cidade,
          "cep": condominio.cep,
          "id_usuario": usuario.id.toString()
        }));
    print(Response.statusCode);
    print(Response.body);
    if (Response.statusCode == 200) {
      List<dynamic> parsedMapJson = json.decode(Response.body);
      for (int i = 0; i < parsedMapJson.length; i++) {
        Evento evento = Evento.fromJson(parsedMapJson[i]);
        final datas = evento.data.split("-");
        String datona = datas[2] + "/" + datas[1] + "/" + datas[0];
        evento.data = datona;
        listaEvento.add(evento);
        print(condominio);
      }
      return listaEvento;
    } else {
      throw Exception('DEU erro imbecil');
    }
  }

  String weekString(int week) {
    String resp = "";
    switch (week) {
      case 1:
        resp = "Segunda";
        break;
      case 2:
        resp = "Terça";
        break;
      case 3:
        resp = "Quarta";
        break;
      case 4:
        resp = "Quinta";
        break;
      case 5:
        resp = "Sexta";
        break;
      case 6:
        resp = "Sabado";
        break;
      case 7:
        resp = "Domingo";
        break;
      default:
        resp = "Que coisa";
    }
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            width: SizeConfig.safeBlockHorizontal! * 85 < SizeConfig.screenWidth!
                ? SizeConfig.safeBlockHorizontal! * 85
                : SizeConfig.screenWidth!,
            child: Column(children: [
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 100 - 160,
                child: SingleChildScrollView(
                  child: FutureBuilder<List<Evento>>(
                      future: _getListEvento(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(20),
                            itemCount: snapshot.data!.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                            const Divider(),
                            itemBuilder: (BuildContext context, int index) {
                              return Row(children: [
                                SizedBox(
                                  width: 80,
                                  child: Column(
                                    children: [
                                      Text(
                                        DateFormat("dd/MM").format(
                                            DateFormat('d/M/y').parse(
                                                snapshot.data![index].data)),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'FavoritPro'),
                                      ),
                                      Text(
                                        weekString(DateFormat('d/M/y')
                                            .parse(snapshot.data![index].data)
                                            .weekday),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  snapshot.data![index].descricao,
                                ),
                              ]);
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return const CircularProgressIndicator();
                      }),
                ),
              ),
            ])));
  }
}