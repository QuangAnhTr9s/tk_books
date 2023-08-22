import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tk_books/component/back_button_appbar.dart';
import 'package:tk_books/component/mini_book_info.dart';
import 'package:tk_books/shared/fake_data/fake_data_book.dart';

import '../../../model/book.dart';

class RecommendedBooksScreen extends StatelessWidget {
  const RecommendedBooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Book> listBook = FakeDataBook().listBooks;
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: statusBarHeight,
          ),
          Expanded(
            child: Stack(
              children: [
                //back ground
                Positioned.fill(
                  child: Container(
                    color: const Color(0xfff2f7f7),
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
                          BackButtonAppBar(backgroundColor: Colors.grey.shade400, iconColor: Colors.white),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Sách liên quan',
                                style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(width: 32),
                        ],
                      ),
                    )),
                Positioned(
                    top: 88,
                    left: 20,
                    right: 20,
                    bottom: 0,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: listBook.length,
                      itemBuilder: (context, index) {
                        Book book = listBook[index];
                        return MiniBookInfo(
                            width: double.infinity, height: 132, book: book);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

