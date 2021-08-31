import 'package:app_firebase/provider/data_provider.dart';
import 'dart:math' as Math;
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class TrianguloAnimadoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _TrianguloAnimado(),
      ),
    );
  }
}

class _TrianguloAnimado extends StatefulWidget {
  @override
  _TrianguloAnimadoState createState() => _TrianguloAnimadoState();
}

class _TrianguloAnimadoState extends State<_TrianguloAnimado> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> rotacion;
  late Animation<double> opacidad;
  late Animation<double> opacidadOut;
  late Animation<double> moverDerecha;
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
      child: _Triangulo(),
      builder: (BuildContext context, Widget? childRectangulo) {
        print('Opacidad: ${opacidad.status}');
        print('Mover Derecha: ${moverDerecha.status}');
        return Transform.scale(
          scale: agrandar.value,
          child: Transform.rotate(
            angle: rotacion.value,
            child: childRectangulo,
          ),
        );
      },
    );
  }
}

class _Triangulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150,
        height: 150,
        child: CustomPaint(
          painter: _TrianguloPainter(),
        ),
      ),
    );
  }
}

class _TrianguloPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();

    //Propiedades
    paint.color = Color(int.parse(DataProvider.color));
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = new Path();

    //Dibujar con el path y el lapiz
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    //path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw true;
  }
}
