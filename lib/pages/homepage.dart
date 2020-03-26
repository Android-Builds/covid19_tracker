import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/pages/splashscreen.dart';
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

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  List<Info> duplicateItems;
  List<Info> items;

  Future<Null> _refresh() {
    // return fetchPost().then((_posts) {
    //   setState(() {
    //     localposts = _posts;
    //   });
    // });
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
              title: Text(
                widget.title,
                style: TextStyle(
                  color: getColor(context),
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              bottom: TabBar(
                tabs: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Global',
                      style: TextStyle(
                        color: getColor(context)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Countries',
                      style: TextStyle(
                        color: getColor(context)
                      ),                      
                    ),
                  ),
                ]
              ),
              actions: <Widget>[
                IconButton(
                  color: getColor(context),
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

var suggestionlist;

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
          query = '';
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
    //Implement buildResults
    return AllCountries(info: suggestionlist);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //search suggestions
    suggestionlist = query.isEmpty ? list 
    : list.where((element) => element.country.startsWith(query.substring(0,1)
    .toUpperCase() + query.substring(1,query.length))).toList();
    return AllCountries(info: suggestionlist);
  }
  
}