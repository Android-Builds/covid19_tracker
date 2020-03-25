import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/pages/tabs/allcountries.dart';
import 'package:covid19_tracker/pages/tabs/global.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.latest, this.info}) 
  : super(key: key);
  final String title;
  final Latest latest;
  final List<Info> info;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    items = duplicateItems = widget.info;
  }

  List<Info> duplicateItems;
  List<Info> items;

  void filterSearchResults(String query) {
    List<Info> dummySearchList = List<Info>();
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<Info> dummyListData = List<Info>();
      // dummySearchList.forEach((item) {
      //   if(item.country.contains(query)) {
      //     dummyListData.add(item);
      //   }
      // });
      for(int i=0; i<dummySearchList.length; i++) {
        if(dummySearchList[i].country == query) {
          dummyListData.add(widget.info[i]);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark().copyWith(
        backgroundColor: Colors.black
      ),
      home: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              bottom: TabBar(
                tabs: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Global'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Countries'),
                  ),
                ]
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: DataSearch(list: items));
                  },
                  icon: Icon(Icons.search),
                  splashColor: Colors.transparent,
                )
              ],
            ),
            body: TabBarView(
              children: <Widget>[
                GlobalPage(latest: widget.latest, info: items),
                AllCountries(info: widget.info)
              ],
            )
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate {

  DataSearch({this.list});

  List<Info> list;

  @override
  List<Widget> buildActions(BuildContext context) {
    //action for app bar
    return[
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () {
        }
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return themeData.copyWith(
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //search suggestions
    return Container(
      color: Theme.of(context).backgroundColor,
    );
  }
  
}