import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nossosindico_app/modules/Condominio.dart';
import 'package:nossosindico_app/modules/SizeConfig.dart';
import 'package:nossosindico_app/components/UserRegister.dart';
import 'package:nossosindico_app/screens/Layout.dart';
import 'package:nossosindico_app/modules/FieldValidator.dart';
import 'package:nossosindico_app/modules/Usuario.dart';
import 'package:nossosindico_app/screens/cadastroCondominio.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nossosindico_app/screens/painelSindico.dart';

import '../components/listCondominium.dart';
import '../modules/MenuPage.dart';

Usuario usuario = Usuario("Cringe", "Poggers", "Lacrou", "Nelson");
Condominio condominio = Condominio("0", "1", "2", "3", 4, "5", "6");

class Login extends StatefulWidget {
  const Login();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controladorEmail = TextEditingController(),
      _controladorSenha = TextEditingController();

  void _signIn() async {
    final prefs = await SharedPreferences.getInstance();
    var response;
    var Url = 'http://localhost:8080/login';
    response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "email": _controladorEmail.text,
          "senha": _controladorSenha.text
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      usuario = Usuario.fromJson(json.decode(response.body));
      prefs.setString("email", _controladorEmail.text);
      prefs.setString("senha", _controladorSenha.text);
      _goToListCondominio();
    } else {
      print('Errou a senha animal');
    }
  }

  void _goToListCondominio() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(
                body: listCondominium(),
                menuPage: MenuPage.Condominium,
            menuIcon: false
              )),
    );
  }

  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(
                body: UserRegister(),
                menuPage: MenuPage.Backboard,
                menuIcon: false,
              )),
    );
  }

  void _goToPainelSind() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(
                body: PainelSindico(),
                menuPage: MenuPage.None,
                menuIcon: false,
              )),
    );
  }

  void _goToCadastroCondominio() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(
                body: CadastroCondominio(),
                menuPage: MenuPage.None,
                menuIcon: false,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Future<Usuario>? post = fetchPost();
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.green[500],
      body: Align(
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            width: SizeConfig.safeBlockHorizontal! * 85 < 400
                ? SizeConfig.safeBlockHorizontal! * 85
                : 400,
            height: SizeConfig.blockSizeVertical! * 60,
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: TextFormField(
                    controller: _controladorEmail,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.email),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'E-mail',
                        hintText: 'usuario@mail.com',
                        hintStyle: TextStyle(color: Colors.blueGrey[100])),
                    keyboardType: TextInputType.emailAddress,
                    validator: FieldValidator.ValidarEmail,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: TextFormField(
                    obscureText: true,
                    controller: _controladorSenha,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.key),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Senha',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: FieldValidator.ValidarSenha,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 8, 0, 8),
                  child: ElevatedButton(
                      child: const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            'Sign-in',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onPressed: _signIn
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: TextButton(
                    child: const Text(
                      'Não possui conta? Cadastre-se aqui',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    ),
                    onPressed: _goToRegister,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Usuario>? fetchPost() async {
    final prefs = await SharedPreferences.getInstance();
    _controladorEmail.text = prefs.getString("email")!;
    _controladorSenha.text = prefs.getString("senha")!;
    return usuario;
  }
}
