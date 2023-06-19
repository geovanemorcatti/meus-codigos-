import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:nossosindico_app/modules/SizeConfig.dart';
import 'package:nossosindico_app/modules/FieldValidator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../modules/MenuPage.dart';
import '../screens/Layout.dart';
import 'Schedule.dart';

class ScheduleRegister extends StatefulWidget {
  const ScheduleRegister();
  @override
  State<ScheduleRegister> createState() => _ScheduleRegisterState();
}

class _ScheduleRegisterState extends State<ScheduleRegister> {
  final _formKey = GlobalKey<FormState>();

  final format = DateFormat("yyyy-MM-dd");

  final TextEditingController _controladorNome = TextEditingController(),
      _controladorData = TextEditingController();


  void onPressed(String data, String nome) async {
    if (_formKey.currentState!.validate()) {
      var Url = 'http://localhost:8080/createReserva';
      var response = await http.post(Uri.parse(Url),
          headers: <String, String>{"Content-Type": "application/json"},
          body: jsonEncode(<String, String>{
            "data": data,
            "descricao": nome,
          }));
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200) {
        _goToSchedule();
      }
    }
  }

  void _goToSchedule() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(
            title: "Quadro de Avisos",
            body: Schedule(),
            menuPage: MenuPage.Schedule,
            register: true,
          )),
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
          width: SizeConfig.safeBlockHorizontal! * 85 < SizeConfig.screenWidth!
              ? SizeConfig.safeBlockHorizontal! * 85
              : SizeConfig.screenWidth!,
          child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(children: <Widget>[
                    Text('Insira a data (${format.pattern})', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    DateTimeField(
                      controller: _controladorData,
                      format: format,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                  ])
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller: _controladorNome,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: 'Nome',
                      hintText: 'Nome do Item',
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.blueGrey[100])),
                  keyboardType: TextInputType.name,
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
                            fontSize: 20.0, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onPressed: () => { onPressed(_controladorData.text, _controladorNome.text)},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}