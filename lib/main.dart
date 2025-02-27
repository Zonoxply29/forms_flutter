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
      home: ProductSearchForm(),
    );
  }
}

class ProductSearchForm extends StatefulWidget {
  @override
  _ProductSearchFormState createState() => _ProductSearchFormState();
}

class _ProductSearchFormState extends State<ProductSearchForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  String _selectedCategory = 'Electrónica';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String productName = _productNameController.text;
      String category = _selectedCategory;

      print("Producto a buscar: $productName");
      print("Categoría: $category");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Búsqueda enviada con éxito')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Búsqueda de Productos')),
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
                        Text('Nombre del Producto',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: _productNameController,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          validator: (value) => value!.isEmpty
                              ? 'Ingrese el nombre del producto'
                              : null,
                        ),
                        SizedBox(height: 10),
                        Text('Categoría',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          items: ['Electrónica', 'Ropa', 'Hogar']
                              .map((category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
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
                          child: Text('Buscar'),
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
