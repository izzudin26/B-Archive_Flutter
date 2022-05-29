import 'package:b_archive/components/snackbarMessage.dart';
import 'package:b_archive/model/blockdata.dart';
import 'package:flutter/material.dart';
import 'package:b_archive/style/style.dart' as style;
import 'package:lottie/lottie.dart';
import 'package:b_archive/service/webservice.dart' as _webservice;
import 'package:b_archive/components/cardTransaction.dart';

class Archive extends StatefulWidget {
  Archive({Key? key}) : super(key: key);

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  bool isLoading = true;
  List<Blockdata> blocks = [];

  @override
  void initState() {
    super.initState();
    fetchBlockdata();
  }

  void fetchBlockdata() async {
    try {
      List<Blockdata> blockdata = await _webservice.getBlockdata();
      print(blockdata.length);
      setState(() {
        blocks = blockdata;
        isLoading = false;
      });
    } catch (e) {
      showSnackbar(context, "$e");
    }
  }

  Widget _Header() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Daftar Arsip", style: style.headerTransaction(context)),
          Text(
            "Transaksi Kamu",
            style: style.headerTransaction(context),
          )
        ],
      ),
    );
  }

  List<Widget> items() => blocks
      .map((e) => CardTransaction(
            metadata: e.metadata,
            hash: e.hash,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        child: isLoading
            ? Center(child: Lottie.asset("assets/loading-files.json"))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Header(),
                    Column(
                      children: items(),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
