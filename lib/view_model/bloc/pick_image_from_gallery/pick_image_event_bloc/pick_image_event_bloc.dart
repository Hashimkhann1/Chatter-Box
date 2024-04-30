

import 'package:equatable/equatable.dart';

abstract class PickImageEventBloc extends Equatable {
  @override
  List<Object> get props => [];

}

class PickImageFromGallery extends PickImageEventBloc {}