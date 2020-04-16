import 'package:covid19_tracker/models/datasearch.dart';
import 'package:covid19_tracker/models/ind.dart';
import 'package:covid19_tracker/widgets/themes.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';

class StatePage extends StatefulWidget {
  const StatePage({Key key}) : super(key: key);
  @override
  _StatePageState createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {

  List<StateData> states = new List<StateData>();

  @override
  void initState() {
    super.initState();
    if(states != null){   
      getStateData().then((value){
        setState(() {
          states = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'State Cases',
            style: TextStyle(
              color: getColor(context)
            ),
          ),
          iconTheme: getIconTheme(context),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              color: getColor(context),
              onPressed: () {
                showSearch(context: context,
                delegate: DataSearch(states: states));
              },
              icon: Icon(Icons.search),
              splashColor: Colors.transparent
            ),
          ],
        ),
        body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (states != null)
              return StateBuilder(states: states);
            else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).backgroundColor,
                ),
              );
            }
          }
        ),
      ),
    );
  }
}

class StateBuilder extends StatelessWidget {
  StateBuilder({
    Key key,
    @required this.states,
  }) : super(key: key);

  final List<StateData> states;
  final ScrollController controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    int count = (states.length == 0 ? 0 : states.length -1);
    return DraggableScrollbar.semicircle(
      heightScrollThumb: 42.0,
      backgroundColor: getTheme(context) == 'Dark' ? Colors.black : Colors.white,
      labelTextBuilder: (offset) {
        final int currentItem = controller.hasClients
            ? (controller.offset /
                    controller.position.maxScrollExtent *
                    count)
                .floor()
            : 0;
        return Text(
          "$currentItem",
          style: TextStyle(
            color: getColor(context),
          ),
        );
      },
      labelConstraints: BoxConstraints.tightFor(width: 40.0, height: 30.0),
      controller: controller,
      child: ListView.builder(
        itemCount: count,
        controller: controller,
        itemBuilder:(_,index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              height: 380.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    states[index+1].state,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                    child: Divider(
                      thickness: 2.0,
                    ),
                  ),
                  StateStat(text: 'Confirmed', total: states[index+1].confirmed, today: states[index+1].deltaconfirmed),
                  SizedBox(height: 30.0),
                  StateStat(text: 'Deaths', total: states[index+1].deaths, today: states[index+1].deltadeaths),
                  SizedBox(height: 30.0),
                  StateStat(text: 'Recovered', total: states[index+1].recovered, today: states[index+1].deltarecovered),
                  SizedBox(height: 40.0),
                  Text(
                    'Active Cases: ' + states[index+1].active,
                    style: stateCardCases,
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

class StateStat extends StatelessWidget {
  const StateStat({
    Key key,
    this.today, this.total,
      this.text,
  }) : super(key: key);

  final String text, total, today;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          text,
          style: stateCardCases
        ),
        Spacer(),
        Column(
          children: <Widget>[
            Text(
              'Total',
              style: globalTile,
            ),
            SizedBox(height: 10.0),
            Text(total),
          ],
        ),
        SizedBox(width: 60.0),
        Column(
          children: <Widget>[
            Text(
              'Today',
              style: globalTile,
            ),
            SizedBox(height: 10.0),
            Text(today),
          ],
        ),
        SizedBox(width: 20.0),
      ],
    );
  }
}