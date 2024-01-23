// 4 menus displayed 2 * 2
import 'package:flutter/material.dart';
import '/views/search_view/search_view.dart';

class main_menu_view extends StatefulWidget {
  const main_menu_view({Key? key}) : super(key: key);

  @override
  _main_menu_viewState createState() => _main_menu_viewState();
}

class _main_menu_viewState extends State<main_menu_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Main Menu',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => search_view()),
                );
              },
              child: Text('search_view'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => search_view()),
                );
              },
              child: Text('num_view'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => search_view()),
                );
              },
              child: Text('num_view'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => search_view()),
                );
              },
              child: Text('num_view'),
            ),
          ],
        ),
      ),
    );
  }
}