import 'dart:convert';
import 'dart:io';

import 'package:b_archive/components/snackbarMessage.dart';
import 'package:b_archive/model/blockdata.dart';
import 'package:b_archive/screen/formTransactionView.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scanner extends StatefulWidget {
  Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey _qr = GlobalKey(debugLabel: 'QR');
  Barcode? _resultScanner;
  Map<String, dynamic>? resultJson;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scan) {
      try {
        Map<String, dynamic> data = jsonDecode(scan.code!);
        Metadata metadata = Metadata.fromJson(data);
        print(data);
        controller.pauseCamera();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => FormTransactionView(metadata: metadata)));
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      } catch (e) {
        showSnackbar(context, "QR Code tidak valid");
        controller.resumeCamera();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return Scaffold(
      body: QRView(
          key: _qr,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Theme.of(context).colorScheme.primary,
              borderRadius: 20,
              cutOutSize: scanArea)),
    );
  }
}
