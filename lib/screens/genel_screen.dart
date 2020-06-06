import 'package:alarmapp/screens/edit_screen.dart';
import 'package:alarmapp/screens/image_page.dart';
import 'package:alarmapp/screens/trash_screen.dart';
import 'package:alarmapp/service/file_operations.dart';
import 'package:alarmapp/widgets/grid_image.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class GenelScreen extends StatefulWidget {
  @override
  _GenelScreenState createState() => _GenelScreenState();
}

class _GenelScreenState extends State<GenelScreen> {
  List<Asset> images = List<Asset>();
  String errorState = 'No Error Dectected';
  //Firestore cloudDB;
  List<dynamic> imgList;
  List<dynamic> imgNames;
  //Service _services;
  FileOperations fileOperations = FileOperations.getInstance();
  //UserDB userDB;
  //User user;
  int imgListLength = 0;

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: false,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Tüm Klasörler",
          allViewTitle: "Tüm Fotoğraflar",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      errorState = error;
    });
    saveImage();
  }

  saveImage() async {
    BotToast.showLoading();
    await fileOperations.saveImage(images);
    await getImagesLocal();
    images.clear();
    BotToast.closeAllLoading();
  }

  deleteAllImages() async {
    BotToast.showLoading();
    bool isDeleted = await fileOperations.deleteAllImages();
    if (isDeleted) {
      setState(() {
        imgList.clear();
        imgListLength = 0;
      });
      BotToast.closeAllLoading();
    } else {
      BotToast.closeAllLoading();
      BotToast.showText(text: "Bir Hata Oluştu");
    }
  }

  getImagesLocal() async {
    var tempList = await fileOperations.getImagesLocal();
    setState(() {
      imgListLength = tempList.length;
      imgList = tempList;
    });
  }

/*
  getServerImages() async {
    var imageNames = await _services.getImageNames();
    var tempList = await _services.getAllImages();
    setState(() {
      imgListLength = tempList.length;
      imgList = tempList;
      imgNames = imageNames;
    });
  }

  getDatas() async {
    user = await userDB.getUserInfo();
    getImagesLocal();
  }

  uploadServerPhotos() async {
    await showDialog(
        context: context,
        builder: (context) {
          return Uploader(user.uid, images);
        });
    images.clear();
    await getServerImages();
  }
*/
  void scheduleRebuild() => setState(() {});

  @override
  void initState() {
    super.initState();
    //_services = Service.getInstance();
    //cloudDB = Firestore.instance;
    //userDB = UserDB.getInstance();
    //getDatas();
    getImagesLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        //key: const Key('not-selecting'),
        titleSpacing: 0,
        leading: Icon(
          Icons.photo,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Fotoğraflar",
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        //centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => EditScreen()));
              }),
          IconButton(
              icon: Icon(
                Icons.restore_from_trash,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TrashScreen()));
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "0",
        elevation: 10,
        child: Container(
          child: Icon(Icons.add),
        ),
        onPressed: loadAssets,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              /*
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * (9 / 10),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (0.6 / 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Genel',
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.more_horiz,
                            size: 50,
                            color: mainColor,
                          ),
                        )
                      ],
                    ),
                  ]),
                ),
              ),
              */
              Expanded(
                child: imgList != null
                    ? imgListLength != 0
                        ? GridView.builder(
                            itemCount: imgList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ImagePage(imgList[index])));
                                },
                                child: GridImage(imgList[index], false),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "Fotoğraf Bulunamadı",
                              style: TextStyle(fontSize: 24),
                            ),
                          )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
