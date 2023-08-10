import 'package:flutter/material.dart';
import 'package:food_app/recipe_api.dart';
import 'package:food_app/model.dart';
import 'package:food_app/view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;
  final _searchcontroller = TextEditingController();
  List<ReciepeModel> _reciepelist = <ReciepeModel>[];

  Future<void> _search(String recipe) async {
    final recipes = await RecipeApi.getRecipes(recipe);
    setState(() {
      _reciepelist = recipes;
    });
  }

  @override
  void initState() {
    RecipeApi.getRecipes(null).then((recipes) {
      setState(() {
        _reciepelist = recipes;
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff213A50), Color(0xff071938)])),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _searchcontroller,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search here for receipe"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_searchcontroller.text.trim().isEmpty) {
                                debugPrint("blank screen");
                              } else {
                                _search(_searchcontroller
                                    .text); //I thinks it's better using same page for searching
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              child: const Icon(
                                Icons.search_sharp,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 23),
                  //
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("WHAT DO YOU WANT TO COOK TODAY?",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Let's Cook !",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
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
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _reciepelist.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SView(_reciepelist[index].url)));
                                },
                                child: Card(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 0.0,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            _reciepelist[index].imgurl,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 200,
                                          )),
                                      Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              decoration: const BoxDecoration(
                                                  color: Colors.black26),
                                              child: Text(
                                                _reciepelist[index].label,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))),
                                      Positioned(
                                        right: 0,
                                        height: 40,
                                        width: 80,
                                        child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10))),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.local_fire_department,
                                                    size: 15,
                                                  ),
                                                  Text(
                                                    _reciepelist[index]
                                                        .calories
                                                        .toString()
                                                        .substring(0, 6),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              );

                              // return Text("hahahahahahahhahahahah",style: TextStyle(color: Colors.white),);
                            })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
