import 'package:flutter/material.dart';

  class BottamNavyBar extends StatefulWidget {
    BottamNavyBar({Key key}) : super(key: key);
    _BottamNavyBarState createState() => _BottamNavyBarState();
  }
  
  class _BottamNavyBarState extends State<BottamNavyBar> {
    int selectedIndex = 0;
    List<NavigationItem> items = [
          NavigationItem(Icon(Icons.home),Text('Home')),
          NavigationItem(Icon(Icons.table_chart),Text('Schedule')),
          NavigationItem(Icon(Icons.chat_bubble_outline),Text('Chat')),
          NavigationItem(Icon(Icons.notifications_none),Text('Alert')),
          NavigationItem(Icon(Icons.settings),Text('Setting')),
    ];
    Widget _buildItem(NavigationItem item, bool isSelected){
      return AnimatedContainer(
        duration: Duration(milliseconds: 270),
        width: isSelected ? 135 : 50,
        height: double.maxFinite,
        padding: isSelected ? EdgeInsets.only(left:20,right: 20) : null,
        decoration: isSelected ? BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.all(Radius.circular(50))
          ) : null ,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
           Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
                IconTheme(
              data: IconThemeData(
                size: 24,
                color: isSelected ? Colors.white : Colors.black 
              ),
              child:item.icon ,
            ),
            Padding(
              padding:  const EdgeInsets.only(left: 8,right: 8),
              child: isSelected ? item.title : Container(),
            )
             ],
           )
          ],
        ),
      );
    }
    @override
    Widget build(BuildContext context) {
      return Container(
       color: Colors.grey[200],
        height: 56,
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.map((item){
          var itemIndex = items.indexOf(item);
            return GestureDetector(
              onTap: (){
                setState(() {
                 selectedIndex = itemIndex; 
                });
              },
              child: _buildItem(item, selectedIndex == itemIndex),
            );
          }).toList()
        ),
       );
    }
  }

  class NavigationItem {
    final Icon icon ;
    final Text title;
    NavigationItem(this.icon,this.title);
  }