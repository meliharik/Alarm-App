import 'package:alarmapp/service/file_operations.dart';
import 'package:alarmapp/widgets/trash_selectable.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';

class TrashScreen extends StatefulWidget {
  @override
  _TrashScreenState createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  var controller = DragSelectGridViewController();
  List<dynamic> imgList;
  List<dynamic> imgNames;
  List selectedList = [];
  FileOperations fileOperations = FileOperations.getInstance();
  int imgListLength = 0;
  var dates;

  getTrashImages() async {
    var tempList = await fileOperations.getTrashImages();
    dates = await fileOperations.getTrashImageDates();
    setState(() {
      imgListLength = tempList.length;
      imgList = tempList;
    });
  }

  void scheduleRebuild() => setState(() {});

  @override
  void initState() {
    super.initState();
    getTrashImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Geri Dönüşüm Kutusu",
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.black, fontSize: 25),
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
                  var tempList = await fileOperations.getTrashImages();
                  selectedList.clear();
                  BotToast.closeAllLoading();
                  setState(() {
                    imgList = tempList;
                    imgListLength = imgList.length;
                  });
                }
              }),
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
                  await fileOperations.deleteImageList(selectedList);
                  var tempList = await fileOperations.getTrashImages();
                  selectedList.clear();
                  BotToast.closeAllLoading();
                  setState(() {
                    imgList = tempList;
                    imgListLength = imgList.length;
                  });
                }
              }),
        ],
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
                              return TrashSelectable(
                                index: index,
                                selected: selected,
                                image: imgList[index],
                                imgDate: dates[index],
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5),
                          )
                        /*
                        GridView.builder(
                            itemCount: imgList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5),
                            itemBuilder: (BuildContext context, int index) {
                              return GridImage(imgList[index], false);
                            },
                          )
                        
                          */
                        : Center(
                            child: Text(
                              "Çöp Kutusunda Fotoğraf Bulunamadı",
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
