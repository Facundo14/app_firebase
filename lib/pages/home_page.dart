import 'package:app_firebase/data/bd_servicio.dart';
import 'package:app_firebase/models/models.dart';
import 'package:app_firebase/provider/data_provider.dart';
import 'package:app_firebase/ui/input_decorations.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final _formKeyCreate = GlobalKey<FormState>();
  final db = new Dbase();
  @override
  Widget build(BuildContext context) {
    DataProvider.obtienerColoresProvider();
    DataProvider.obtienerFormasProvider();
    return Scaffold(
      appBar: AppBar(
        title: Text('Formas'),
        centerTitle: true,
      ),
      body: Rectangulo(formKey: this._formKeyCreate),
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
              if (_formKeyCreate.currentState!.validate()) {
                final combinar = new CombinarModel(
                    color: DataProvider.color,
                    forma: DataProvider.forma,
                    descripcion: DataProvider.descripcion,
                    idFirebase: DataProvider.idFirebase);
                db.agregaCombinacion(combinar);
                Navigator.pushNamed(context, 'demostracion');
              }
            },
          )
        ],
      ),
    );
  }
}

class Rectangulo extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const Rectangulo({required this.formKey});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          child: Form(
              key: formKey,
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ColorModel>>(
        stream: DataProvider.streamColorController,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: DropdownButtonFormField<String>(
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Colores',
                labelText: 'Colores',
                prefixIcon: Icons.palette,
              ),
              items: snapshot.data!.map<DropdownMenuItem<String>>((ColorModel value) {
                return DropdownMenuItem(
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Icon(Icons.colorize),
                      Text(value.descripcion),
                      SizedBox(width: 20),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color(int.parse(value.color))),
                      )
                    ],
                  ),
                  value: value.descripcion,
                  onTap: () {
                    DataProvider.color = value.color;
                    print(DataProvider.color);
                  },
                );
              }).toList(),
              onChanged: (_) {},
            ),
          );
        });
  }
}

class _ComboForma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FormaModel>>(
        stream: DataProvider.streamFormaController,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: DropdownButtonFormField<String>(
              
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Formas',
                labelText: 'Formas',
                prefixIcon: Icons.dashboard,
              ),
              items: snapshot.data!.map<DropdownMenuItem<String>>((FormaModel value) {
                return DropdownMenuItem(
                  child: Text(value.descripcion),
                  value: value.descripcion,
                  onTap: () {
                    DataProvider.forma = value.descripcion;
                    print(DataProvider.forma);
                  },
                );
              }).toList(),
              onChanged: (_) {},
            ),
          );
        });
  }
}

class _DescripcionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _descripcionController = new TextEditingController();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: _descripcionController,
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
