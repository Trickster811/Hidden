import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidden/screens/message_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';

class ScanScreen extends StatefulWidget {
  final double appBarHeightSize;

  const ScanScreen({Key? key, required this.appBarHeightSize})
      : super(key: key);
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Connect',
          style: TextStyle(
            color: Theme.of(context).iconTheme.color!,
            fontSize: 25,
            fontFamily: 'Comfortaa_bold',
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(
            top: 10,
            child: buildControlButtons(),
          ),
          Positioned(
            bottom: 10,
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    final XFile? qrCodeImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    final qrCode = await Scan.parse(qrCodeImage!.path);
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => MessageScreen(
                                receiver: qrCode!.substring(0, 9),
                              )),
                        ),
                      );
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/image.6.svg',
                      color: Theme.of(context).iconTheme.color!,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                buildResult(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildControlButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {});
            },
            icon: SvgPicture.asset(
              'assets/icons/plus.1.svg',
              color: Theme.of(context).iconTheme.color!,
            ),
          ),
          IconButton(
            onPressed: () async {
              await controller?.flipCamera();
              setState(() {});
            },
            icon: SvgPicture.asset(
              'assets/icons/camera.1.svg',
              color: Theme.of(context).iconTheme.color!,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildResult() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          barcode != null ? 'Result : ${barcode!.code}' : 'Scan to connect',
          maxLines: 3,
        ),
      );

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).iconTheme.color!,
        borderRadius: 20,
        borderLength: 40,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => MessageScreen(
                  receiver: barcode.code!.substring(0, 9),
                )),
          ),
        );
      });
    });
  }
}
