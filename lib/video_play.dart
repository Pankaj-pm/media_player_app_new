import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Videoplay extends StatefulWidget {
  const Videoplay({super.key});

  @override
  State<Videoplay> createState() => _VideoplayState();
}

class _VideoplayState extends State<Videoplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Slider")),
      body: Column(
        children: [
          CarouselSlider(
              items: [
                Container(color: Colors.red),
                Container(color: Colors.blueAccent),
                Container(color: Colors.yellow),
                Container(color: Colors.grey),
              ],
              options: CarouselOptions(
                // height: 300,
                autoPlay: true,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                aspectRatio: 1,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(milliseconds: 500),
                onPageChanged: (index, reason) {
                  print("index $index");
                },
              )),
          SizedBox(
            height: 20,
            child: ListView.builder(itemBuilder: (context, index) => Container(color: Colors.grey),),
          ),
        ],
      ),
    );
  }
}
