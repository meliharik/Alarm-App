import 'package:alarmapp/models/image_model.dart';
import 'package:flutter/material.dart';

class GridImage extends StatelessWidget {
  final ImageModel image;
  final bool isSelected;
  GridImage(this.image, this.isSelected);
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
