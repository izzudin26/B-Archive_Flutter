import 'package:flutter/material.dart';
import 'package:b_archive/screen/mainmenu.dart';
import 'package:b_archive/style/style.dart' as style;

class ContainerMenu extends StatelessWidget {

  MenuItem menuItem;
  ContainerMenu({Key? key, required this.menuItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: TextButton(
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith((states) => BorderSide(
            color: menuItem.color,
           width: 1
          )),
          shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )),
          backgroundColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.pressed) ? menuItem.color.withOpacity(0.2) : Colors.white)
        ),
        onPressed: (){
          if(menuItem.classWidget != null){
            Navigator.push(context, MaterialPageRoute(builder: (context) => menuItem.classWidget!));
          }
        },
        child: Container(
          padding: EdgeInsets.all(3),
          child: Row(children: [
            menuItem.getColoredIcon(),
            SizedBox(width: 10),
            Text(menuItem.label, style: style.textMenuStyle(context, menuItem.color))
          ]),
        ),
      ),
    );
  }
}