import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fua/cubits/slider/slider_state.dart';
import 'package:fua/services/imagesSlider.dart';

class SliderCubit extends Cubit<SliderStates> {
  SliderCubit({
    required this.imageService,
  }) : super(SliderInitialState()) {
    emit(SliderLoadingState());
  }

  final ImageService imageService;
  late final images;

  void getImages() async {
    try {
      emit(SliderLoadingState());
      images = await imageService.getImages();
      print(images);
      emit(SliderLoadedState(images: images));
    } catch (e) {}
  }
}
