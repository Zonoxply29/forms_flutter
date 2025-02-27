import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
      home: SatisfactionSurveyForm(),
    );
  }
}

class SatisfactionSurveyForm extends StatefulWidget {
  @override
  _SatisfactionSurveyFormState createState() => _SatisfactionSurveyFormState();
}

class _SatisfactionSurveyFormState extends State<SatisfactionSurveyForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  double _rating = 3;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String comment = _commentController.text;

      print("Nombre: $name");
      print("Nivel de Satisfacción: $_rating estrellas");
      print("Comentario: $comment");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Encuesta enviada con éxito')),
      );

      _nameController.clear();
      _commentController.clear();
      setState(() {
        _rating = 3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Encuesta de Satisfacción')),
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
                        Text('Nivel de Satisfacción',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        RatingBar.builder(
                          initialRating: _rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        Text('Comentarios',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: _commentController,
                          maxLines: 4,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          validator: (value) =>
                              value!.isEmpty ? 'Ingrese su comentario' : null,
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
