class Exercise {
  String name;
  String urlIcon;
  int numberPage;
  String info;
  String time;

  Exercise(
      {required this.name,
      required this.urlIcon,
      required this.numberPage,
      required this.info,
      this.time = '00:00:00'});
}
