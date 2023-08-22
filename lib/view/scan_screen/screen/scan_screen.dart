import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tk_books/shared/const/images.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  Barcode? result;
  QRViewController? _qRViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool showErrorDialog = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => NotiDialog(
          title: 'Hướng dẫn',
          content:
              'Đưa camera của điện thoại vào khoảng cách 5-10 cm với mã QR được in phía sau mỗi cuốn sách. Mã QR sẽ tự động được quét ',
          textButton: 'ĐÃ RÕ',
          onTapButton: () => Navigator.pop(context),
        ),
      );
    });
  }

  @override
  void dispose() {
    _qRViewController?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _qRViewController = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (isInvalidResult(result?.code)) {
        showErrorDialog = true; // Hiển thị dialog
      }
    });
  }

  bool isInvalidResult(String? result) {
    // Đặt các điều kiện kiểm tra kết quả ở đây
    // return result == null || result.isEmpty;
    return result != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          _buildQrView(context),
          Positioned(
            top: 50,
            right: 20,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white12,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (showErrorDialog)
            NotiDialog(
              title: 'Bài học không tồn tại',
              content: 'Vui lòng kiểm tra lại mã code',
              textButton: 'XÁC NHẬN',
              onTapButton: () {
                setState(() {
                  showErrorDialog = false;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    /* var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;*/
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.white,
        borderRadius: 30,
        borderLength: 50,
        borderWidth: 8,
        // cutOutSize: scanArea,
      ),
      // onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }
}

class NotiDialog extends StatelessWidget {
  final String title;
  final String content;
  final String textButton;
  final VoidCallback? onTapButton;

  const NotiDialog({
    super.key,
    required this.title,
    required this.content,
    required this.textButton,
    this.onTapButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 174,
              width: 160,
              child: Image.asset(MyImages.scanExample),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                if (onTapButton != null) {
                  onTapButton!();
                }
              },
              child: Container(
                height: 47,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(48),
                  color: const Color(0xff009593),
                ),
                child: Center(
                  child: Text(
                    textButton,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
