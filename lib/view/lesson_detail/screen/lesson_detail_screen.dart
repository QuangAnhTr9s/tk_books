import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tk_books/component/back_button_appbar.dart';
import 'package:tk_books/component/custom_search_bar_delegate.dart';
import 'package:tk_books/model/exercise.dart';
import 'package:tk_books/model/lesson.dart';
import 'package:tk_books/shared/const/images.dart';
import 'package:tk_books/shared/const/screen_consts.dart';
import 'package:tk_books/shared/fake_data/fake_data_lesson.dart';
import 'package:tk_books/view/lesson_detail/bloc/is_show_more_lesson_info_bloc.dart';
import 'package:tk_books/view/lesson_detail/event/is_show_more_leeson_info_event.dart';

class LessonDetailScreen extends StatefulWidget {
  const LessonDetailScreen({Key? key}) : super(key: key);

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  List<Lesson> _listLesson = [];

  @override
  Widget build(BuildContext context) {
    _listLesson = FakeDataLesson().listLessons;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(144),
        child: _buildAppBar(context),
      ),
      backgroundColor: const Color(0xfff2f7f7),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: ListView.separated(
          itemCount: _listLesson.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 16,
          ),
          itemBuilder: (context, index) => _buildListViewLessonElement(
              context: context, lesson: _listLesson[index]),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: BackButtonAppBar(
            backgroundColor: Colors.white.withOpacity(0.3),
            iconColor: Colors.white,
          )),
      title: Text(
        'Bài học',
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: _buildSearch(),
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        height: 48,
        constraints: const BoxConstraints(maxWidth: 550, minWidth: 150),
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xfff5f5fa),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () => showSearch(
                  context: context,
                  delegate: MySearchBarDelegate(),
                ),
                child: Row(
                  children: [
                    SizedBox(
                        height: 24,
                        width: 24,
                        child: Image.asset(MyImages.iCSearch)),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Tìm kiếm bài học',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
              width: 24,
              child: InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteName.scanScreen),
                  child: SvgPicture.asset(MyImages.icQRCodeSVG)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListViewLessonElement(
      {required BuildContext context, required Lesson lesson}) {
    return BlocProvider(
      create: (context) => IsShowMoreLessonInfoBloc(),
      child: BlocBuilder<IsShowMoreLessonInfoBloc, bool>(
          builder: (context, isShowMore) {
        return Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffebebf0)),
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: Image.asset(
                        MyImages.iCOpenBook3,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircleAvatar(
                            backgroundColor:
                                Color(isShowMore ? 0xfff5f5fa : 0xffe0f2f3),
                            child: GestureDetector(
                              onTap: () => context
                                  .read<IsShowMoreLessonInfoBloc>()
                                  .add(ShowMoreLeesonInfoEvent()),
                              child: Icon(
                                isShowMore
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color:
                                    Color(isShowMore ? 0xffc1c1cc : 0xff25a5a5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  lesson.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                width: 67,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xff25a5a5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: Image.asset(
                        MyImages.iCOpenBook2,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${lesson.listExercise.length} bài',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              //List Exercise
              !isShowMore ? const SizedBox() : _buildListViewExercise(lesson),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildListViewExercise(Lesson lesson) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xffebebf0),
              )),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: lesson.listExercise.length,
            separatorBuilder: (context, index) => const Divider(
              color: Color(0xffebebf0),
              thickness: 2,
            ),
            itemBuilder: (context, index) {
              Exercise exercise = lesson.listExercise[index];
              return InkWell(
                onTap: () => Navigator.pushNamed(
                    context, RouteName.exerciseDetailScreen, arguments: {
                  'exercise': exercise,
                  'nameLesson': lesson.name
                }),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        width: 24,
                        height: 24,
                        child: Image.asset(exercise.urlIcon),
                      ),
                      Text(
                        exercise.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(
                        height: 14,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Trang: ',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Text(
                                    exercise.numberPage
                                        .toString()
                                        .padLeft(2, '0'),
                                    style: GoogleFonts.quicksand(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                      color: const Color(0xff8b90a7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 2,
                              height: 2,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1),
                                color: const Color(0xff8b90a7),
                              ),
                            ),
                            Text(
                              exercise.info,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            if (exercise.info == 'Video' ||
                                exercise.info == 'Audio')
                              Text(
                                ': ${exercise.time}',
                                style: GoogleFonts.quicksand(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.17,
                                  color: const Color(0xff8b90a7),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
