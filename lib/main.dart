import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cocktail Recipe App',
      home: MyHomePage(title: 'Flutter Cocktail Recipe App'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _url = "https://www.thecocktaildb.com/api/json/v1/1/random.php";
  StreamController _streamController;
  Stream _stream;
  Response response;

  getCocktailRecipes() async {
    _streamController.add("waiting");
    response = await get(_url);
    _streamController.add(json.decode(response.body));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
    getCocktailRecipes();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body:  RefreshIndicator(
        onRefresh: () {
          return getCocktailRecipes();
        },
        child: Center(
          child: StreamBuilder(
            stream: _stream,
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == "waiting") {
                return Center(child: Text("Waiting of the Cocktail Recipe....."));
              }
              return Center(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int i) {
                      return Center(
                        child: ListBody(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 10.0,right: 10.0,top:8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/loading.gif',
                                  image:  snapshot.data['drinks'][0]['strDrinkThumb'],
                                ),),
                            ),
                            Card(
                              elevation: 2.0,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0,right: 5.0,top:4.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text( snapshot.data['drinks'][0]['strDrink'],
                                        style: TextStyle(letterSpacing: 0.6,fontSize: 18.0),),
                                        Container(
                                          margin: EdgeInsets.only(top: 4,left: 8.0),
                                          child: Text("( "+snapshot.data['drinks'][0]['strAlcoholic']+" )",
                                            style: TextStyle(fontSize: 12.0),),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 2.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0,right: 5.0,top:8.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: [
                                            Text("Ingredients",
                                              style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),),
                                            Container(
                                              margin: EdgeInsets.only(top: 4.0),
                                              width: 90.0,
                                              height: 1.0,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10.0),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ( snapshot.data['drinks'][0]['strIngredient1']!= null && snapshot.data['drinks'][0]['strIngredient1']!= "")  ? Text("1. "+snapshot.data['drinks'][0]['strIngredient1'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient2']!= null && snapshot.data['drinks'][0]['strIngredient2']!= "") ? Text("2. "+snapshot.data['drinks'][0]['strIngredient2'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient3']!= null && snapshot.data['drinks'][0]['strIngredient3']!= "")  ? Text("3. "+snapshot.data['drinks'][0]['strIngredient3'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient4']!= null && snapshot.data['drinks'][0]['strIngredient4']!= "")  ? Text("4. "+snapshot.data['drinks'][0]['strIngredient4'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient5']!= null && snapshot.data['drinks'][0]['strIngredient5']!= "") ? Text("5. "+snapshot.data['drinks'][0]['strIngredient5'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient6']!= null && snapshot.data['drinks'][0]['strIngredient6']!= "") ? Text("6. "+snapshot.data['drinks'][0]['strIngredient6'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient7']!= null && snapshot.data['drinks'][0]['strIngredient7']!= "")  ? Text("7. "+snapshot.data['drinks'][0]['strIngredient7'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient8']!= null && snapshot.data['drinks'][0]['strIngredient8']!= "")  ? Text("8. "+snapshot.data['drinks'][0]['strIngredient8'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient9']!= null && snapshot.data['drinks'][0]['strIngredient9']!= "")  ? Text("9. "+snapshot.data['drinks'][0]['strIngredient9'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient10']!= null && snapshot.data['drinks'][0]['strIngredient10']!= "") ? Text("10. "+snapshot.data['drinks'][0]['strIngredient10'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient11']!= null && snapshot.data['drinks'][0]['strIngredient11']!= "")  ? Text("11. "+snapshot.data['drinks'][0]['strIngredient11'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient12']!= null && snapshot.data['drinks'][0]['strIngredient12']!= "")  ? Text("12. "+snapshot.data['drinks'][0]['strIngredient12'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient13']!= null && snapshot.data['drinks'][0]['strIngredient13']!= "") ? Text("12. "+snapshot.data['drinks'][0]['strIngredient13'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient14']!= null && snapshot.data['drinks'][0]['strIngredient14']!= "") ? Text("14. "+snapshot.data['drinks'][0]['strIngredient14'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                          ( snapshot.data['drinks'][0]['strIngredient15']!= null && snapshot.data['drinks'][0]['strIngredient15']!= "") ? Text("15. "+snapshot.data['drinks'][0]['strIngredient15'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),): Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Card(
                              elevation: 2.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0,right: 5.0,top:8.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: [
                                            Text("Instructions",
                                              style: TextStyle(letterSpacing: 0.5,fontSize: 15.0),),
                                            Container(
                                              margin: EdgeInsets.only(top: 4.0),
                                              width: 90.0,
                                              height: 1.0,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10.0),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data['drinks'][0]['strInstructions'],
                                            style: TextStyle(letterSpacing: 0.5,fontSize: 14.0),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              );
            },
          ),
        ),
      ),
    );
  }
}
