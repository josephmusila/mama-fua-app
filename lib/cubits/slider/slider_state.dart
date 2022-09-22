import 'package:equatable/equatable.dart';

import 'package:fua/services/imagesSlider.dart';

abstract class SliderStates extends Equatable {}

class SliderInitialState extends SliderStates {
  @override
  List<Object> get props => [];
}

class SliderLoadingState extends SliderStates {
  @override
  List<Object> get props => [];
}

class SliderLoadedState extends SliderStates {
  final List<ImageModel> images;
  SliderLoadedState({
    required this.images,
  });
  @override
  List<Object> get props => [images];
}

class SliderErrorState extends SliderStates {
  @override
  List<Object> get props => [];
}
