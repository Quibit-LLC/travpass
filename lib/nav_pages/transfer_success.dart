import 'package:flutter/material.dart';
import 'package:travpass/nav_pages/main_page.dart';

class TransferSuccess extends StatefulWidget {
  TransferSuccess({super.key, required this.scanResults});
  final String scanResults;

  @override
  State<TransferSuccess> createState() => _TransferSuccessState();
}

class _TransferSuccessState extends State<TransferSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/transfer_success.png")),
                    ),
                  ),
                ),
                const Center(
                    child: Text("Transfer Successful!!!",
                        style: TextStyle(
                          color: Color(0xFF1D3A6F),
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 0.05,
                          letterSpacing: -0.20,
                        ))),
                const Text(
                    'Transfers are reviewed which may result in delays or funds being frozen',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 11,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0.14,
                      letterSpacing: 0.30,
                    )),
                const SizedBox(height: 20),
                Container(
                  width: 200,
                  height: 74,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFF9F00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Kshs. ${widget.scanResults}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1D3A6F),
                          fontSize: 30,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          height: 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => MainPage(
                                isConductor: false,
                              )))),
                  child: Container(
                    width: 327,
                    height: 56,
                    padding: const EdgeInsets.all(8),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF1D3A6F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Back to Home',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 0.09,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
