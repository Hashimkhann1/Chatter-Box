

import 'package:chatter_box/model/user_data_model/user_data_model.dart';
import 'package:equatable/equatable.dart';

class CurrentUserState extends Equatable {

  final List<CurrentUserModel> currentUserDataList;

  const CurrentUserState({this.currentUserDataList = const []});

  CurrentUserState copyWith({List<CurrentUserModel>? currentUserDataList}){
    return CurrentUserState(currentUserDataList: currentUserDataList ?? this.currentUserDataList);
  }

  @override
  List<Object?> get props => [currentUserDataList];

}