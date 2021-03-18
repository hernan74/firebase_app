import 'package:fire_base_app/bloc/bloc_provider.dart';
import 'package:fire_base_app/providers/login/login_stream.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginStream loginStream = BlocProvider.of(context);
    return StreamBuilder(
        initialData: true,
        stream: loginStream.estadoLoginStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.data
              ? Container()
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
