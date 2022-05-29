import 'package:b_archive/screen/formTransactionView.dart';
import 'package:flutter/material.dart';
import 'package:b_archive/model/blockdata.dart';
import 'package:b_archive/style/style.dart' as style;

class CardTransaction extends StatelessWidget {
  String hash;
  Metadata metadata;
  CardTransaction({Key? key, required this.metadata, required this.hash})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FormTransactionView(
                      metadata: metadata,
                      hash: hash,
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primary),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  metadata.transactionType.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                )
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(metadata.receiverName,
                        style: style.subtitleCardTransaction()),
                    Text(metadata.receiverNumber,
                        style: style.subtitleCardTransaction()),
                    Text(metadata.referenceNumber,
                        style: style.subtitleCardTransaction()),
                    Text(metadata.transactionDate,
                        style: style.subtitleCardTransaction())
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
