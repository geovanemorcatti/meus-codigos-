import 'package:flutter/material.dart';
import 'package:nossosindico_app/modules/SizeConfig.dart';
//import 'package:nossosindico_app/main.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget{
  const Login();
  State <Login> createState() => _LoginState();
}

class _LoginState extends State<Login>{
  @override
  Widget build(BuildContext context){
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.green[500],
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                //decoration: BoxDecoration(
                  //boxShadow: [
                    //BoxShadow(
                      ////color: Colors.black87,
                      //blurRadius: 10.0,
                      //offset: Offset(
                       // 5.5,
                       // 5.5,
                     // )
                    //)
                  //],
                  //color: Colors.pink,
                  //borderRadius: BorderRadius.all(Radius.circular(10))
                //),
                width: SizeConfig.safeBlockHorizontal! * 85 < 400
                  ? SizeConfig.safeBlockHorizontal! * 85
                  : 400,
                height: 500,
                //child: Padding(
                  //padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      Padding (
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'E-mail',
                            hintText: 'usuario@mail.com',
                            hintStyle: TextStyle(
                              color: Colors.blueGrey[100]
                            )
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const Padding (
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Senha',
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      Padding (
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: ElevatedButton (
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Sign-in',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal
                                ),
                                textAlign: TextAlign.center,
                                
                              ),
                            ),
                            onPressed: () => {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: TextButton(
                          child: const Text(
                            'Não possui conta? Cadastre-se aqui!',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline
                            ),
                          ),
                          onPressed: () => {},
                          ),
                      ),
                    ],
                  ),
                )
              ),
            ),
          //),
        ],
      ),
    );
  }
}