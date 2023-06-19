import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nossosindico_app/modules/SizeConfig.dart';
import 'package:nossosindico_app/modules/Usuario.dart';
import 'package:nossosindico_app/modules/FieldValidator.dart';

import 'dart:async';
import 'package:nossosindico_app/screens/Login.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/Layout.dart';


class UserAccount extends StatefulWidget {
  const UserAccount();
  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  TextEditingController _controladorNome = TextEditingController(),
      _controladorSobrenome = TextEditingController(),
      _controladorEmail = TextEditingController();
  
  Future<Usuario> fetchPost() async {
      _controladorNome.text = usuario.nome.toString();
      _controladorSobrenome.text = usuario.sobrenome.toString();
      _controladorEmail.text = usuario.email.toString();
      return usuario;
  }

  Future<void> _attUsuario(String nome, String sobrenome, String email) async {
    Usuario novoUsuario = Usuario(nome, sobrenome, email, usuario.senha);
    novoUsuario.setId(usuario.id);
    var Url = 'http://localhost:8080/att';
    var response = await http.post(Uri.parse(Url), headers: <String, String>{"Content-Type":"application/json"}, body: jsonEncode(<String, String>{
      "nome":novoUsuario.nome, "sobrenome":novoUsuario.sobrenome, "email":novoUsuario.email, "senha":novoUsuario.senha, "id": novoUsuario.id.toString()
    }));
    print(response.statusCode);
    print(response.body);
  }
  Future<void> _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    usuario.setNull();
    _goToLogin();
  }

  void _goToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(
            body: Login(),
            menuIcon: false,
          )),
    );
  }

  Future<void> _deletarUsuario() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Login())
    );
    var Url = 'http://localhost:8080/delete';
    var response = await http.post(Uri.parse(Url), headers: <String, String>{"Content-Type":"application/json"}, body: jsonEncode(<String, String>{
      "nome":usuario.nome, "sobrenome":usuario.sobrenome, "email":usuario.email, "senha":usuario.senha, "id": usuario.id.toString()
    }));
    print(response.statusCode);
    print(response.body);
    usuario.setNull();
  }

  @override
  Widget build(BuildContext context) {
    final Future<Usuario>? post = fetchPost();
    return Center(
      child: FutureBuilder<Usuario>(
        future: post,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              width: SizeConfig.safeBlockHorizontal! * 85 < 400
                  ? SizeConfig.safeBlockHorizontal! * 85
                  : 400,
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 50),
                    child: Text(
                      'Perfil',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: TextFormField(
                      readOnly: false,
                      controller: _controladorNome,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Nome',
                      ),
                      keyboardType: TextInputType.name,
                      validator: FieldValidator.ValidarNome,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: TextFormField(
                      readOnly: false,
                      controller: _controladorSobrenome,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Sobrenome',
                      ),
                      keyboardType: TextInputType.name,
                      validator: FieldValidator.ValidarNome,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: TextFormField(
                      readOnly: false,
                      controller: _controladorEmail,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.email),
                          labelText: 'E-mail',
                          hintText: 'usuario@mail.com',
                          hintStyle: TextStyle(color: Colors.blueGrey[100])),
                      keyboardType: TextInputType.emailAddress,
                      validator: FieldValidator.ValidarEmail,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 8),
                    child: ElevatedButton(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(padding:EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            'Alterar dados',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onPressed : () => { _attUsuario(_controladorNome.text, _controladorSobrenome.text, _controladorEmail.text) }
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 8),
                    child: ElevatedButton(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(padding:EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            'Remover dados',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onPressed: _deletarUsuario,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 8),
                    child: ElevatedButton(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(padding:EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            'LogOut',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onPressed: _logOut,
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
