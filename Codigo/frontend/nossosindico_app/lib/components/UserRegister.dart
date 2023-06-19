import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nossosindico_app/modules/SizeConfig.dart';
import 'package:nossosindico_app/modules/Usuario.dart';
import 'package:nossosindico_app/modules/FieldValidator.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../screens/Layout.dart';
import '../screens/Login.dart';

class UserRegister extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const UserRegister();
  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controladorNome = TextEditingController(),
      _controladorSobrenome = TextEditingController(),
      _controladorEmail = TextEditingController(),
      _controladorSenha = TextEditingController(),
      _controladorConfirmarSenha = TextEditingController();


  void fetchPost(String usuarioNome, String usuarioSobrenome, String usuarioEmail, String usuarioSenha) async {
    var Url = 'http://localhost:8080/cadastro';
    var response = await http.post(Uri.parse(Url), headers: <String, String>{"Content-Type":"application/json"}, body: jsonEncode(<String, String>{
      "nome":usuarioNome, "sobrenome":usuarioSobrenome, "email":usuarioEmail, "senha":usuarioSenha
    }));
    print(response.statusCode);
    _goToLogin();
  }


  void onPressed() {
    if (_formKey.currentState!.validate()) {
      if (_controladorSenha.text == _controladorConfirmarSenha.text) {
        Usuario usuario = Usuario(_controladorNome.text,
            _controladorSobrenome.text,
            _controladorEmail.text,
            _controladorSenha.text);
        fetchPost(usuario.nome, usuario.sobrenome, usuario.email, usuario.senha);
        /*Scaffold.of(context).showSnackBar(SnackBar(
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(Usuario(
                    _controladorNome.text,
                    _controladorSobrenome.text,
                    _controladorEmail.text,
                    _controladorSenha.text).toString())));*/
      } else {
        // ignore: deprecated_member_use
        print('Os campos senha e confirmar senha devem ser identicas');
      }
    }
  }

  void _goToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(body: Login(), menuIcon: false, accontIcon: false,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      key: _formKey,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          width: SizeConfig.safeBlockHorizontal! * 85 < 400
              ? SizeConfig.safeBlockHorizontal! * 85
              : 400,
          //height: SizeConfig.blockSizeVertical! * 50,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 50),
                child: Text(
                  'Cadastre-se',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller: _controladorNome,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Nome',
                      hintText: 'Nome de Usuários',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                  keyboardType: TextInputType.name,
                  validator: FieldValidator.ValidarNome,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller: _controladorSobrenome,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Sobrenome',
                      hintText: 'Nome de Usuários',
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                  keyboardType: TextInputType.name,
                  validator: FieldValidator.ValidarNome,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller: _controladorEmail,
                  decoration: InputDecoration(
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
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Senha',
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  validator: FieldValidator.ValidarSenha,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  obscureText: true,
                  controller: _controladorConfirmarSenha,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Confirmar Senha',
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  validator: FieldValidator.ValidarSenha,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: ElevatedButton(
                  child: const Align(
                    alignment: Alignment.center,
                    child: Padding(padding:EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                        'Sign-up',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OpenDatabase(String path, {required int version,required OnDatabaseConfigureFn onConfigure, required OnDatabaseCreateFn onCreate,
    required OnDatabaseVersionChangeFn onUpgrade, required OnDatabaseVersionChangeFn onDowngrade, required OnDatabaseOpenFn onOpen, bool readOnly = false, bool singleInstance = true  }) {}
}
