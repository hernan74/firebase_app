import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final Stream<bool> progreso;
  final Widget child;
  CustomCircularProgressIndicator(
      {@required this.progreso, @required this.child});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: true,
        stream: progreso,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.data
              ? child
              : Container(
                  padding: EdgeInsets.all(20.0),
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.black54.withOpacity(0.4)),
                  child: CircularProgressIndicator());
        });
  }
}
