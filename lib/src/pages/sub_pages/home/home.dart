import 'package:antpire/config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final images = [
    'images/home/banner.jpg',
    'images/home/learn.jpg',
    'images/home/piggy.jpg',
    'images/home/piggybank.jpg',
    'images/home/plant.jpg',
    'images/home/what.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
              autoPlay: true,
              height: Config.screenHeight! * 0.25,
              viewportFraction: 1),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index, int pageIndex) =>
              SizedBox(
            width: Config.screenWidth! - 1,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: AssetImage(images[index]),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Card(
                elevation: 5,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {},
                  child: const SizedBox(
                    width: 300,
                    height: 100,
                    child: Text('A card that can be tapped'),
                  ),
                ),
              );
            })
      ],
    );
  }
}
