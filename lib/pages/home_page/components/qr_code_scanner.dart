// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
//
// class QRCodeScanner extends StatefulWidget {
//   const QRCodeScanner({super.key});
//
//   @override
//   State<QRCodeScanner> createState() => _QRCodeScannerState();
// }
//
// class _QRCodeScannerState extends State<QRCodeScanner> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     else if (Platform.isIOS) {
//       controller!.resumeCamera();
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: onQRViewCamera,
//               overlay: QrScannerOverlayShape(
//                 borderWidth: 10,
//                 borderLength: 20,
//                 borderRadius: 10,
//                 borderColor: Colors.blue,
//                 cutOutSize: MediaQuery.of(context).size.width * 0.8
//               ),
//             ),
//           ),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Center(
//                       child: (result != null) ? Text('Data: ${result!.code}') : Text('Scan a code'),
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 5,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text('Cancel'),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           )
//           // Expanded(
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     children: [
//           //       Center(
//           //         child: (result != null) ? Text('Data: ${result!.code}') : Text('Scan a code'),
//           //       ),
//           //       Spacer(),
//           //       Positioned(
//           //         child: TextButton(
//           //           onPressed: () {
//           //             Navigator.pop(context);
//           //           },
//           //           child: Text('Cancel'),
//           //         ),
//           //       )
//           //     ],
//           //   ),
//           // ),
//
//         ],
//       ),
//     );
//   }
//   void onQRViewCamera(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }
//   @override
//   void dispose() {
//     controller?.dispose();
//         super.dispose();
//   }
// }
