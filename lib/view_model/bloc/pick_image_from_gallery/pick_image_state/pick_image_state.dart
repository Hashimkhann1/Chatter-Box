
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class PickImageState extends Equatable {

  final XFile? file;
  PickImageState({this.file});

  PickImageState copyWith({XFile? file}){
    return PickImageState(file: file ?? this.file);
  }

  @override
  List<Object?> get props => [file];

}