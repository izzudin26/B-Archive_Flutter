import 'dart:io';
import 'package:b_archive/model/blockdata.dart';
import 'package:flutter/material.dart';
import 'package:b_archive/style/style.dart' as style;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:b_archive/service/webservice.dart' as _webservice;
import 'package:b_archive/components/snackbarMessage.dart';

class FormTransaction extends StatefulWidget {
  FormTransaction({Key? key}) : super(key: key);

  @override
  State<FormTransaction> createState() => _FormTransactionState();
}

class _FormTransactionState extends State<FormTransaction> {
  final _formkey = GlobalKey<FormState>();
  XFile? image;
  bool isLoading = false;

  TextEditingController receiverName = TextEditingController();
  TextEditingController receiverNumber = TextEditingController();
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
      setState(() {
        image = file;
      });
    }
  }

  String? validateReceiverName(String? value) {
    if (value == null || value.isEmpty) {
      return "Nama Penerima tidak boleh kosong";
    }
    if (value.length < 3) {
      return "Nama Penerima tidak boleh kurang dari 3 karakter";
    }
    return null;
  }

  String? validateReceiverNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Nomor tujuan tidak boleh kosong";
    }
    return null;
  }

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "tanggal tidak boleh kosong";
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return "nominal tidak boleh kosong";
    }
    return null;
  }

  String? validateTransactionType(String? value) {
    if (value == null || value.isEmpty) {
      return "jenis transaksi tidak boleh kosong";
    }
    return null;
  }

  Future<void> processInsert() async {
    if (_formkey.currentState!.validate()) {
      if (image != null) {
        setState(() {
          isLoading = true;
        });
        try {
          String imagename =
              await _webservice.uploadImage(image: new File(image!.path));
          Metadata metadata = Metadata(
              receiverName: receiverName.text,
              receiverNumber: receiverNumber.text,
              transactionDate: date.text,
              referenceNumber: ref.text,
              amount: int.parse(amount.text),
              note: note.text,
              imageUri: imagename,
              transactionType: transactionOption);
          await _webservice.insertBlockdata(metadata: metadata);
          showSnackbar(context, "Berhasil mengarsipkan data");
          Navigator.pop(context);
        } catch (e) {
          showSnackbar(context, "$e");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        showSnackbar(context, "Bukti transaksi tidak boleh kosong");
      }
    }
  }

  Widget formWidget() => Form(
      key: _formkey,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Nama Penerima*"),
              validator: validateReceiverName,
              controller: receiverName,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Nomor Tujuan Penerima*"),
              validator: validateReceiverNumber,
              controller: receiverNumber,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Tanggal Transaksi*"),
              controller: date,
              readOnly: true,
              validator: validateDate,
              onTap: _showDatePicker,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 7, bottom: 7),
            child: TextFormField(
              decoration: style.textInput(context, "Nominal*"),
              keyboardType: TextInputType.number,
              validator: validateAmount,
              controller: amount,
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 7, bottom: 7),
              child: DropdownButtonFormField<String>(
                  validator: validateTransactionType,
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
                child: image != null
                    ? Image.file(File(image!.path))
                    : Container(
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
                                style: style.textMenuStyle(context,
                                    Theme.of(context).colorScheme.primary))
                          ],
                        )),
                      )),
          ),
          Container(
              margin: EdgeInsets.only(top: 7, bottom: 7),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: processInsert,
                    child: Text("Arsipkan Transaksi",
                        style: style.textMenuStyle(context, Colors.white)),
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
