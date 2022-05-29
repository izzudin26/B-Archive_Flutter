import 'dart:io';
import 'package:b_archive/model/blockdata.dart';
import 'package:flutter/material.dart';
import 'package:b_archive/style/style.dart' as style;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:b_archive/service/webservice.dart' as _webservice;
import 'package:b_archive/components/snackbarMessage.dart';
import 'package:b_archive/service/uri.dart';
import 'package:flutter/services.dart';

class FormTransactionView extends StatefulWidget {
  Metadata metadata;
  String hash;
  FormTransactionView({Key? key, required this.metadata, required this.hash})
      : super(key: key);

  @override
  State<FormTransactionView> createState() => _FormTransactionViewState();
}

class _FormTransactionViewState extends State<FormTransactionView> {
  late Metadata metadata = widget.metadata;

  final _formkey = GlobalKey<FormState>();

  TextEditingController receiverName = TextEditingController();
  TextEditingController receiverNumber = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController ref = TextEditingController();
  TextEditingController amount = TextEditingController();
  String transactionOption = "";
  TextEditingController note = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      receiverName.text = metadata.receiverName;
      receiverNumber.text = metadata.receiverName;
      date.text = metadata.transactionDate;
      ref.text = metadata.referenceNumber;
      amount.text = metadata.amount.toString();
      transactionOption = metadata.transactionType;
      note.text = metadata.note;
    });
  }

  void generateQr() async {
    setState(() {
      isLoading = true;
    });
    try {
      String qrUrl = await _webservice.generateQRTOKEN(hashblock: widget.hash);
      Clipboard.setData(ClipboardData(text: qrUrl));
      showSnackbar(context, "Akses alamat telah disalin");
    } catch (e) {
      showSnackbar(context, "$e");
    }
    setState(() {
      isLoading = true;
    });
  }

  Widget formWidget() => Form(
      key: _formkey,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Nama Penerima*"),
              readOnly: true,
              controller: receiverName,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Nomor Tujuan Penerima*"),
              readOnly: true,
              controller: receiverNumber,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Nomor Referensi*"),
              readOnly: true,
              controller: ref,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Tanggal Transaksi*"),
              controller: date,
              readOnly: true,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Nominal*"),
              keyboardType: TextInputType.number,
              readOnly: true,
              controller: amount,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Catatan"),
              readOnly: true,
              controller: note,
              maxLines: 5,
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 7, bottom: 7),
              child: Image.network(
                  "$serverUri/image/${widget.metadata.imageUri}")),
          Container(
              margin: EdgeInsets.only(top: 7, bottom: 7),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: generateQr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code, color: Colors.white),
                        Text("Bagikan Arsip Transaksi",
                            style: style.textMenuStyle(context, Colors.white)),
                      ],
                    ),
                    style: style.button(context, isLoading)),
              )),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 35, right: 35, bottom: 50, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${transactionOption.toUpperCase()}",
                  style: style.header(context),
                ),
                formWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
