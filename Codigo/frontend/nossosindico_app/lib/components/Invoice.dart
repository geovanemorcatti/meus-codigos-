import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nossosindico_app/modules/SizeConfig.dart';
import 'package:nossosindico_app/modules/Fatura.dart';
import 'package:http/http.dart' as http;

import '../screens/Login.dart';

class Invoice extends StatefulWidget {
  const Invoice();
  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  DateTime data = DateTime.now();
  List<Fatura> listaFatura = [];
  double Total = 0.0;

  Future<List<Fatura>> _getListFatura() async {
    listaFatura.clear();
    var Url = 'http://localhost:8080/listDespessa';
    var response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          'id' : condominio.id.toString(),
          'chave': condominio.chave,
          'nome': condominio.nome,
          'cep': condominio.cep,
          'rua': condominio.rua,
          'numero': condominio.numero.toString(),
          'bairro': condominio.bairro,
          'cidade': condominio.cidade,
        }));
    List<Fatura> lista = [];
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> parsedMapJson = json.decode(response.body);
      for (int i = 0; i < parsedMapJson.length; i++) {
        Fatura fatura = Fatura.fromJson(parsedMapJson[i]);
        lista.add(fatura);
        print(condominio);
      }
      lista = lista.where((element) => element.data.month == data.month && element.data.year == data.year).toList();
      listaFatura.addAll(lista);
      total();
      return lista;
    }
    return lista;
  }

  void alteraData(bool soma) {
    DateTime datinha = DateTime.now();
      if (soma) {
        datinha = DateTime(data.year, data.month + 1, data.day);
      } else {
        datinha = DateTime(data.year, data.month - 1, data.day);
      }
  setState(() {
  data = datinha;
  });
  _getListFatura();
}

  void total() {
    double total = 0;
    for (Fatura item in listaFatura) {
      total += item.valor;
    }
    setState(() {
      Total = total;
    });
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  alteraData(false);
                },
                icon: const Icon(Icons.arrow_back_ios),
                iconSize: 30,
                tooltip: "Mês anterior",
              ),
              Text(DateFormat("MM/yyyy").format(data)),
              IconButton(
                onPressed: () {
                  alteraData(true);
                },
                icon: const Icon(Icons.arrow_forward_ios),
                iconSize: 30,
                tooltip: "Mês posterior",
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 100 - 250,
            child: SingleChildScrollView(
              child: FutureBuilder<List<Fatura>>(
                  future: _getListFatura(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(20),
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: SizeConfig.safeBlockHorizontal! * 55 <
                                      SizeConfig.screenWidth! - 100
                                      ? SizeConfig.safeBlockHorizontal! * 55
                                      : SizeConfig.screenWidth! - 100,
                                  child: Text(
                                    snapshot.data![index].nome,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'FavoritPro'),
                                  ),
                                ),
                                Text('R\$ ${snapshot.data![index].valor}'),
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
          const Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            const Text(
              "Total: ",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'FavoritPro'),
            ),
            Text('R\$ ${Total.toStringAsFixed(2)}'),
          ]),
        ]),
      ),
    );
  }
}