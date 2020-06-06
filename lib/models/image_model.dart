import 'dart:typed_data';

class ImageModel {
  final String imageName;
  Uint8List imageData;
  ImageModel(this.imageName, this.imageData);
}
