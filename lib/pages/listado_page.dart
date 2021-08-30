import 'package:flutter/material.dart';
import 'package:app_firebase/models/combinar_model.dart';
import 'package:app_firebase/provider/data_provider.dart';

class ListadoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: DataProvider.streamCombinaController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final List<CombinarModel> lista = snapshot.data;
          return ListView.separated(
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemCount: lista.length,
              itemBuilder: (_, int index) {
                return Column(
                  children: [
                    Container(
                      child: Text(lista[index].color),
                    ),
                    Container(
                      child: Text(lista[index].forma),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
