import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid19_tracker/models/info.dart';
import 'package:covid19_tracker/models/stats.dart';
import 'package:covid19_tracker/pages/homepage/widgets/line_graph.dart';
import 'package:covid19_tracker/pages/homepage/widgets/pie_chart.dart';
import 'package:flutter/material.dart';

class CaseCharts extends StatelessWidget {
  final Stats stats;
  final Latest latest;

  const CaseCharts({this.stats, this.latest});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: size.height * 0.45,
        child: CarouselSlider(
          items: [
            GloabalGraph(stats: stats),
            CasePieChart(info: latest),
          ],
          options: CarouselOptions(
            height: 400,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }
}
