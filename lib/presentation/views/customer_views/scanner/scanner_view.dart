import 'package:flutter/gestures.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/index.dart';

import '../../bottom_navigation/bottom_nav_view_model.dart';

class ScannerView extends StatefulWidget {
  static String routeName = "/qrscan";

  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  // late Size size;
  final GlobalKey _qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? _controller;
  bool isFlashOff = true;
  Barcode? result;
  bool isBuild = false;
  @override
  Widget build(BuildContext context) {
    if (!isBuild && _controller != null) {
      _controller?.pauseCamera();
      _controller?.resumeCamera();
      setState(() {
        isBuild = true;
      });
    }

    return Consumer<CustomerBottomNavViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              viewModel.pageChange(0);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
          title: kTextBentonSansBold(
            'Scan QR Code',
            color: ColorManager.white,
            fontSize: getProportionateScreenHeight(26),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              child: _buildQrView(context),
            ),
            Column(
              children: [
                buildVerticleSpace(120),
                kTextBentonSansReg(
                  'Linking Customer to shop\nvia QR  Code or Enter\nSEHR Shop Code',
                  color: ColorManager.white,
                  fontSize: getProportionateScreenHeight(18),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                kTextBentonSansReg(
                  'OR',
                  color: ColorManager.white,
                  fontSize: getProportionateScreenHeight(20),
                ),
                buildVerticleSpace(12),
                kTextBentonSansReg(
                  'SEHR Shop code',
                  color: ColorManager.white,
                  fontSize: getProportionateScreenHeight(18),
                ),
                buildVerticleSpace(26),
                PinCodeFields(
                  length: 6,
                  // controller: newTextEditingController,
                  // focusNode: focusNode,
                  borderWidth: 1,
                  fieldHeight: getProportionateScreenHeight(60),
                  // fieldWidth: getProportionateScreenWidth(40),
                  margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(8),
                  ),
                  padding: EdgeInsets.zero,
                  autoHideKeyboard: false,
                  keyboardType: TextInputType.number,
                  borderColor: ColorManager.lightGrey,
                  activeBorderColor: ColorManager.primary,
                  fieldBorderStyle: FieldBorderStyle.square,
                  textStyle: TextStyleManager.mediumTextStyle(
                    fontSize: getProportionateScreenHeight(30),
                    color: ColorManager.white,
                  ),
                  onComplete: (result) {},
                ),
                buildVerticleSpace(27),
                AppButtonWidget(
                  ontap: () {},
                  height: getProportionateScreenHeight(46),
                  width: getProportionateScreenWidth(200),
                  borderRadius: getProportionateScreenHeight(23),
                  text: 'Connect',
                  textSize: getProportionateScreenHeight(18),
                ),
                buildVerticleSpace(50),
              ],
            ),
            // SizedBox(
            //   height: SizeConfig.screenHeight,
            //   width: SizeConfig.screenWidth,
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           IconButton(
            //             onPressed: () {},
            //             icon: const Icon(Icons.arrow_back_ios_rounded),
            //           ),
            //           kTextBentonSansBold(
            //             'Scan QR Code',
            //             color: ColorManager.white,
            //             fontSize: getProportionateScreenHeight(26),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = getProportionateScreenHeight(200);
    return QRView(
      key: _qrKey,
      onQRViewCreated: _onQRviewCreated,
      onPermissionSet: (ctrl, p) => onPermissionSet(context, ctrl, p),
      overlay: QrScannerOverlayShape(
        cutOutSize: scanArea,
        borderWidth: getProportionateScreenHeight(8),
        borderColor: ColorManager.primary,
        borderLength: getProportionateScreenHeight(15),
        borderRadius: 4,
      ),
    );
  }

  Widget _showResult() {
    bool validUrl = Uri.parse(result!.code.toString()).isAbsolute;
    return Center(
        child: FutureBuilder<dynamic>(
      future: showDialog(
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
              child: AlertDialog(
                title: const Text(
                  'Scan Result',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: SizedBox(
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      validUrl
                          ? SelectableText.rich(TextSpan(
                              text: result!.code.toString(),
                              style: TextStyle(
                                color: ColorManager.primary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // launchUrl(Uri.parse(result!.code.toString()));
                                }))
                          : Text(
                              result!.code.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _controller?.resumeCamera();
                        },
                        child: const Text(
                          'Close',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onWillPop: () async => false,
            );
          }),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        throw UnimplementedError;
      },
    ));
  }

  void _onQRviewCreated(QRViewController qrController) {
    setState(() {
      _controller = qrController;
    });
    _controller?.scannedDataStream.listen((event) {
      setState(() {
        result = event;
        _controller?.pauseCamera();
      });
      if (result?.code != null) {
        print('Scanned & showing result');
        _showResult();
      }
    });
  }

  void onPermissionSet(
      BuildContext context, QRViewController ctrl, bool permisson) {
    if (!permisson) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No Permision')));
    }
  }
}
