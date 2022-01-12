import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('LOGIN'),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Center(
                child: loginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 120.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Ingrese su nombre de usuario',
                  labelText: 'username',
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == 'aa_proy_admin') {
                  } else {
                    return 'Usuario Erroneo';
                  }
                },
              ),
              TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Favor de ingresar su contraseña',
                    labelText: 'password',
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  validator: (value) {
                    if (value == 'alfaro') {
                    } else {
                      return 'Contraseña incorrecta';
                    }
                  }),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      child: Container(
                          child: Text('Enviar'),
                          color: Colors.cyan,
                          width: 40.0,
                          height: 20.0),
                      onTap: () {
                        bool validado = _formKey.currentState!.validate();
                        if (validado == true) {
                          Navigator.popAndPushNamed(context, 'home');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
