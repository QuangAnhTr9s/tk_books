import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tk_books/component/audio_player_widget.dart';
import 'package:tk_books/component/back_button_appbar.dart';
import 'package:tk_books/component/video_player_widget.dart';
import 'package:tk_books/model/exercise.dart';
import 'package:tk_books/shared/const/images.dart';
import 'package:tk_books/view/exercise_detail/bloc/is_choose_page_bloc.dart';
import 'package:tk_books/view/exercise_detail/bloc/is_show_audio_sub_title_bloc.dart';
import 'package:tk_books/view/exercise_detail/bloc/is_show_video_sub_title_bloc.dart';
import 'package:tk_books/view/exercise_detail/event/is_choose_page_event.dart';
import 'package:tk_books/view/exercise_detail/event/is_show_video_sub_title_event.dart';
import 'package:video_player/video_player.dart';

import '../event/is_show_audio_sub_title_event.dart';

class ExerciseDetailScreen extends StatefulWidget {
  const ExerciseDetailScreen({super.key});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  late Exercise exercise;
  late String nameLesson;
  String content =
      'Với các từ có tận cùng là “e”, khi chuyển sang dạng ing thì sẽ bỏ đuôi “e” và thêm “ing” luôn. (use – using; pose – posing; improve – improving; change – changing)\n- Với các từ có tận cùng là “ee” khi chuyển sang dạng ing thì VẪN GIỮ NGUYÊN “ee” và thêm đuôi “ing”. (knee – kneeing)\n- Động từ kết thúc bằng một phụ âm (trừ h, w, x, y), đi trước là một nguyên âm, ta gấp đôi phụ âm trước khi thêm “ing. (stop – stopping; run – running, begin – beginning; prefer – preferring)\n- Quy tắc gấp đôi phụ âm rồi mới thêm ing:\n+, Nếu động từ có 1 âm tiết kết thúc bằng một phụ âm (trừ h, w, x, y), đi trước là một nguyên âm ta gấp đôi phụ âm trước khi thêm “ing. (stop – stopping; run – running)\ntrường hợp kết thúc 2 nguyên âm + 1 phụ âm, thì thêm ing bình thường, không gấp đôi phụ âm. \nVới động từ có HAI âm tiết, tận cùng là MỘT PHỤ ÂM, trước là MỘT NGUYÊN ÂM, trọng âm rơi vào âm tiết thứ HAI → nhân đôi phụ âm cuối rồi thêm “-ing”. Ví dụ: begin – beginning, prefer – preferring, permit – permitting.\nNếu trọng âm nhấn vào vị trí âm không phải âm cuối thì không gấp đôi phụ âm: Listen - listening, Happen - happening, enter - entering...\n+, Nếu phụ âm kết thúc là "l" thì thường người Anh sẽ gấp đôi l còn người Mỹ thì không.\nVí dụ: Travel : Anh - Anh là Travelling, Anh - Mỹ là Traveling, cả hai cách viết đều sử dụng được nhé.\n- Động từ kết thúc là “ie” thì khi thêm “ing”, thay “ie” vào “y” rồi thêm “ing”. (lie – lying; die – dying) \n\n\n\n\n\n\noksdsjfsdfdsf';
  final TextEditingController _textSearchEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    exercise = arguments['exercise'];
    nameLesson = arguments['nameLesson'];
    return exercise.info == 'Audio'
        ? _buildScreenWithAudio(context)
        : exercise.info == 'Video'
            ? _buildScreenWithVideo(context)
            : exercise.info == 'PDF'
                ? _buildScreenWithPDF(context)
                : Container();
  }

  Widget _buildScreenWithAudio(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => IsShowAudioSubTitleBloc(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        // Để cho phép ảnh nền của Scaffold nằm behind appbar
        appBar: _buildAppBar(
          context,
          titleAppBar: 'Chi tiết bài học',
          backgroundColor: 0xffffffff,
          backgroundColorButtonBack: 0xffc4c4cf,
        ),
        body: BlocBuilder<IsShowAudioSubTitleBloc, bool>(
          builder: (context, isShowSub) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: sizeScreen.height * 3 / 4,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(MyImages.bookDetailBanner),
                          fit: BoxFit.fill,
                          alignment: Alignment.topCenter),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(14, 16, 14, 0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32))),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              exercise.name,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              nameLesson,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          AudioPlayerWidget(
                            onTapOpenSubTitle: () {
                              context
                                  .read<IsShowAudioSubTitleBloc>()
                                  .add(ShowSubTitleEvent());
                            },
                            isShowSub: isShowSub,
                          ),
                        ],
                      ),
                    )),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 320,
                  child: !isShowSub
                      ? const SizedBox()
                      : ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 2,
                              sigmaY: 2,
                            ),
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 17, 16),
                              width: 335,
                              height: 104,
                              decoration: BoxDecoration(
                                color: const Color(0x4c000000),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Center(
                                child: SizedBox(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 302,
                                    ),
                                    child: Text(
                                      'Với các từ có tận cùng là “e”, khi chuyển sang dạng ing thì sẽ bỏ đuôi “e” và thêm “ing” luôn.',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildScreenWithVideo(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<IsShowVideoSubTitleBloc>(
            create: (context) => IsShowVideoSubTitleBloc(),
          ),
        ],
        child: BlocBuilder<IsShowVideoSubTitleBloc, bool>(
            builder: (context, isShowSub) {
          return VideoPlayerWidget(
            title: 'Thì hiện tại đơn',
            subTitle: nameLesson,
            url: 'assets/video/video_30_seconds.mp4',
            dataSourceType: DataSourceType.asset,
            isShowSub: isShowSub,
            onTapOpenSubTitle: () =>
                context.read<IsShowVideoSubTitleBloc>().add(
                      ShowVideoSubTitleEvent(),
                    ),
          );
        }),
      ),
    );
  }

  Widget _buildScreenWithPDF(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context,
          titleAppBar: 'Chi tiết bài học',
          backgroundColor: 0xffffffff,
          backgroundColorButtonBack: 0xffc4c4cf),
      backgroundColor: const Color(0xfff2f7f7),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Text(
                content,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32))),
            child: SizedBox(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xff009593),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () => showModalBottomSheet(
                        context: context,
                        builder: _buildModalBottomSheet,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ))),
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff009593)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Trang 1',
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              height: 1.17,
                              color: const Color(0xff009593),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xff009593),
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xff009593),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context,
      {String? titleAppBar,
      required int backgroundColor,
      required int backgroundColorButtonBack}) {
    return AppBar(
      elevation: 0,
      // Loại bỏ đổ bóng của AppBar
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

  Widget _buildModalBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Chọn trang',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    width: 30,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.clear,
                          color: Color(0xff8b90a7), size: 24),
                    ),
                  )
                ],
              )),
          const Divider(color: Color(0xffebebf0), thickness: 2),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xfff5f5fa),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      MyImages.iCSearch,
                      fit: BoxFit.fill,
                    )),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(left: 8),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: _textSearchEditingController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          hintText: 'Tìm trang',
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          border: InputBorder.none,
                        ),
                      )),
                ),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: GestureDetector(
                    onTap: () => _textSearchEditingController.clear(),
                    child: Image.asset(MyImages.icRemoveCircle),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xffebebf0), thickness: 2),
          Expanded(
            child: BlocProvider(
              create: (context) => IsChoosePageBloc(),
              child: BlocBuilder<IsChoosePageBloc, int>(
                  builder: (context, indexChoose) {
                return ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _buildItemListPage(context, index, indexChoose);
                  },
                );
              }),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 47,
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xff009593),
                borderRadius: BorderRadius.circular(48),
              ),
              child: Center(
                child: Text(
                  'XÁC NHẬN',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemListPage(BuildContext context, int index, int indexChoose) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () => context
            .read<IsChoosePageBloc>()
            .add(ChoosePageEvent(newIndex: index)),
        child: Container(
          height: 48,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trang ${index + 1}',
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.43,
                  color: const Color(0xff3f4254),
                ),
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: indexChoose == index
                    ? Image.asset(MyImages.icTick4)
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
