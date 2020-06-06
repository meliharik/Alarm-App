import 'package:flutter/material.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';

class SelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SelectionAppBar(
      {Key key,
      this.title,
      this.selection = Selection.empty /*, this.imageList*/})
      : assert(selection != null),
        super(key: key);

  //final imageList;
  final Widget title;
  final Selection selection;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: selection.isSelecting
          ? AppBar(
              key: const Key('selecting'),
              titleSpacing: 0,
              leading: const CloseButton(
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              title: Text(
                '${selection.amount} öğe seçildi',
                style: TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.restore,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    /*
                    print(imageList);
                    BotToast.showLoading();
                    fileOperations.deleteImageList(imageList);
                    BotToast.closeAllLoading();
                    */
                  },
                ),
              ],
            )
          : AppBar(
              key: const Key('not-selecting'),
              titleSpacing: 0,
              leading: Icon(
                Icons.photo,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              title: Text(
                "Fotoğraf Seç",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              //centerTitle: true,
            ),
    );
  }
}
