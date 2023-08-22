import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tk_books/view/exercise_detail/event/is_choose_page_event.dart';

class IsChoosePageBloc extends Bloc<IsChoosePageEvent, int> {
  static int index = 0;
  IsChoosePageBloc() : super(0) {
    on<ChoosePageEvent>(_choosePage);
  }

 /* void _choosePage(IsChoosePageEvent event, Emitter<IsChoosePageEvent> emitter) {
    emit(index = newIndex);
  }*/


  FutureOr<void> _choosePage(ChoosePageEvent event, Emitter<int> emit) {
    emit(event.newIndex);
  }
}
