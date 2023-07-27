import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:food_app/search.dart';
import 'package:http/http.dart ';
import 'package:food_app/worker.dart';
import 'package:food_app/View.dart';
import 'package:food_app/loading.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
      var r="reciepe";
      final _random=new Random();
      var re = r[_random.nextInt(r.length)];
       setState(() {
         isLoading=false;
       });
      });

     reciepelist.forEach((reciepe) {
        print(reciepe.applabel);
       // print(reciepe.appcalories);
          print(reciepe.apptime);
      });
    }

    @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getRecipe("re");
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
                 margin: EdgeInsets.symmetric(horizontal: 24,vertical: 20),

                 decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(40)
                 ),

               child:Row(
                 children:<Widget> [
                   SizedBox(width: 20,),
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
                      GestureDetector(

                        onTap: (){

                         if((searchcontroller.text).replaceAll(" ", "") == ""){
                           print("blank screen");
                         }
                         else{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Search(searchcontroller.text)));
                         }
                        },

                        child: Container(



                           margin: EdgeInsets.symmetric(horizontal: 14,vertical:10 ),

                          child: Icon(Icons.search_sharp,size: 35,),

                          ),
                      ),


                 ],
               )
               ),

           ),
               Container(
                 margin: EdgeInsets.symmetric(horizontal: 23),
               //
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("WHAT DO YOU WANT TO COOK TODAY?",style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold,color:Colors.white)),
                     SizedBox(height: 10,),
                     Text("Let's Cook !",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                   ],
                 ),
               ),
               // Container(
               //   height: 100,
               //   child: ListView.builder( itemCount: reciptCatList.length, shrinkWrap: true,
               //       scrollDirection: Axis.horizontal,
               //       itemBuilder: (context, index){
               //
               //         return Container(
               //             child: InkWell(
               //               onTap: () {
               //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>))
               //               },
               //               child: Card(
               //                   margin: EdgeInsets.fromLTRB(4, 10, 10, 5),
               //                   shape: RoundedRectangleBorder(
               //                     borderRadius: BorderRadius.circular(18),
               //                   ),
               //                   elevation: 0.0,
               //                   child:Stack(
               //                     children: [
               //                       ClipRRect(
               //                           borderRadius: BorderRadius.circular(18.0),
               //                           child: Image.network(reciptCatList[index]["imgUrl"], fit: BoxFit.cover,
               //                             width: 200,
               //                             height: 250,)
               //                       ),
               //                       Positioned(
               //                           left: 0,
               //                           right: 0,
               //                           bottom: 0,
               //                           top: 0,
               //                           child: Container(
               //                               padding: EdgeInsets.symmetric(
               //                                   vertical: 5, horizontal: 10),
               //                               decoration: BoxDecoration(
               //                                   color: Colors.black26),
               //                               child: Column(
               //                                 mainAxisAlignment: MainAxisAlignment.center,
               //                                 children: [
               //                                   Text(
               //                                     reciptCatList[index]["heading"],
               //                                     style: TextStyle(
               //                                         color: Colors.white,
               //                                         fontSize: 28),
               //                                   ),
               //                                 ],
               //                               ))),
               //                     ],
               //                   )
               //               ),
               //             )
               //         );
               //       }),
               // ),
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

                       margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(20),

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
                                 height: 200,
                               )),
                             Positioned(
                                 left: 0,
                                 right: 0,
                                 bottom: 0,
                                 child: Container(
                                     padding: EdgeInsets.symmetric(
                                         vertical: 5, horizontal: 10),
                                     decoration: BoxDecoration(
                                         color: Colors.black26),
                                     child: Text(
                                       reciepelist[index].applabel,
                                       style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 20,
                                       fontWeight: FontWeight.bold),
                                     ))),
                             Positioned(
                               right: 0,
                               height: 40,
                               width: 80,
                               child: Container(
                                   decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.only(
                                           topRight: Radius.circular(10),
                                           bottomLeft: Radius.circular(10)
                                       )
                                   ),
                                   child: Center(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Icon(Icons.local_fire_department, size: 15,),
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
