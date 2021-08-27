import 'package:app_firebase/ui/input_decorations.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formas'),
        centerTitle: true,
      ),
      body: Rectangulo(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: 'btn-1',
            child: Icon(Icons.list),
            onPressed: () {
              Navigator.pushNamed(context, 'listado');
            },
          ),
          FloatingActionButton(
            heroTag: 'btn-2',
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, 'demostracion');
            },
          )
        ],
      ),
    );
  }
}

class Rectangulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          child: Form(
              child: Column(
            children: [
              SizedBox(height: 20),
              _ComboColor(),
              SizedBox(height: 20),
              _ComboForma(),
              SizedBox(height: 20),
              _DescripcionText(),
            ],
          )),
        ),
      ),
    );
  }
}

class _ComboColor extends StatelessWidget {
  final list = ['Rojo', 'Azul', 'Verde'];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecorations.authInputDecoration(
          hintText: 'Colores',
          labelText: 'Colores',
          prefixIcon: Icons.palette,
        ),
        items: list
            .map((String label) => DropdownMenuItem(
                  child: Text(label),
                  value: label,
                ))
            .toList(),
        onChanged: (_) {},
      ),
    );
  }
}

class _ComboForma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final list = ['Cuadrado', 'Triangulo', 'Rectangulo'];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecorations.authInputDecoration(
          hintText: 'Formas',
          labelText: 'Formas',
          prefixIcon: Icons.dashboard,
        ),
        items: list
            .map((String label) => DropdownMenuItem(
                  child: Text(label),
                  value: label,
                ))
            .toList(),
        onChanged: (_) {},
      ),
    );
  }
}

class _DescripcionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        //controller: _codigoController,
        cursorColor: Theme.of(context).accentColor,
        decoration: InputDecorations.authInputDecoration(
          hintText: 'Descripción',
          labelText: 'Descripción',
          prefixIcon: Icons.list,
        ),
        validator: (value) {
          return (value != null && value.length >= 3) ? null : 'El Codigo debe de ser mayor a 3 caracteres';
        },
        // maxLength: 6,
      ),
    );
  }
}
