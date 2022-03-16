import 'package:flutter/material.dart';


class TopBar extends StatelessWidget {
  TopBar(this._barTitle,{
  this.fontSize = 35,
    this.primaryAction,this.secondaryAction
});

  String _barTitle;
  Widget? primaryAction;
  Widget? secondaryAction;
  double? fontSize;

  late double _deviceHeight;
  late double _deviceWidth;


  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI(){
    return Container(
      height: _deviceHeight * 0.10,
      width: _deviceWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(secondaryAction != null ) secondaryAction!,
          _titleBar(),
          if(primaryAction != null) primaryAction!,
        ],
      ),
    );

    }
  Widget _titleBar(){
    return  Text(_barTitle, overflow: TextOverflow.ellipsis,style: TextStyle(
      color: Colors.black,
      fontSize: fontSize,
      fontWeight: FontWeight.w700
    ),);
  }
}
