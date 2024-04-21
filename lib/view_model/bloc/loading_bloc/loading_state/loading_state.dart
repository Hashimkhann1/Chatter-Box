

import 'package:equatable/equatable.dart';

class LoadingState extends Equatable{

  final bool isLoading;

  LoadingState({this.isLoading = false});

  LoadingState copyWith({bool? isLoading}) {
    return LoadingState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading];



}