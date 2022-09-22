import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fua/cubits/slider/slider_cubit.dart';
import 'package:fua/cubits/slider/slider_state.dart';
import 'package:fua/widgets/imageCouresel.dart';

class SliderCubitLogics extends StatefulWidget {
  const SliderCubitLogics({Key? key}) : super(key: key);

  @override
  State<SliderCubitLogics> createState() => _SliderCubitLogicsState();
}

class _SliderCubitLogicsState extends State<SliderCubitLogics> {
 @override
  void initState() {
    BlocProvider.of<SliderCubit>(context).getImages();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<SliderCubit, SliderStates>(builder: (context, state) {
        if (state is SliderLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SliderLoadedState) {
          return CustomImageSlider();
        } else {
          return Container();
        }
      }),
    );
  }
}
