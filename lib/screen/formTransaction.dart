import 'dart:io';

import 'package:flutter/material.dart';
import 'package:b_archive/style/style.dart' as style;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

class FormTransaction extends StatefulWidget {
  FormTransaction({Key? key}) : super(key: key);

  @override
  State<FormTransaction> createState() => _FormTransactionState();
}

class _FormTransactionState extends State<FormTransaction> {
  final _formkey = GlobalKey<FormState>();
  XFile? image;

  TextEditingController name = TextEditingController();
  TextEditingController rekening = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController ref = TextEditingController();
  TextEditingController amount = TextEditingController();
  String transactionOption = "payment";
  TextEditingController note = TextEditingController();

  void _showDatePicker() {
    DatePicker.showDatePicker(context, onConfirm: (_date) {
      setState(() {
        print(_date);
        date.text = "${_date.day}-${_date.month}-${_date.year}";
      });
    }, currentTime: DateTime.now(), locale: LocaleType.id);
  }

  Future<void> _imagePicker() async {
    final ImagePicker _picker = ImagePicker();
    XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      print(file.path);
      setState(() {
        image = file;
      });
    }
  }

  Widget formWidget() => Form(
      key: _formkey,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Nama Penerima"),
              controller: name,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Nomor Tujuan Penerima"),
              controller: rekening,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Tanggal Transaksi"),
              controller: date,
              readOnly: true,
              onTap: _showDatePicker,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Nominal"),
              keyboardType: TextInputType.number,
              controller: amount,
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 7, bottom: 7),
              child: DropdownButtonFormField<String>(
                  decoration: style.textInput(context, "Jenis Transaksi"),
                  items: <String>["payment", "transfer", "topup"]
                      .map((e) => DropdownMenuItem(
                            child: Text(e == "payment"
                                ? "Pembayaran"
                                : e == "transfer"
                                    ? "Transfer"
                                    : "Topup"),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      transactionOption = value!;
                    });
                  })),
          Container(
            margin: EdgeInsets.only(top: 7, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Catatan"),
              controller: note,
              maxLines: 5,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, bottom: 7),
            child: InkWell(
                onTap: _imagePicker,
                child: image != null ? Image.file(File(image!.path)) : Container(
                  padding: EdgeInsets.only(top: 40, bottom: 40),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.5),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Column(
                    children: [
                      Icon(Icons.image,
                          color: Theme.of(context).colorScheme.primary,
                          size: MediaQuery.of(context).size.width * 0.1),
                      Text("Upload Bukti",
                          style: style.textMenuStyle(
                              context, Theme.of(context).colorScheme.primary))
                    ],
                  )),
                )),
          ),
          Container(
              margin: EdgeInsets.only(top: 7, bottom: 7),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {},
                    child: Text("Arsipkan Transaksi",
                        style: style.textMenuStyle(context, Colors.white)),
                    style: style.button(context, false)),
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
                Text("Sebelum melakukan pengarsipan", style: style.subtitle()),
                Text("yuk isi data dibawah!", style: style.subtitle()),
                Text(
                  "Form Transaksi",
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
