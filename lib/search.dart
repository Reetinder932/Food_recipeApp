import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart ';
import 'package:food_app/worker.dart';
import 'package:food_app/View.dart';
class Search extends StatefulWidget {
 String query;
 Search(this.query);


  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  bool isLoading=true;
  TextEditingController searchcontroller=new TextEditingController();
  // String url="https://api.edamam.com/search?q=chicken&app_id=5aa58b16&app_key=2d88cb812911ae9b8b5ce4f129ddfdf9";
  List<ReciepeModel> reciepelist=<ReciepeModel>[];
  List reciptCatList = [{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"}];

  getRecipe(String query) async {
    String url="https://api.edamam.com/search?q=$query&app_id=5aa58b16&app_key=2d88cb812911ae9b8b5ce4f129ddfdf9";
    Response response=await get(Uri.parse(url));
    Map data=jsonDecode(response.body);
    //  log(data.toString());
    data["hits"].forEach((element){
      ReciepeModel reciepeModel=new ReciepeModel();
      reciepeModel=ReciepeModel.fromMap(element["recipe"]);
      reciepelist.add(reciepeModel);
      // log(reciepelist.toString());
      setState(() {
        isLoading=false;
      });
    });

    reciepelist.forEach((reciepe) {
      print(reciepe.applabel);
      print(reciepe.appcalories);

    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getRecipe(widget.query);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xff213A50),
                      Color(0xff071938)
                    ]
                )
            ),
          ),

          SingleChildScrollView(
            child: Column(

              children: <Widget>[
                SafeArea(
                  child:Container(
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.symmetric(horizontal: 24,vertical: 5),

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)
                      ),

                      child:Row(
                        children:<Widget> [
                          GestureDetector(

                            onTap: (){

                              if((searchcontroller.text).replaceAll(" ", "") == ""){
                                print("blank screen");
                              }
                              else{
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Search(searchcontroller.text)));
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 4,vertical: 3),
                              child: Icon(Icons.search,size: 30,),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: TextField(
                              controller: searchcontroller,
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  border:InputBorder.none,
                                  hintText: "Search here for receipe"
                              ),
                            ),
                          ),
                        ],
                      )
                  ),

                ),

                Container(
                    child: isLoading? CircularProgressIndicator() : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: reciepelist.length,
                        itemBuilder:(context,index){
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SView(reciepelist[index].appurl)));
                            },
                            child: Card(
                              margin: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        reciepelist[index].appimgurl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 300,
                                      )),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey),
                                          child: Text(
                                            reciepelist[index].applabel,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ))),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,

                                    height: 30,
                                    width: 90,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10)
                                            )
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,

                                            children: [
                                              Icon(Icons.local_fire_department, size: 30,),
                                              Text(reciepelist[index].appcalories.toString().substring(0, 6),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                            ],
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          );

                          // return Text("hahahahahahahhahahahah",style: TextStyle(color: Colors.white),);
                        })
                ),

              ],
            ),
          ),


        ],
      ),
    );
  }
}
