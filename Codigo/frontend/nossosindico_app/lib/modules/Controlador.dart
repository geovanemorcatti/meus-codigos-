import 'package:nossosindico_app/modules/User.dart';

import 'package:nossosindico_app/modules/Usuario.dart';
import 'package:nossosindico_app/modules/Condominio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Controlador {
  static int idUsuario = 0;
  static int idCondominio = 0;
  static bool isSindico = false;

  static Desconnect() {
    idUsuario = 0;
    idCondominio = 0;
    isSindico = false;
  }

  //Recupera Dados do usuario conectado
  static Future<Usuario> getAcount() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users/2'));

    if (response.statusCode == 200) {
      //return Usuario.fromJson(json.decode(response.body));
      User user = User.fromJson(json.decode(response.body));
      return Usuario(user.username.toString(), user.name.toString(),
          user.email.toString(), "");
    } else {
      throw Exception('Falha ao carregar usuario');
    }
  }

  //Cadastro de usuário
  static Future postUser(Usuario usuario) async {
    //http.post(Uri.parse('http://localhost:8080/cadastro'),
    //headers: <String, String>{"Content-Type": "application/json"},
    http
        .post(
        Uri.parse(
            'https://webhook.site/1df08f00-2059-432b-aaba-3d2acd6f7415'),
        body: usuario.toJson())
        .then((response) {
      //print(response.body);
      //back responde com o id do novo usuário
      idUsuario = 1;
    }).onError((error, stackTrace) {
      throw Exception('Falha ao cadastrar usuário');
    });
  }

  //apagar
  Future<Usuario> fetchPost(String usuarioNome, String usuarioSobrenome,
      String usuarioEmail, String usuarioSenha) async {
    var Url = 'http://localhost:8080/cadastro';
    var response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "nome": usuarioNome,
          "sobrenome": usuarioSobrenome,
          "email": usuarioEmail,
          "senha": usuarioSenha
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return Usuario.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar um post');
    }
  }
}