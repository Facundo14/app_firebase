import 'package:app_firebase/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;

class AnimacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CuadradoAnimado(),
      ),
    );
  }
}

class CuadradoAnimado extends StatefulWidget {
  @override
  _CuadradoAnimadoState createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> rotacion;
  late Animation<double> opacidad;
  late Animation<double> opacidadOut;
  late Animation<double> moverDerecha;
  late Animation<double> moverIzquierda;
  late Animation<double> agrandar;

  @override
  void initState() {
    controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );

    rotacion = Tween(begin: 0.0, end: 2 * Math.pi).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    opacidad = Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0, 0.25, curve: Curves.bounceIn),
    ));
    opacidadOut = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.75, 1.0, curve: Curves.easeOut),
    ));

    moverDerecha = Tween(begin: 0.0, end: 100.0).animate(controller);
    moverIzquierda = Tween(begin: 0.0, end: -100.0).animate(controller);

    agrandar = Tween(begin: 0.0, end: 2.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0, 0.25, curve: Curves.easeOut),
    ));

    controller.addListener(() {
      print("Status: " + controller.status.toString());

      if (controller.status == AnimationStatus.completed) {
        controller.reverse();
      }
      //else if (controller.status == AnimationStatus.dismissed) {
      //   controller.forward();
      // }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Play /Reproduccion
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      child: _Rectangulo(),
      builder: (BuildContext context, Widget? childRectangulo) {
        print('Opacidad: ${opacidad.status}');
        print('Mover Derecha: ${moverDerecha.status}');
        return Transform.scale(
          scale: agrandar.value,
          child: Transform.translate(
            offset: Offset(moverIzquierda.value, 0),
            child: Opacity(
              opacity: opacidad.value - opacidadOut.value,
              child: childRectangulo,
            ),
          ),
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(color: Color(int.parse(DataProvider.color))),
      ),
    );
  }
}
