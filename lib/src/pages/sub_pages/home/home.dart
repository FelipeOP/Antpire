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
        // CarouselSlider(
        //   options: CarouselOptions(height: Config.screenHeight! * 0.25),
        //   items: [1, 2, 3, 4, 5].map((i) {
        //     return Builder(
        //       builder: (BuildContext context) {
        //         return Container(
        //             // width: MediaQuery.of(context).size.width,
        //             // margin: EdgeInsets.symmetric(horizontal: 5.0),
        //             decoration: BoxDecoration(color: Colors.amber),
        //             child: Text(
        //               'text $i',
        //               style: TextStyle(fontSize: 16.0),
        //             ));
        //       },
        //     );
        //   }).toList(),
        // )
      ],
    );
  }
}
