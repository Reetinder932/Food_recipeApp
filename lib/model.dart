class ReciepeModel {
  final String label;
  final String imgurl;
  final double calories;
  final String url;
  final double time;

  ReciepeModel(
      {required this.label,
      required this.imgurl,
      required this.calories,
      required this.url,
      required this.time});

  ReciepeModel.fromMap(Map reciepe)
      : label = reciepe["label"],
        calories = reciepe["calories"],
        imgurl = reciepe["image"],
        url = reciepe["url"],
        time = reciepe["totalTime"];

  @override
  String toString() =>
      "Reciepe[ Label: $label, Calories: $calories, Time: $time ]";
}
