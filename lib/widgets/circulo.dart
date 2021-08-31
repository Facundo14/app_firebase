import 'dart:math' as Math;

import 'package:app_firebase/provider/data_provider.dart';
import 'package:flutter/material.dart';

class CirculoAnimadoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _CirculoAnimado(),
      ),
    );
  }
}

class _CirculoAnimado extends StatefulWidget {
  @override
  _CirculoAnimadoState createState() => _CirculoAnimadoState();
}

class _CirculoAnimadoState extends State<_CirculoAnimado> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> rotacion;
  late Animation<double> opacidad;
  late Animation<double> opacidadOut;
  late Animation<double> moverDerecha;
  late Animation<double> moverArriba;
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
      curve: Interval(0, 0.25, curve: Curves.easeOut),
    ));
    opacidadOut = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.75, 1.0, curve: Curves.easeOut),
    ));

    moverDerecha = Tween(begin: 0.0, end: 100.0).animate(controller);
    moverArriba = Tween(begin: 0.0, end: -100.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.25, 0.5, curve: Curves.bounceOut),
      ),
    );

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
      child: Ciruculo(),
      builder: (BuildContext context, Widget? childRectangulo) {
        print('Opacidad: ${opacidad.status}');
        print('Mover Derecha: ${moverDerecha.status}');
        return Transform.translate(
          offset: Offset(moverArriba.value, 0),
          child: Transform.translate(
            offset: Offset(moverDerecha.value, 0),
            child: Transform.scale(
              scale: agrandar.value,
              child: childRectangulo,
            ),
          ),
        );
      },
    );
  }
}

class Ciruculo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 150,
          width: 150,
          color: Colors.transparent,
          child: CustomPaint(
            painter: _CirculoPainter(),
          ),
        ),
      ),
    );
  }
}

class _CirculoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();

    //Propiedades
    paint.color = Color(int.parse(DataProvider.color));
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final center = new Offset(size.width * 0.5, size.height * 0.5);
    final radio = Math.min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radio, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => throw true;
}
