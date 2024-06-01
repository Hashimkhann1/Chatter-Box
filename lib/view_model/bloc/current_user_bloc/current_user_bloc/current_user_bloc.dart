

import 'package:bloc/bloc.dart';
import 'package:chatter_box/model/user_data_model/user_data_model.dart';
import 'package:chatter_box/view_model/bloc/current_user_bloc/current_user_event/current_user_event.dart';
import 'package:chatter_box/view_model/bloc/current_user_bloc/current_user_state/current_user_state.dart';
import 'package:chatter_box/view_model/current_user_view_model/current_user_view_model.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent , CurrentUserState> {

  final CurrentUserViewModel currentUserViewModel;

  CurrentUserBloc(this.currentUserViewModel) : super(CurrentUserState()) {
    on<CurrentUserData>(_currentUserData);
  }

  void _currentUserData(CurrentUserEvent event , Emitter<CurrentUserState> emit) async {
    final CurrentUserModel userData = await currentUserViewModel.getCurrentUserdata();
    emit(state.copyWith(currentUserDataList: [userData]));
  }

}