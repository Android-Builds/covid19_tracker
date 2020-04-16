import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/pages/statepage.dart';
import 'package:covid19_tracker/pages/tabs/allcountries.dart';
import 'package:flutter/material.dart';

var suggestionlist;

class DataSearch extends SearchDelegate {

  DataSearch({this.info, this.states});

  List<Info> info;
  List states;

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
    return info != null ? AllCountries(info: suggestionlist) 
      : StateBuilder(states: suggestionlist);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //search suggestions
    info != null ?
    suggestionlist = query.isEmpty ? info 
    : info.where((element) => element.country.startsWith(query.substring(0,1)
    .toUpperCase() + query.substring(1,query.length))).toList()
    :suggestionlist = query.isEmpty ? states 
    : states.where((element) => element.state.startsWith(query.substring(0,1)
    .toUpperCase() + query.substring(1,query.length))).toList();
    
    return info != null ? AllCountries(info: suggestionlist) 
      : StateBuilder(states: suggestionlist);
  }
  
}