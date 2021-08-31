import 'dart:math' as Math;

import 'package:app_firebase/provider/data_provider.dart';
import 'package:flutter/material.dart';

class PentagonoAnimadoPage extends StatelessWidget {
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

    agrandar = Tween(begin: 0.0, end: 2.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0, 0.25, curve: Curves.easeOut),
    ));

    controller.addListener(() {
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
      child: Pentagono(),
      builder: (BuildContext context, Widget? childRectangulo) {
        return Transform.rotate(
          angle: rotacion.value,
          child: Transform.scale(
            scale: agrandar.value,
            child: childRectangulo,
          ),
        );
      },
    );
  }
}

class Pentagono extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: DataProvider.randomNumber(),
          width: DataProvider.randomNumber(),
          color: Colors.transparent,
          child: CustomPaint(
            painter: _PentagonoPainter(),
          ),
        ),
      ),
    );
  }
}

class _PentagonoPainter extends CustomPainter {
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
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width * 0.75, size.height);
    path.lineTo(size.width * 0.25, size.height);
    path.lineTo(0, size.height * 0.5);

    //path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => throw true;
}
