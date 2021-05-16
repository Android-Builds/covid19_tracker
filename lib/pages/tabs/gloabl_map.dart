import 'package:covid19_tracker/models/countryCoordinates.dart';
import 'package:flutter/material.dart';
import 'package:simple_map/simple_map.dart';

class GlobalMap extends StatefulWidget {
  final List infoList;

  const GlobalMap({Key key, this.infoList});
  @override
  _GlobalMapState createState() => _GlobalMapState();
}

class _GlobalMapState extends State<GlobalMap> {
  List<SimpleMapPoint> points = [];
  SimpleMapController controller = SimpleMapController();

  @override
  void initState() {
    var info = widget.infoList;
    info.forEach((element) {
      element.country = element.country
          .toString()
          .replaceAll('Bosnia', 'Bosnia and Herzegovina')
          .replaceAll('Cabo Verde', 'Cape Verde')
          .replaceAll('Congo', 'Congo [Republic]')
          .replaceAll('Czechia', 'Czech Republic')
          .replaceAll('DRC', 'Congo [DRC]')
          .replaceAll('Falkland Islands (Malvinas)',
              'Falkland Islands [Islas Malvinas]')
          .replaceAll('Holy See (Vatican City State)', 'Vatican City')
          .replaceAll('Lao People\'s Democratic Republic', 'Laos')
          .replaceAll('Macedonia', 'Macedonia [FYROM]')
          .replaceAll('Macao', 'Macau')
          .replaceAll('Palestine', 'Palestinian Territories')
          .replaceAll('Myanmar', 'Myanmar [Burma]')
          .replaceAll('S. Korea', 'South Korea')
          .replaceAll('Saint Pierre Miquelon', 'Saint Pierre and Miquelon')
          .replaceAll('Sao Tome and Principe', 'São Tomé and Príncipe')
          .replaceAll('South Sudan', 'Sudan')
          .replaceAll('Libyan Arab Jamahiriya', 'Libya')
          .replaceAll('Syrian Arab Republic', 'Syria')
          .replaceAll('UAE', 'United Arab Emirates')
          .replaceAll('UK', 'United Kingdom')
          .replaceAll('USA', 'United States');
    });
    info.sort((a, b) => a.cases.compareTo(b.cases));
    info.forEach((element) {
      double ratio = (element.cases / info.last.cases);
      double radius = ratio <= 0.001
          ? 1.5
          : ratio <= 0.01
              ? 2.0
              : 3.0;
      Color color = ratio <= 0.001
          ? Colors.yellow[700]
          : ratio <= 0.01
              ? Colors.red[200]
              : Colors.red[900];
      var dat = countryCoord[element.country];
      if (dat != null)
        points.add(SimpleMapPoint(
          lat: countryCoord[element.country]['lat'],
          lng: countryCoord[element.country]['lon'],
          color: color,
          radius: radius,
          ttl: Duration(hours: 100),
          state: SimpleMapPointState.showing,
        ));
    });
    controller = SimpleMapController(points: points);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.only(bottom: size.height * 0.25),
        width: size.width * 2,
        height: size.height,
        child: SimpleMap(
          controller: controller,
          options: SimpleMapOptions(mapColor: Colors.white),
        ),
      ),
    );
  }
}
