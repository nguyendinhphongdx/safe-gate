class OptionCheckBox<T> {
  int? id;
  late String title;
  late bool isCheck;
  T data;

  OptionCheckBox({
    required this.title,
    required this.data,
    this.isCheck = false,
    this.id,
  });

}
