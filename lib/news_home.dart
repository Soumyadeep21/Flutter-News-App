import 'package:flutter/material.dart';
import 'package:flutter_news/Business.dart';
import 'package:flutter_news/headlines.dart';
import 'package:flutter_news/sports.dart';
import 'package:flutter_news/technology.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsHome extends StatefulWidget {

  @override
  NewsHomeState createState() {
    return new NewsHomeState();
  }
}

class NewsHomeState extends State<NewsHome> with AutomaticKeepAliveClientMixin{

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _willDisplayBottomSheet = true;
  LinearGradient gradient = LinearGradient(colors: [Colors.black,Colors.grey,Colors.blueGrey],begin: Alignment.bottomRight,end: Alignment.topLeft);

  final  _pages = [
    HeadlinesPage(),
    SportsPage(),
    TechnologyPage(),
    BusinessPage()
  ];
  int _currentPage = 0;

  void changePage(int i){
    setState(() {
      _currentPage = i;
      updateKeepAlive();
    });
  }

  _launchUrl(String url) async{
    if(await canLaunch(url))
      launch(url);
    else
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Error in opening url")));
  }

  void displayDeveloperInfo(){
    if(_willDisplayBottomSheet) {
      _willDisplayBottomSheet = false;
      _scaffoldKey.currentState.
      showBottomSheet((context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(gradient: gradient),
          child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: Chip(label: Text("APP INFO",style: TextStyle(fontSize: 15.0),))),
                  Spacer(),
                  Chip(label: Text("  DEVELOPED BY  :   SOUMYADEEP SINHA"),avatar: Icon(Icons.android),),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(MdiIcons.facebookBox,size: 40.0,),
                          onPressed: (){
                            _launchUrl("https://www.facebook.com/soumyadeep.sinha21");
                          }
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(MdiIcons.instagram,size: 40.0,),
                          onPressed: (){
                            _launchUrl("https://www.instagram.com/s.o.u.m.y.a.d.e.e.p");
                          }
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(MdiIcons.twitterBox,size: 40.0,),
                          onPressed: (){
                            _launchUrl("https://twitter.com/IISoumyadeepII");
                          }
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(MdiIcons.githubBox,size: 40.0,),
                          onPressed: (){
                            _launchUrl("https://github.com/Soumyadeep21");
                          }
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(MdiIcons.linkedinBox,size: 40.0,),
                          onPressed: (){
                            _launchUrl("https://www.linkedin.com/in/soumyadeep-sinha-80362416b/");
                          }
                      )
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                      child: Chip(label: Text("  TECHNOLOGY USED   :   FLUTTER"),avatar: FlutterLogo(),),
                      onTap: (){
                        _launchUrl("https://flutter.dev/");
                      },
                  ),
                  Spacer(),
                  ListTile(
                    leading: Icon(MdiIcons.githubCircle,size: 40.0,),
                    title: Text("WOW ! THIS APP IS OPEN SOURCED . CLICK TO KNOW MORE."),
                    onTap: (){
                      _launchUrl("https://github.com/Soumyadeep21/Flutter-News-App");
                    },
                  )
                ],
              ),
          ),
        );
      }).closed.whenComplete(() {
        _willDisplayBottomSheet = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Material(
        child: Scaffold(
          /*appBar: AppBar(
            centerTitle: true,
            title: Text(
              "N e w s   A p p",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0
              ),
            ),
          ),*/
          key: _scaffoldKey,
          body: _pages[_currentPage],
          floatingActionButton: FloatingActionButton(
              onPressed: displayDeveloperInfo,
              child: Icon(Icons.info),
              backgroundColor: Colors.orange,
              tooltip: "App Info",
              mini: true,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentPage,
            //fixedColor: Colors.greenAccent,
              //type: BottomNavigationBarType.shifting,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(MdiIcons.fire),
                    title: Text("Headlines"),
                    backgroundColor: Colors.redAccent
                ),
                BottomNavigationBarItem(
                  icon: Icon(MdiIcons.run),
                  title: Text("Sports"),
                  backgroundColor: Colors.blueAccent
                ),
                BottomNavigationBarItem(
                  icon: Icon(MdiIcons.cellphoneAndroid),
                  title: Text("Technology"),
                  backgroundColor: Colors.green
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.attach_money),
                  title: Text("Business"),
                  backgroundColor: Colors.amber
                ),
              ],
              onTap: (int index) => changePage(index)
          ),
        ),
      ),
      onWillPop: (){},
    );

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;



}

