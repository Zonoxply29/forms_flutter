import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:file_picker/file_picker.dart';
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
      home: HotelReservationForm(),
    );
  }
}

class HotelReservationForm extends StatefulWidget {
  @override
  _HotelReservationFormState createState() => _HotelReservationFormState();
}

class _HotelReservationFormState extends State<HotelReservationForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _guests = 1;

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = pickedDate;
        } else {
          _checkOutDate = pickedDate;
        }
      });
    }
  }

  void _submitForm() {
    if (_checkInDate != null && _checkOutDate != null) {
      print(
          "Fecha de Entrada: ${_checkInDate!.toLocal().toString().split(' ')[0]}");
      print(
          "Fecha de Salida: ${_checkOutDate!.toLocal().toString().split(' ')[0]}");
      print("Número de Huéspedes: $_guests");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reserva realizada con éxito')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Por favor seleccione las fechas de entrada y salida')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reserva de Hotel')),
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
                        Text('Fecha de Entrada',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, true),
                          child: Text(_checkInDate == null
                              ? 'Seleccionar Fecha'
                              : _checkInDate!
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0]),
                        ),
                        SizedBox(height: 10),
                        Text('Fecha de Salida',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, false),
                          child: Text(_checkOutDate == null
                              ? 'Seleccionar Fecha'
                              : _checkOutDate!
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0]),
                        ),
                        SizedBox(height: 10),
                        Text('Número de Huéspedes',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        DropdownButtonFormField<int>(
                          value: _guests,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          items: List.generate(10, (index) => index + 1)
                              .map((num) => DropdownMenuItem(
                                    value: num,
                                    child: Text(num.toString()),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _guests = value!;
                            });
                          },
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
                          child: Text('Reservar'),
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
