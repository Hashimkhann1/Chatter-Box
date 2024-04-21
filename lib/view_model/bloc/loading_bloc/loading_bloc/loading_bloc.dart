


import 'package:bloc/bloc.dart';
import 'package:chatter_box/view_model/bloc/loading_bloc/loading_event/loading_event.dart';
import 'package:chatter_box/view_model/bloc/loading_bloc/loading_state/loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent , LoadingState> {


  LoadingBloc() : super(LoadingState()) {
    on<SetLoading>(_setLoading);
  }

  void _setLoading(SetLoading event , Emitter<LoadingState> emit) {
    emit(state.copyWith(isLoading: !state.isLoading));
  }


}