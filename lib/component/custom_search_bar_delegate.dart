import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tk_books/component/back_button_appbar.dart';
import 'package:tk_books/model/lesson.dart';
import 'package:tk_books/shared/fake_data/fake_data_lesson.dart';

import '../model/exercise.dart';
import '../shared/const/images.dart';
import '../shared/const/screen_consts.dart';
import '../view/lesson_detail/bloc/is_show_more_lesson_info_bloc.dart';
import '../view/lesson_detail/event/is_show_more_leeson_info_event.dart';

class MySearchBarDelegate extends SearchDelegate {
  Function(String)? updateQuery;
  final TextEditingController _textSearchEditingController =
      TextEditingController();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        titleLarge: theme.textTheme.titleLarge!.copyWith(
          // Kiểu cho query
          fontSize: 16,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
        ),
      ),
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        elevation: 0,
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        border: InputBorder.none,
        hintStyle: const TextStyle(fontSize: 14),
      ),
      textSelectionTheme: theme.textSelectionTheme.copyWith(
        cursorColor: Colors.grey,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: 48,
        width: MediaQuery.of(context).size.width - 80,
        decoration: BoxDecoration(
          color: const Color(0xfff5f5fa),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  query = value;
                },
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    query = value.trim();
                    showResults(context);
                  }
                },
                autofocus: true,
                controller: _textSearchEditingController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  hintText: 'Tìm kiếm',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: InputBorder.none,
                ),
              ),
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
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
      child: BackButtonAppBar(
          backgroundColor: Color(0xffc4c4cf), iconColor: Colors.white),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: const Color(0xfff2f7f7),
      child: query.trim().isNotEmpty
          ? _buildListViewResults(query)
          : _buildTextNoMatchingResults(),
    );
  }

  Widget _buildListViewResults(String query) {
    List<Lesson> listLessons = _fetchProductsWithQueryBySearch(query);
    return listLessons.isEmpty
        ? _buildTextNoMatchingResults()
        : Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              itemCount: listLessons.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemBuilder: (context, index) {
                final lesson = listLessons[index];
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
                                        backgroundColor: Color(isShowMore
                                            ? 0xfff5f5fa
                                            : 0xffe0f2f3),
                                        child: GestureDetector(
                                          onTap: () => context
                                              .read<IsShowMoreLessonInfoBloc>()
                                              .add(ShowMoreLeesonInfoEvent()),
                                          child: Icon(
                                            isShowMore
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            color: Color(isShowMore
                                                ? 0xffc1c1cc
                                                : 0xff25a5a5),
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
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                          //List Exercise
                          !isShowMore
                              ? const SizedBox()
                              : _buildListViewExercise(lesson),
                        ],
                      ),
                    );
                  }),
                );
              },
            ),
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        _buildSearchSuggestions(query.trim()),
      ],
    );
  }

  Widget _buildSearchSuggestions(String query) {
    return Container();
    /* List<Lesson> listLessons = _fetchProductsWithQueryBySearch(query);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey.shade300,
          height: 4,
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: const Text(
            'Search Suggestions',
            style: TextStyle(fontSize: 17),
          ),
        ),
        Container(
          color: Colors.grey.shade300,
          height: 1,
        ),
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => Container(
                  color: Colors.grey.shade300,
                  height: 1,
                ),
            itemCount: listLessons.length,
            itemBuilder: (context, index) {
              final product = listLessons.elementAt(index);
              return Container(
                constraints:
                    const BoxConstraints(maxHeight: 120, minHeight: 80),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Product Info
                    Flexible(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 180,
                                ),
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );*/
  }

  List<Lesson> _fetchProductsWithQueryBySearch(String query) {
    List<Lesson> listLessons = List.from(FakeDataLesson().listLessons);
    if (query.trim().isNotEmpty) {
      List<Lesson> listResult = listLessons
          .where(
            (element) =>
                element.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      return listResult;
    } else {
      return listLessons;
    }
  }

  Widget _buildTextNoMatchingResults() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'Xin lỗi, không có kết quả nào phù hợp!',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );
  }

}
