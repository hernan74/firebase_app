import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingCincoEstrellasWidget extends StatelessWidget {
  final Stream<double> ratingStream;
  final Function(double) ratingSink;
  final int cantidadItem;
  final double itemSize;
  RatingCincoEstrellasWidget(
      {@required this.ratingStream,
      this.ratingSink,
      this.cantidadItem = 5,
      this.itemSize = 40});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ratingStream,
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: snapshot.hasData ? snapshot.data : 0,
                itemCount: cantidadItem,
                allowHalfRating: true,
                itemSize: itemSize,
                minRating: 0.5,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Icon(
                        Icons.star,
                        color: Colors.red,
                      );
                    case 1:
                      return Icon(
                        Icons.star,
                        color: Colors.redAccent,
                      );
                    case 2:
                      return Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    case 3:
                      return Icon(
                        Icons.star,
                        color: Colors.lightGreen,
                      );
                    default:
                      return Icon(
                        Icons.star,
                        color: Colors.green,
                      );
                  }
                },
                onRatingUpdate: ratingSink,
              ),
              Text(
                '${snapshot.hasData ? snapshot.data : ''} ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          );
        });
  }
}
