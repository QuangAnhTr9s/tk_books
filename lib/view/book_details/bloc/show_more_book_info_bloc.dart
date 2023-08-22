import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tk_books/view/book_details/event/show_more_book_info_event.dart';

class IsShowMoreBookInfoBloc extends Bloc<IsShowMoreBookInfoEvent, bool> {
  static const initIsShowMore = false;

  IsShowMoreBookInfoBloc() : super(false) {
    on<ShowMoreBookInfoEvent>(
      (event, emit) => _showMore(emit),
    );
  }

  _showMore(Emitter<bool> emit) {
    emit(!state);
  }
}
