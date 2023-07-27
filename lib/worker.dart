class ReciepeModel{
  late String applabel;
  late String appimgurl;
  late double appcalories;
  late String appurl;
  late double apptime;

ReciepeModel({this.applabel="abc", this.appimgurl="a",this.appcalories=1.23,this.appurl="c",this.apptime=12.3});
factory ReciepeModel.fromMap(Map reciepe)
{
   return ReciepeModel(
      applabel: reciepe["label"],
      appcalories: reciepe["calories"],
      appimgurl: reciepe["image"],
      appurl: reciepe["url"],
       apptime: reciepe["totalTime"]
   );
}
}