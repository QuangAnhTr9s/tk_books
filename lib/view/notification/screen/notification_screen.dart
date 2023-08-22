import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tk_books/shared/const/screen_consts.dart';

import '../../../shared/const/images.dart';
import 'dart:math' as math;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isYourNotice = true;

  int _currentIndex = 0;

  _switchNotice() {
    setState(() {
      _isYourNotice = !_isYourNotice;
    });
  }

  _setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
      print(_currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: const Color(0xfff2f7f7),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 58,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xffe0f2f3),
                      borderRadius: BorderRadius.circular(48),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          flex: 1,
                          child: ButtonSwitchNotice(
                              title: 'Tin của bạn',
                              isNotice: _isYourNotice,
                              onTap: _switchNotice),
                        ),
                        Flexible(
                          flex: 1,
                          child: ButtonSwitchNotice(
                            title: 'Tin của hệ thống',
                            isNotice: !_isYourNotice,
                            onTap: _switchNotice,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: ListView.separated(
                        itemCount: 10,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                        itemBuilder: (context, index) => ItemListNotice(
                          index: index,
                        ),
                      ),
                    ),
                  ),
                  // EmptyNotiWiget(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              padding: const EdgeInsets.fromLTRB(42, 0, 42, 0),
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(0, 0),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentIndex == 0
                      ? const ActiveIconBottomNavigationBarItem(
                          urlImage: MyImages.icMenuBookActiveSVG)
                      : IconBottomNavigationBarItem(
                          urlImage: MyImages.icMenuBookSVG,
                          onTap: () => _setCurrentIndex(0),
                        ),
                  _currentIndex == 1
                      ? const ActiveIconBottomNavigationBarItem(
                          urlImage: MyImages.icMenuGiftActiveSVG)
                      : IconBottomNavigationBarItem(
                          urlImage: MyImages.icMenuGiftSVG,
                          onTap: () => _setCurrentIndex(1),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  _currentIndex == 2
                      ? const ActiveIconBottomNavigationBarItem(
                          urlImage: MyImages.icMenuNotificationActiveSVG)
                      : IconBottomNavigationBarItem(
                          urlImage: MyImages.icMenuNotificationSVG,
                          onTap: () => _setCurrentIndex(2),
                        ),
                  _currentIndex == 3
                      ? const ActiveIconBottomNavigationBarItem(
                          urlImage: MyImages.icMenuSettingActiveSVG)
                      : IconBottomNavigationBarItem(
                          urlImage: MyImages.icMenuSettingSVG,
                          onTap: () => _setCurrentIndex(3),
                        ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Container(
                  height: 53.74,
                  width: 53.74,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xff009593),
                  ),
                  child: const Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        'Thông báo',
        style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImages.bannerLessonDetail), fit: BoxFit.fill),
        ),
      ),
    );
  }
}

class ActiveIconBottomNavigationBarItem extends StatelessWidget {
  final String urlImage;

  const ActiveIconBottomNavigationBarItem({
    super.key,
    required this.urlImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          SvgPicture.asset(urlImage),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 4,
            width: 4,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffffc535),
            ),
          ),
        ],
      ),
    );
  }
}

class IconBottomNavigationBarItem extends StatelessWidget {
  final String urlImage;
  final VoidCallback onTap;

  const IconBottomNavigationBarItem({
    super.key,
    required this.urlImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Center(
          child: SvgPicture.asset(
            urlImage,
          ),
        ),
      ),
    );
  }
}

class ButtonSwitchNotice extends StatelessWidget {
  final bool isNotice;
  final String title;
  final VoidCallback? onTap;

  const ButtonSwitchNotice({
    super.key,
    required this.isNotice,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isNotice ? const Color(0xff009593) : Colors.transparent,
          borderRadius: BorderRadius.circular(48),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.43,
              color: Color(isNotice ? 0xffffffff : 0xff8b90a7),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemListNotice extends StatelessWidget {
  final int index;

  const ItemListNotice({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, RouteName.notificationDetailScreen),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          border:
              index == 0 ? Border.all(color: const Color(0xffb2dee0)) : null,
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: SvgPicture.asset(
                  MyImages.icMessyBooksSVG,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hệ thống đã ghi nhận đơn hàng',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '1 giờ trước',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            if (index == 0) const NoticeDot(),
          ],
        ),
      ),
    );
  }
}

class NoticeDot extends StatelessWidget {
  const NoticeDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Color(0xff25a5a5),
        shape: BoxShape.circle,
      ),
    );
  }
}

class EmptyNoticeWidget extends StatelessWidget {
  const EmptyNoticeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 200,
        ),
        SvgPicture.asset(
          MyImages.rafikiSVG,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'Chưa có thông báo',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Hiện tại bạn chưa có thông báo nào !',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
