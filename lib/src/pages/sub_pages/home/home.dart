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
    'https://e7.pngegg.com/pngimages/721/1001/png-clipart-money-bag-cartoon-tomorrow-sign-s-cartoon-animation.png',
    'https://c8.alamy.com/compes/b1m3wf/ilustracion-de-dibujos-animados-de-monedas-y-dinero-en-efectivo-b1m3wf.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(height: Config.screenHeight! * 0.25),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index, int pageIndex) =>
              Container(
                  margin: EdgeInsets.all(1),
                  color: Colors.grey[300],
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  )),
        ),
        Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {},
            child: const SizedBox(
              width: 300,
              height: 100,
              child: Text('A card that can be tapped'),
            ),
          ),
        ),
      ],
    );
  }
}
