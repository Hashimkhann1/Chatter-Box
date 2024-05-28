

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PickImageEventBloc extends Equatable {

  const PickImageEventBloc();

  @override
  List<Object> get props => [];

}

class PickImageFromGallery extends PickImageEventBloc {
  final BuildContext context;
  final String reciverId;

  const PickImageFromGallery({required this.context,required this.reciverId});
}