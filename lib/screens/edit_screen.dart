import 'package:alarmapp/service/file_operations.dart';
import 'package:alarmapp/widgets/grid_image.dart';
import 'package:alarmapp/widgets/selectable_item.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'image_page.dart';
import 'trash_screen.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var controller = DragSelectGridViewController();
  //Firestore cloudDB;
  List<dynamic> imgList;
  List selectedList = [];
  FileOperations fileOperations = FileOperations.getInstance();
  //UserDB userDB;
  //User user;
  int imgListLength = 0;
  List<Asset> images = List<Asset>();
  String errorState = 'No Error Dectected';
  bool isSelected = false;

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
  getDatas() async {
    user = await userDB.getUserInfo();
    getImagesLocal();
  }
  */

  void scheduleRebuild() => setState(() {});

  @override
  void initState() {
    super.initState();
    //cloudDB = Firestore.instance;
    //userDB = UserDB.getInstance();
    //getDatas();
    getImagesLocal();
    controller.addListener(scheduleRebuild);
  }

/*
  @override
  void dispose() {
    //controller.removeListener(scheduleRebuild);
    super.dispose();
  }
  */

  @override
  Widget build(BuildContext context) {
    return
        /*
     WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => GenelScreen()));
        return;
      },
      child: 
      */
        Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: isSelected
          ? AppBar(
              key: const Key('selecting'),
              titleSpacing: 0,
              leading: IconButton(
                icon: Icon(Icons.close),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    isSelected = false;
                  });
                },
              ),
              backgroundColor: Colors.white,
              title: Text(
                '${controller.selection.amount} öğe seçildi',
                style: TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.restore,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    if (selectedList.length == 0) {
                      BotToast.showText(text: "Seçilmiş Fotoğraf Yok");
                    } else {
                      BotToast.showLoading();
                      await fileOperations.restoreImage(selectedList);
                      await getImagesLocal();
                      controller.selection = Selection.empty;
                      selectedList.clear();
                      BotToast.closeAllLoading();
                      BotToast.showText(text: "Fotoğraflar Geri Yüklendi");
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    if (selectedList.length == 0) {
                      BotToast.showText(text: "Seçilmiş Fotoğraf Yok");
                    } else {
                      BotToast.showLoading();
                      await fileOperations.moveToTrash(selectedList);
                      await fileOperations.getTrashImages();
                      await getImagesLocal();
                      controller.selection = Selection.empty;
                      selectedList.clear();
                      BotToast.closeAllLoading();
                    }
                  },
                ),
              ],
            )
          : AppBar(
              key: const Key('not-selecting'),
              titleSpacing: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  /*
                    setState(() {
                      isSelected = false;
                    });*/
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
              title: Text(
                "Fotoğraflar",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.restore_from_trash,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrashScreen()));
                    }),
              ],
            ),
      floatingActionButton: FloatingActionButton(
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
              Expanded(
                child: imgList != null
                    ? imgListLength != 0
                        ? DragSelectGridView(
                            gridController: controller,
                            //padding: const EdgeInsets.all(8),
                            itemCount: imgList.length,
                            itemBuilder: (context, index, selected) {
                              if (selected) {
                                if (!selectedList
                                    .contains(imgList[index].imageName)) {
                                  selectedList.add(imgList[index].imageName);
                                }
                              } else {
                                try {
                                  selectedList.remove(imgList[index].imageName);
                                } catch (e) {}
                              }
                              if (selectedList.length == 0) {
                                //isSelected = false;
                              }
                              return isSelected
                                  ? SelectableItem(
                                      index: index,
                                      selected: selected,
                                      image: imgList[index],
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ImagePage(imgList[index]),
                                          ),
                                        ).then((value) {
                                          if (value != null) {
                                            setState(() {
                                              imgList = value;
                                            });
                                          }
                                        });
                                      },
                                      onLongPress: () {
                                        setState(() {
                                          isSelected = true;
                                        });
                                      },
                                      child: GridImage(imgList[index], false),
                                    );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                            ),
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
