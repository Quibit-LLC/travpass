import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:travpass/nav_pages/transfer_success.dart';

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({super.key});

  @override
  State<ScanQRPage> createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF0B2031),
      body: Container(
        width: width,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF0B2031)),
        child: Stack(
          children: [
            Positioned(
              left: -381,
              top: -575,
              child: Container(
                width: 1080,
                height: 1920,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/background.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 31,
              top: 231,
              child: Container(
                width: 381.79,
                height: 411.09,
                child: Stack(
                  children: [
                    Positioned(
                      left: 63,
                      top: 75,
                      child: Container(
                        width: 247,
                        height: 273,
                        decoration: BoxDecoration(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 45,
              top: 102,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Scanning QR Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w900,
                        height: 0,
                      ),
                    ),
                    Text(
                      'Place the QR Code in the area',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 86,
              top: 100,
              child: Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      MobileScanner(
                          controller: controller,
                          onDetect: (barcode) {
                            if (!isScanCompleted) {
                              String scanResult = barcode.raw ?? '---';
                              isScanCompleted = true;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => TransferSuccess(
                                            scanResults: scanResult,
                                          ))));
                            }
                          }),
                      QRScannerOverlay(
                        overlayColor: Colors.black54,
                      ),
                    ],
                  )),
            ),
            Positioned(
                left: 130,
                bottom: 80,
                child: Container(
                  width: 200,
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              child: IconButton(
                                  iconSize: 40,
                                  onPressed: () {
                                    setState(() {
                                      isFlashOn = !isFlashOn;
                                    });
                                    controller.toggleTorch();
                                  },
                                  icon: Icon(Icons.flash_on,
                                      color: isFlashOn
                                          ? Colors.blue
                                          : Colors.grey)),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              child: IconButton(
                                  iconSize: 40,
                                  onPressed: () {
                                    setState(() {
                                      isFrontCamera = !isFrontCamera;
                                    });
                                    controller.switchCamera();
                                  },
                                  icon: Icon(Icons.camera_front_outlined,
                                      color: isFrontCamera
                                          ? Colors.blue
                                          : Colors.grey)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
