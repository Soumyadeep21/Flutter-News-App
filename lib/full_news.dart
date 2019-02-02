import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/cupertino.dart';

class FullNews extends StatefulWidget {

  String imgPath,title,content,url,source;
  FullNews({this.imgPath,this.url,this.title,this.content,this.source});

  @override
  _FullNewsState createState() => _FullNewsState();
}

class _FullNewsState extends State<FullNews> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Align(
              alignment: Alignment(-1.05, 1),
                child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: ()=> Navigator.of(context).pop()
                )
            ),
            Hero(
                tag: widget.imgPath,
                child: Image.network(widget.imgPath)
            ),
            Padding(padding: EdgeInsets.only(top: 8.0)),
            Text(
              widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 8.0),),
            Text(
                widget.content,
                style: TextStyle(
                  fontSize: 20.0
                ),
            ),
            Padding(padding: EdgeInsets.only(top: 6.0)),
            FlatButton.icon(
              icon: Icon(Icons.open_in_new),
                label: Text("Read Full Story"),
                onPressed: ()=>Navigator.of(context).push(
                   CupertinoPageRoute(builder: (context)=> WebviewScaffold(
                      url: widget.url,
                      withZoom: true,
                      appBar: AppBar(title: Text(widget.source),),
                    initialChild: Center(child: CircularProgressIndicator()),
                  )
                  ),
                ),
            ),
          ],
        ),
      )
    );
  }
}
