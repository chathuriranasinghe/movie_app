import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 40.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      )),
                  Spacer(),
                  Text(
                    'Movie Hub',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                ],
              ),
            ),
            FutureBuilder(
                future: ApiService().getPopularMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  List movies = snapshot.data!;
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: size.height * 0.22, autoPlay: true),
                    items: movies.map((movie) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 10.0, left: 4.0, right: 4.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade900,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(movie.backdropPath))),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 3,
                                    left: 3,
                                    child: Container(
                                      padding: EdgeInsetsDirectional.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(20)),
                                      child: Text(movie.title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                })
          ],
        ),
      ),
    );
  }
}
