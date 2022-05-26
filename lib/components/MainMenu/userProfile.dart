import 'package:flutter/material.dart';
import 'package:b_archive/style/style.dart' as style;

class UserProfile extends StatelessWidget {
  String username;
  UserProfile({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary),
            child: Icon(Icons.person,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * 0.12),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hai, Selamat Datang",
                    style: style.profileSubtitle(context)),
                Text(
                  username,
                  style: style.profileSubtitle(context),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
