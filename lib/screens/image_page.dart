import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';
import 'package:alarmapp/service/file_operations.dart';

class ImagePage extends StatefulWidget {
  final image;
  ImagePage(this.image);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  List imageNameSplit;
  String imageName;
  FileOperations fileOperations;
  @override
  void initState() {
    super.initState();
    imageNameSplit = widget.image.imageName.split('/');
    imageName = imageNameSplit[imageNameSplit.length - 1];
    fileOperations = FileOperations.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          imageName,
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.restore), title: Text("Geri Yükle")),
          BottomNavigationBarItem(icon: Icon(Icons.delete), title: Text("Sil")),
        ],
        elevation: 10.0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (index) async {
          if (index == 0) {
            print("Restore");
            BotToast.showLoading();
            var imageList =
                await fileOperations.restoreImage([widget.image.imageName]);
            BotToast.closeAllLoading();
            Navigator.pop(context, imageList);
          } else if (index == 1) {
            print("Delete");
            BotToast.showLoading();
            await fileOperations.moveToTrash([widget.image.imageName]);
            var imageList = await fileOperations.getImagesLocal();
            BotToast.closeAllLoading();
            Navigator.pop(context, imageList);
          }
        },
      ),
      body: Center(
        child: Container(
          child: GestureZoomBox(
            maxScale: 5.0,
            doubleTapScale: 2.0,
            duration: Duration(milliseconds: 100),
            child: Image.memory(
              widget.image.imageData,
            ),
          ),
        ),
      ),
    );
  }
}
