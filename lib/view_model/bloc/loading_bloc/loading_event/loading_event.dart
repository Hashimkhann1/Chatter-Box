
import 'package:equatable/equatable.dart';

abstract class LoadingEvent extends Equatable {

  @override
  List<Object> get props => [];

}


class SetLoading extends LoadingEvent {}