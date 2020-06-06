import 'package:alarmapp/models/image_model.dart';
import 'package:alarmapp/widgets/trash_grid.dart';
import 'package:flutter/material.dart';

class TrashSelectable extends StatefulWidget {
  const TrashSelectable({
    Key key,
    @required this.index,
    @required this.selected,
    @required this.image,
    this.imgDate,
  }) : super(key: key);

  final int index;
  final bool selected;
  final ImageModel image;
  final DateTime imgDate;

  @override
  _TrashSelectableState createState() => _TrashSelectableState();
}

class _TrashSelectableState extends State<TrashSelectable>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      value: widget.selected ? 1 : 0,
      duration: kThemeChangeDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void didUpdateWidget(TrashSelectable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      if (widget.selected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: DecoratedBox(
              child: child,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        },
        child: TrashGrid(
            ImageModel(widget.image.imageName, widget.image.imageData),
            widget.selected,
            widget.imgDate));
  }
}
