import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tk_books/component/back_button_appbar.dart';
import 'package:tk_books/model/book.dart';
import 'package:tk_books/shared/const/images.dart';
import 'package:tk_books/shared/const/screen_consts.dart';
import 'package:tk_books/shared/fake_data/fake_data_book.dart';
import 'package:tk_books/view/book_details/bloc/show_more_book_info_bloc.dart';
import 'package:tk_books/view/book_details/bloc/show_more_study_program_bloc.dart';
import 'package:tk_books/view/book_details/component/delete_book_button.dart';
import 'package:tk_books/component/mini_book_info.dart';
import 'package:tk_books/view/book_details/event/show_more_book_info_event.dart';
import 'package:tk_books/view/book_details/event/show_more_study_program_event.dart';
import '../component/menu_button.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  String firstTitle = 'Cuốn sách này nói về điều gì ?';
  String contentOfFirstTitle =
      "Nội dung của Your very first English Volume 1:\nNội dung cuốn sách này được biên soạn gồm 60 bài học nhỏ theo từng chủ đề nhằm mục đích giúp các bạn có thể tự học Nghe – Nói tiếng Anh một cách dễ dàng và đơn giản nhất trong một thời gian ngắn ..";
  String secondTitle = 'Chương trình học';
  String contentOfSecondTitle = "Chương 1\nLấy lại gốc Tiếng Anh.";

  String thirdTitle = 'Sách liên quan';
  String readingCommunityText = 'Cộng đồng đọc sách';
  String joinNowText = 'Tham gia ngay';
  String moreText = 'XEM THÊM';
  String deleteBookText = 'Xóa Sách';
  String wantToDeleteBookText = 'Bạn có chắc chắn muốn xóa sách';
  String yourVeryFirstEnglishText = " \"Your very first English\" ?";
  String cancelText = 'HỦY';
  String deleteText = 'XÓA';

  late double statusBarHeight;
  late Size sizeScreen;

  //fake data
  List<Book> listBooks = FakeDataBook().listBooks;
  late Book fakeBook;

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).viewPadding.top;
    sizeScreen = MediaQuery.of(context).size;
    fakeBook = listBooks.first;
    return MultiBlocProvider(
      providers: [
        BlocProvider<IsShowMoreBookInfoBloc>(
          create: (BuildContext context) => IsShowMoreBookInfoBloc(),
        ),
        BlocProvider<IsShowMoreStudyProgramBloc>(
          create: (BuildContext context) => IsShowMoreStudyProgramBloc(),
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: Stack(
            children: [
              //Images Banner
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Image.asset(
                  MyImages.bookDetailBanner,
                  fit: BoxFit.fitWidth,
                ),
              ),
              //App bar
              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 64,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(32),
                          bottomLeft: Radius.circular(32)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButtonAppBar(
                            backgroundColor: Colors.grey.shade400,
                            iconColor: Colors.white),
                        GestureDetector(
                          onTap: () => _dialogDeleteBook(context),
                          child: DeleteBookButton(
                            text: deleteBookText.toUpperCase(),
                          ),
                        )
                      ],
                    ),
                  )),
              //Book Detail
              DraggableScrollableSheet(
                initialChildSize: 0.53,
                minChildSize: 0.53,
                maxChildSize: 0.88,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          //Header
                          SizedBox(
                            height: 21,
                            child: Center(
                              child: Container(
                                height: 5,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: const Color(0xffDDDDE3),
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTextBookName(context),
                                const SizedBox(
                                  height: 8,
                                ),
                                _buildAuthorInfo(context),
                                const _Space(),
                                _buildBookInfo(context),
                                const _Space(),
                                _buildStudyProgram(context),
                                const _Space(),
                                _buildReadingCommunity(context),
                                const _Space(),
                                _buildOtherBooks(context),
                                const SizedBox(
                                  height: 140,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              //Menu
              Positioned(
                  bottom: 50,
                  left: (sizeScreen.width - 200) / 2,
                  child: Container(
                    height: 80,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border:
                          Border.all(color: const Color(0xffe0f2f3), width: 3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MenuButton(
                          title: 'Vào học',
                          urlImage: MyImages.icPlayFillSVG,
                          onTap: () => Navigator.pushNamed(
                              context, RouteName.lessonDetailScreen),
                        ),
                        Container(
                          height: 58,
                          width: 2,
                          color: const Color(0xffe0f2f3),
                        ),
                        const MenuButton(
                            title: 'Bài tập',
                            urlImage: MyImages.icExerciseFillSVG),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtherBooks(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    height: 26,
                    width: 26,
                    child: Image.asset(MyImages.iCBook),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    thirdTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 95,
              child: InkWell(
                onTap: () => Navigator.pushNamed(
                    context, RouteName.recommendedBooksScreen),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      moreText,
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.28,
                        color: const Color(0xff009593),
                      ),
                    ),
                    const Icon(
                      Icons.navigate_next,
                      size: 16,
                      color: Color(0xff009593),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 132,
          child: ListView.separated(
            itemCount: listBooks.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Book book = listBooks[index];
              return MiniBookInfo(
                book: book,
                height: 132,
                width: 250,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 16,
            ),
          ),
        ),
      ],
    );
  }

  Container _buildReadingCommunity(BuildContext context) {
    return Container(
      height: 102,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SvgPicture.asset(MyImages.readingCommunitySVG),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 42,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            readingCommunityText,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            joinNowText,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.navigate_next,
              color: Color(0xff009593),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyProgram(BuildContext context) {
    return BlocBuilder<IsShowMoreStudyProgramBloc, bool>(
        builder: (context, isShowMore) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 26,
                width: 26,
                child: Image.asset(MyImages.iCOpenBook),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                secondTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                  text: "Chương I:\n",
                  style: Theme.of(context).textTheme.labelSmall),
              TextSpan(
                text: "Lấy lại gốc tiếng anh.\n\n",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextSpan(
                  text: "Chương II:\n",
                  style: Theme.of(context).textTheme.labelSmall),
              TextSpan(
                text:
                    "Kỹ năng bắt chuyện linh hoạt dựa vào những tình huống thực tế.\n\n",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextSpan(
                  text: "Chương III\n",
                  style: Theme.of(context).textTheme.labelSmall),
              TextSpan(
                text:
                    "Kỹ năng kéo dài, dẫn dắt câu chuyện bằng tiếng Anh một cách tự nhiên bằng kỹ thuật đặt câu hỏi ...",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          )),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => context
                  .read<IsShowMoreStudyProgramBloc>()
                  .add(ShowMoreStudyProgramEvent()),
              child: _buildButtonShowMore(context, isShowMore),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildBookInfo(BuildContext context) {
    return BlocBuilder<IsShowMoreBookInfoBloc, bool>(
        builder: (context, isShowMore) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 26,
                width: 26,
                child: Image.asset(MyImages.iCQuestionMark2),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                firstTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            contentOfFirstTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => context
                  .read<IsShowMoreBookInfoBloc>()
                  .add(ShowMoreBookInfoEvent()),
              child: _buildButtonShowMore(context, isShowMore),
            ),
          )
        ],
      );
    });
  }

  Row _buildAuthorInfo(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 26,
          width: 26,
          child: CircleAvatar(
            child: Image.asset(MyImages.circleWomenAvatar),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          fakeBook.authorName,
          style: Theme.of(context).textTheme.displayMedium,
        )
      ],
    );
  }

  Text _buildTextBookName(BuildContext context) {
    return Text(
      fakeBook.name,
      style: Theme.of(context).textTheme.titleLarge,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  _dialogDeleteBook(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: SvgPicture.asset(
                      MyImages.deleteBookSVG,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  deleteBookText,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  wantToDeleteBookText,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  yourVeryFirstEnglishText,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: ButtonActionDialog(
                          text: cancelText,
                          colorText: 0xff8b90a7,
                          colorButton: 0xffebebf0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: ButtonActionDialog(
                          text: deleteText,
                          colorText: 0xffFFFFFF,
                          colorButton: 0xffFF5C5C,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonShowMore(BuildContext context, bool isShowMore) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color(0xffebebf0),
        borderRadius: BorderRadius.all(Radius.circular(48)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              isShowMore ? 'THU GỌN' : 'XEM THÊM',
              style: Theme.of(context).textTheme.labelSmall,
              maxLines: isShowMore ? null : 6,
              overflow: TextOverflow.ellipsis,
            ),
            Icon(
              isShowMore ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: const Color(0xff8b90a7),
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}

class ButtonActionDialog extends StatelessWidget {
  final String text;
  final int colorButton;
  final int colorText;

  const ButtonActionDialog(
      {super.key,
      required this.text,
      required this.colorButton,
      required this.colorText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      decoration: BoxDecoration(
        color: Color(colorButton),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Center(
          child: Text(
        text,
        style: GoogleFonts.quicksand(
            fontSize: 16, fontWeight: FontWeight.w600, color: Color(colorText)),
      )),
    );
  }
}

class _Space extends StatelessWidget {
  const _Space();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 32,
    );
  }
}
