import 'package:flutter/material.dart';
import 'package:nossosindico_app/components/Backboard.dart';
import 'package:nossosindico_app/modules/MenuPage.dart';
import 'package:nossosindico_app/modules/Condominio.dart';
import 'package:nossosindico_app/screens/Layout.dart';
import 'package:nossosindico_app/screens/Login.dart';
import 'package:nossosindico_app/screens/acessoCondApto.dart';
import 'package:nossosindico_app/modules/SizeConfig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../screens/CadastroCondominio.dart';

class listCondominium extends StatefulWidget {
  const listCondominium();

  @override
  State<listCondominium> createState() => _listCondominiumState();
}

class _listCondominiumState extends State<listCondominium> {
  final TextEditingController controladorBusca = TextEditingController();

  Future<List<Condominio>> getAllCondominio() async {
    var Url = 'http://localhost:8080/listCondUsu';
    final response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "id": usuario.id.toString(),
          "nome": usuario.nome,
          "sobrenome": usuario.sobrenome,
          "email": usuario.email,
          "senha": usuario.senha
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> parsedMapJson = json.decode(response.body);
      List<Condominio> condominios = [];
      for (int i = 0; i < parsedMapJson.length; i++) {
        Condominio condominio = Condominio.fromJson(parsedMapJson[i]);
        condominios.add(condominio);
        print(condominio);
      }
      return condominios;
    } else {
      throw Exception('DEU erro imbecil');
    }
  }

  void _gotToAcessoCondominio() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(
            body: AcessApto(),
            menuPage: MenuPage.Condominium,
            menuIcon: false,
            accontIcon: false,
          )),
    );
  }

  void _goToBackboard(Condominio snapshot) async {
    condominio.setNull();
    condominio = snapshot;
    print(usuario.id.toString() + " " + condominio.id.toString());
    var Url = 'http://localhost:8080/isSindico';
    var response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "id_usuario": usuario.id.toString(),
          "id_condominio": condominio.id.toString()
        }));
    print(response.body);
    if (response.body == "true") {
      usuario.setSindico(true);
    } else {
      usuario.setSindico(false);
    }
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

  void _goToCadastroCondominio() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(
              body: CadastroCondominio(),
              menuIcon: false
          )),
    );
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
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
            child: ElevatedButton(
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    'Acessar Novo Condomínio',
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              onPressed: _gotToAcessoCondominio,
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 75,
            child: FutureBuilder<List<Condominio>>(
                future: getAllCondominio(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.location_city),
                          title: Text('${snapshot.data?[index].nome}'),
                          trailing: TextButton(
                              onPressed: () =>
                                  _goToBackboard(snapshot.data![index]),
                              child: Text('Visualizar')),
                        );
                      });
                }),
          ),
        ]),
      ),
    );
  }
}