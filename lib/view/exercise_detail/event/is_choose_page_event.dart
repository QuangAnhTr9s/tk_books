abstract class IsChoosePageEvent {}

class ChoosePageEvent extends IsChoosePageEvent {
  int newIndex;
  ChoosePageEvent({required this.newIndex});
}
