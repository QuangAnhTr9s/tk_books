import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tk_books/component/back_button_appbar.dart';
import 'package:tk_books/shared/const/images.dart';

class NotificationDetailScreen extends StatefulWidget {
  const NotificationDetailScreen({Key? key}) : super(key: key);

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f7f7),
      appBar: _buildAppBar(
        context,
        titleAppBar: 'Chi tiết thông báo',
        backgroundColor: 0xffffffff,
        backgroundColorButtonBack: 0xffc4c4cf,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Nên Đọc Sách Vào Thời Gian Nào TỐT Nhất Để Đem Lại HIỆU QUẢ',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: const Color(0xff3f4254),
                ),
              ),
            ),
            Image.asset(
              MyImages.imgNoticeDetail,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Thói quen đọc sách vẫn được khuyến khích nhằm trau dồi vốn kiến thức. Mặt khác, đọc sách là bộ môn giải trí, giúp sảng khoái tinh thần sau một ngày làm việc mệt mỏi và căng thẳng.\nĐọc sách có thể coi là phương pháp dễ thực hiện nhất để mở mang vốn hiểu biết bởi lẽ ở bất cứ nơi đâu bạn cũng có thể đọc sách. Thế nhưng, không phải lúc nào cũng là thời điểm vàng giúp bạn đọc sách hiệu quả nhất. Mỗi người sẽ có quỹ thời gian khác nhau, điều này quyết định đến sự phân bổ thời gian đọc sách là không giống nhau. Nếu đọc sách trong lúc não bộ bạn không đủ tập trung và phải làm quá nhiều việc khác thì tất nhiên các kiến thức hay, bổ ích sẽ không đọng lại gì ở trong tâm trí bạn. Vì vậy, bạn cần xác định được thời gian đọc sách tốt nhất, lúc mà não bộ tỉnh táo nhất trong ngày thì dù chỉ dành được 30 phút mỗi ngày để đọc sách cũng đem lại hiệu quả gấp mấy lần.\nBuổi sáng thường là thời điểm lý tưởng để làm mọi thứ, kể cả đọc sách. Đọc sách vào lúc nào là tốt nhất thì câu trả lời là vào lúc 8h - 9h, não bộ của bạn tỉnh táo nhất, cơ thể nhiều năng lượng nhất để tiếp thu tri thức một cách hiệu quả nhất. Khoa học đã chứng minh rằng, chỉ cần tập trung 6 phút mỗi buổi sáng khi đọc sách là sự căng thẳng, tinh thần mệt mỏi sẽ tan biến hết. Thay vào đó, đọc sách vào mỗi buổi sáng như màn khởi động não bộ hoàn hảo trước khi bắt đầu làm việc hoặc học tập.\nVới người già đã về hưu, đọc sách không chỉ là thói quen giết thời gian mỗi ngày mà còn kích thích não bộ, tăng cường trí nhớ và làm chậm quá trình đãng trí ở người già.',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: const Color(0xff3f4254),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context,
      {String? titleAppBar,
      required int backgroundColor,
      required int backgroundColorButtonBack}) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        titleAppBar ?? '',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
        child: BackButtonAppBar(
          backgroundColor: Color(backgroundColorButtonBack),
          iconColor: Colors.white,
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      backgroundColor: Color(backgroundColor),
    );
  }
}
