import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev/home.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int slider_index = 0;
  final List<String> imgList = [
    "assets/images/ilust.png",
    "assets/images/ilust2.png",
    "assets/images/ilust3.png",
    "assets/images/ilust4.png",
  ];
  final List<String> txtList = [
    "Tentukan Tujuan Investasimu dengan \n fitur Goal Planner PNM Sijago",
    "Pantau Portofoliomu \n menggunakan Aplikasi PNM Sijago",
    "Diawasi oleh OJK",
    "Cocok untuk Investor pemula",
  ];
  CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 44, right: 289),
                child: Image.asset("assets/logo/logo.png",
                    fit: BoxFit.fill, height: 60, width: 60)),
            SizedBox(
              height: 70,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 220,
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    carouselController: _controller,
                    itemBuilder: (BuildContext c, int index, i) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            imgList[index],
                            fit: BoxFit.fill,
                            height: 150,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            txtList[index],
                            style: GoogleFonts.roboto(fontSize: 12),
                            textAlign: TextAlign.center,
                          )
                        ],
                      );
                    },
                    options: CarouselOptions(
                      height: 430,
                      onPageChanged: (index, reason){
                        setState(() {
                          slider_index = index;
                        });
                      }
                    ),
                    itemCount: imgList.length,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () {
                          _controller.previousPage();
                        },
                        icon: Icon(Icons.arrow_back_ios_outlined)),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          _controller.nextPage();
                        },
                        icon: Icon(Icons.arrow_forward_ios_outlined)),
                  )
                ],
              ),
            ),
            SizedBox(height: 50,),
            CarouselIndicator(
              color: Color(0xFFE0E0E0),
              activeColor: Color(0xFFA3A3A3),
              count: imgList.length,
              index: slider_index,
            ),
            SizedBox(height: 230,),
            Container(
              width: 340,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: ((context) => HomePage())));
              }, child: Text("Masuk"), style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF3266CC))
              ),),
            ),
            Container(
              width: 340,
              child: OutlinedButton(onPressed: (){}, child: Text("Daftar"), style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color(0xFF83AFEE))
              ),),
            )
          ],
        ),
      ),
    );
  }
}
