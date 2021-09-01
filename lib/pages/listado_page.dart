import 'package:flutter/material.dart';
import 'package:app_firebase/models/models.dart';
import 'package:app_firebase/provider/data_provider.dart';

class ListadoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataProvider.obtieneCombinadosProvider();
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado'),
        centerTitle: true,
        actions: [
          ElevatedButton(
            child: Icon(Icons.sync),
            onPressed: () => DataProvider.sincronizar(),
          )
        ],
      ),
      body: StreamBuilder(
        stream: DataProvider.streamCombinaController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final List<CombinarModel> lista = snapshot.data;
          return ListView.separated(
              padding: EdgeInsets.only(top: 20, right: 20),
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemCount: lista.length,
              itemBuilder: (_, int index) {
                return GestureDetector(
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Container(
                        child: Text('${lista[index].id}'),
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: 20,
                        width: 20,
                        color: Color(int.parse(lista[index].color)),
                      ),
                      SizedBox(width: 50),
                      Container(
                        child: Text('${lista[index].forma}'),
                      ),
                      Spacer(),
                      (lista[index].idFirebase != null)
                          ? Icon(Icons.cloud_off, color: Colors.black)
                          : Icon(Icons.cloud_done, color: Colors.blue)
                    ],
                  ),
                  onTap: () {
                    DataProvider.color = lista[index].color;
                    DataProvider.forma = lista[index].forma;
                    DataProvider.colorSeleccionado = lista[index].colorNombre;
                    DataProvider.formaSeleccionada = lista[index].forma;
                    Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
                  },
                );
              });
        },
      ),
    );
  }
}
