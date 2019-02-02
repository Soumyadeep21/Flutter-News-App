import 'package:flutter/material.dart';
import 'package:flutter_news/full_news.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsApp extends StatefulWidget {
  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {

  String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=025c363f443b4800ae52359473183303";

  bool isDataLoaded = false;
  List data;
  String imgPath;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
      Uri.encodeFull(url),
    );
    print(response.body);
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['articles'];
      isDataLoaded = true;
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    if(isDataLoaded)
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,i){
          imgPath = data[i]['urlToImage'];
          return Padding(
            padding: EdgeInsets.only(top: 8.0,left: 20.0,right: 20.0),
            child: InkWell(splashColor: Colors.green,
              onTap: ()=>Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context)=>FullNews(
                      imgPath: data[i]['urlToImage'],
                      title: data[i]['title'],
                      content: data[i]['content'],
                      url: data[i]['url'],
                      source: data[i]['source']['name'],
                  ),
                ),
              ),
              child: Card(
                elevation: 20.0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Hero(
                          tag: imgPath,
                          child :Image.network(imgPath),
                      ),
                      Text(
                        data[i]['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            fontStyle: FontStyle.italic
                        ),
                      ),
                      Text(
                          data[i]['description'],
                          style: TextStyle(
                            fontSize: 17
                          ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
    else
      return Container(child: Center(child: CircularProgressIndicator()),);
  }
}
