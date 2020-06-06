import 'package:alarmapp/models/image_model.dart';
import 'package:flutter/material.dart';

class TrashGrid extends StatelessWidget {
  final ImageModel image;
  final bool isSelected;
  final DateTime imgDate;
  TrashGrid(this.image, this.isSelected, this.imgDate);
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Hero(
          tag: image.imageName,
          child: Image.memory(
            image.imageData,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Text(
            (30 - DateTime.now().difference(imgDate).inDays).toString() +
                " gün",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                      // bottomLeft
                      offset: Offset(-0.5, -0.5),
                      color: Colors.black),
                  Shadow(
                      // bottomRight
                      offset: Offset(0.5, -0.5),
                      color: Colors.black),
                  Shadow(
                      // topRight
                      offset: Offset(0.5, 0.5),
                      color: Colors.black),
                  Shadow(
                      // topLeft
                      offset: Offset(-0.5, 0.5),
                      color: Colors.black),
                ]),
          ),
        ),
        isSelected
            ? Positioned(
                bottom: 10,
                right: 10,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                ),
              )
            : Text(""),
      ],
    );
  }
}
