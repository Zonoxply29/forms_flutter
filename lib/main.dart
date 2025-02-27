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
      home: PreferencesSurveyForm(),
    );
  }
}

class PreferencesSurveyForm extends StatefulWidget {
  @override
  _PreferencesSurveyFormState createState() => _PreferencesSurveyFormState();
}

class _PreferencesSurveyFormState extends State<PreferencesSurveyForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _foodController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String color = _colorController.text;
      String food = _foodController.text;

      print("Color Favorito: $color");
      print("Comida Favorita: $food");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Encuesta enviada con éxito')),
      );

      _colorController.clear();
      _foodController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Encuesta de Preferencias')),
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
                        Text('Color Favorito',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: _colorController,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          validator: (value) => value!.isEmpty
                              ? 'Ingrese su color favorito'
                              : null,
                        ),
                        SizedBox(height: 10),
                        Text('Comida Favorita',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: _foodController,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          validator: (value) => value!.isEmpty
                              ? 'Ingrese su comida favorita'
                              : null,
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
                          child: Text('Enviar'),
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
