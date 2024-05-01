

import 'package:equatable/equatable.dart';

abstract class PickImageEventBloc extends Equatable {

  const PickImageEventBloc();

  @override
  List<Object> get props => [];

}

class PickImageFromGallery extends PickImageEventBloc {}