import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'dart:ui' as ui;

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: EventRegistrationForm(),
    );
  }
}

class EventRegistrationForm extends StatefulWidget {
  @override
  _EventRegistrationFormState createState() => _EventRegistrationFormState();
}

class _EventRegistrationFormState extends State<EventRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _attendance = "Sí";

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;

      print("Nombre: $name");
      print("Email: $email");
      print("Asistirá al evento: $_attendance");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Inscripción enviada con éxito')),
      );

      _nameController.clear();
      _emailController.clear();
      setState(() {
        _attendance = "Sí";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulario de Inscripción')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Nombre',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: _nameController,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          validator: (value) =>
                              value!.isEmpty ? 'Ingrese su nombre' : null,
                        ),
                        SizedBox(height: 10),
                        Text('Email',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          validator: (value) =>
                              value!.isEmpty ? 'Ingrese su email' : null,
                        ),
                        SizedBox(height: 10),
                        Text('¿Asistirá al evento?',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: Text('Sí'),
                                value: "Sí",
                                groupValue: _attendance,
                                onChanged: (value) {
                                  setState(() {
                                    _attendance = value!;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: Text('No'),
                                value: "No",
                                groupValue: _attendance,
                                onChanged: (value) {
                                  setState(() {
                                    _attendance = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text('Inscribirse'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
