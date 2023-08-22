import '../../model/book.dart';
import '../const/images.dart';

class FakeDataBook {
  //fake data book
  List<Book> listBooks = [
    Book("Your very first English - Tự học tiếng Anh cấp tốc", 'The Windy',
        '100.000', '', '', MyImages.bookPhoto),
    Book("Ngữ pháp và giải thích ngữ pháp", 'The Windy', '100.000', '', '',
        MyImages.bookPhoto),
  ];
}
