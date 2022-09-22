// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fua/cubits/slider/slider_cubit.dart';
import 'package:fua/cubits/slider/slider_state.dart';

class CustomImageSlider extends StatefulWidget {

  CustomImageSlider({Key? key}) : super(key: key);

  @override
  State<CustomImageSlider> createState() => _CustomImageSliderState();

}

class _CustomImageSliderState extends State<CustomImageSlider> {
  
 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<SliderCubit, SliderStates>(builder: (context, state) {
        if (state is SliderLoadedState) {
          var images = state.images;

          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: false,
            ),
            items: List.generate(
              images.length,
              (index) {
                return Container(
                  height: 600,
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(images[index].image,
                            fit: BoxFit.cover, height: 400, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: const [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              images[index].label,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
