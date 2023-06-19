
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nossosindico_app/modules/NroApto.dart';
import 'package:nossosindico_app/screens/Login.dart';
import 'package:table_calendar/table_calendar.dart';
import '../modules/Area.dart';
import '../modules/Evento.dart';
import '../modules/MenuPage.dart';
import '../screens/Layout.dart';
import 'SharedArea.dart';
import 'package:http/http.dart' as http;
import 'package:nossosindico_app/screens/Layout.dart';
import 'package:intl/intl.dart';
import '../screens/Login.dart';


class Reservation extends StatefulWidget {
  Area area;
  Reservation(this.area);

  @override
  State<Reservation> createState() => _ReservationState(area);
}

class _ReservationState extends State<Reservation> {
  late Map<DateTime, List<Evento>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final formatDate = DateFormat("yyyy-MM-dd");
  Area areia = Area(2, "aaaaaaaa", "aaaaaaa", 2);
  TextEditingController _eventController = TextEditingController(),
  _controladorDescricao = TextEditingController(),
  _controladorNumeroDePessoas = TextEditingController();

  _ReservationState(Area area){
    areia = area;
  }


  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Evento> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              print(focusedDay);

            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            eventLoader: _getEventsfromDay,

            //To style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: TextFormField(
              controller: _controladorDescricao,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Descrição',
                  hintText: 'Descrição do Evento',
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.blueGrey[100])),
              keyboardType: TextInputType.name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: TextFormField(
              controller: _controladorNumeroDePessoas,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Quantidade de pessoas',
                  hintText: 'Numero de pessoas do evento',
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.blueGrey[100])),
              keyboardType: TextInputType.name,
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
              onPressed: () => { onPressed(_controladorDescricao.text, _controladorNumeroDePessoas.text, focusedDay)},
            ),
          ),
        ],
      ),
    );
  }

  onPressed(String descricao,String numeroPessoas, DateTime data) async {
    String dataCugulosa = DateFormat("yyyy-MM-dd").format(data);
    var Url = 'http://localhost:8080/getApto';
    final response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "id": usuario.id.toString(), "nome":usuario.nome, "sobrenome":usuario.sobrenome, "email":usuario.email, "senha":usuario.senha
        }));
    UsuarioComApto nroApto = UsuarioComApto.fromJson(json.decode(response.body));
    var url = 'http://localhost:8080/createReserva';
    final Response = await http.post(Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "data": dataCugulosa,
          "id_espaco": areia.id.toString(),
          "id_condominio": condominio.id.toString(),
          "numero": nroApto.nroApto.toString(),
          "numero_pessoas": numeroPessoas,
          "descricao": descricao
        }));
    print(Response.statusCode);
    print(Response.body);
    if (Response.statusCode == 200) {
      _goToCadastroCondominio(context);
    } else {
      throw Exception('DEU erro imbecil');
    }
  }

  void _goToCadastroCondominio(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const Layout(
              body: SheradArea(),
              menuPage: MenuPage.Reservation,
              menuIcon: false
          )),
    );
  }
}
