import 'package:flutter/material.dart';
import 'package:nossosindico_app/modules/SizeConfig.dart';
import 'package:nossosindico_app/modules/Usuario.dart';
import 'package:nossosindico_app/modules/FieldValidator.dart';
import 'package:nossosindico_app/modules/Controlador.dart';

class UserUpdate extends StatefulWidget {
  const UserUpdate();
  @override
  State<UserUpdate> createState() => _UserUpdateState();
}

class _UserUpdateState extends State<UserUpdate> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController controladorNome = TextEditingController(),
      controladorSobrenome = TextEditingController(),
      controladorEmail = TextEditingController(),
      controladorSenha = TextEditingController();

  void onPressed() {
    if (_formKey.currentState!.validate()) {
      Usuario usuario = Usuario(controladorNome.text, controladorSobrenome.text,
          controladorEmail.text, controladorSenha.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
        child: FutureBuilder(
            future: Controlador.getAcount().then((usuario) => {
                  controladorNome.text = usuario.nome,
                  controladorSobrenome.text = usuario.sobrenome,
                  controladorEmail.text = usuario.email,
                }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
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
                              'Editar Perfil',
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
                              controller: controladorNome,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Nome',
                                  hintText: 'Nome de Usuários',
                                  hintStyle:
                                      TextStyle(color: Colors.blueGrey[100])),
                              keyboardType: TextInputType.name,
                              validator: FieldValidator.ValidarNome,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: TextFormField(
                              controller: controladorSobrenome,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Sobrenome',
                                  hintText: 'Nome de Usuários',
                                  hintStyle:
                                      TextStyle(color: Colors.blueGrey[100])),
                              keyboardType: TextInputType.name,
                              validator: FieldValidator.ValidarNome,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: TextFormField(
                              controller: controladorEmail,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'E-mail',
                                  hintText: 'usuario@mail.com',
                                  hintStyle:
                                      TextStyle(color: Colors.blueGrey[100])),
                              keyboardType: TextInputType.emailAddress,
                              validator: FieldValidator.ValidarEmail,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: TextFormField(
                              controller: controladorSenha,
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
                            child: ElevatedButton(
                              child: const Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    'Sign-up',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal),
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
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            }));
  }
}
