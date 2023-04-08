import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/utils/utils.dart';
import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';

import '../../../src/index.dart';
import '../../../view_models/bottom_nav_view_model.dart';
import '../../drawer/custom_drawer.dart';

class ScannerView extends StatefulWidget {
  static String routeName = "/qrscan";

  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  // late Size size;
  final GlobalKey _qrKey = GlobalKey(debugLabel: "QR");
  TextEditingController Codecontroller = TextEditingController();
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
                  controller: Codecontroller,
                  keyboardType: TextInputType.number,
                  borderColor: ColorManager.lightGrey,
                  activeBorderColor: ColorManager.primary,
                  fieldBorderStyle: FieldBorderStyle.square,
                  textStyle: TextStyleManager.mediumTextStyle(
                    fontSize: getProportionateScreenHeight(30),
                    color: ColorManager.white,
                  ),
                  onComplete: (result) async {
                    await _showResult(Codecontroller.text);
                    Codecontroller.clear();
                  },
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

  TextEditingController amountcontroller = TextEditingController();
  TextEditingController commentcontroller = TextEditingController();

  Widget _showResult(String sehercode) {
    return Center(
        child: FutureBuilder<dynamic>(
      future: showDialog(
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
              child: AlertDialog(
                title: Text(
                  'Scan Result $sehercode',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        controller: amountcontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                          label: Text("Amount"),
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: commentcontroller,
                        minLines: 5,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                          label: Text("Comment"),
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              onPressed: () async {
                                if (amountcontroller.text.isNotEmpty) {
                                  var response =
                                      await _orderApi.requestSendOrderApi(
                                          sehercode,
                                          int.parse(amountcontroller.text),
                                          commentcontroller.text);
                                  if (response != null) {
                                    Navigator.pop(context);
                                    Utils.flushBarErrorMessage(context,
                                        'order placed successfully, check out the status of order');
                                  } else {
                                    Utils.flushBarErrorMessage(context,
                                        'No Shop Found or cant place order to your own shop');
                                  }
                                }
                              },
                              child: Container(
                                color: ColorManager.primary,
                                height: 30,
                                width: 60,
                                child: const Center(
                                  child: Text(
                                    "Send",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _controller?.resumeCamera();
                              },
                              child: Container(
                                color: Colors.red,
                                height: 30,
                                width: 60,
                                child: const Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ],
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

  final OrderApi _orderApi = OrderApi();

  void _onQRviewCreated(QRViewController qrController) async {
    setState(() {
      _controller = qrController;
    });
    _controller?.scannedDataStream.listen((event) async {
      setState(() {
        result = event;
        _controller?.pauseCamera();
      });
      if (result?.code != null) {
        print('Scanned & showing result');
        _showResult(result!.code.toString());
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
