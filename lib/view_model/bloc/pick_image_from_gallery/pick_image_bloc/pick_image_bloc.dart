

import 'package:bloc/bloc.dart';
import 'package:chatter_box/view/chat_view/shoe_detail_image_view/shoe_detail_image_view.dart';
import 'package:chatter_box/view_model/bloc/pick_image_from_gallery/pick_image_event_bloc/pick_image_event_bloc.dart';
import 'package:chatter_box/view_model/bloc/pick_image_from_gallery/pick_image_state/pick_image_state.dart';
import 'package:chatter_box/view_model/chat_view_model/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class PickImageBloc extends Bloc<PickImageEventBloc , PickImageState> {

  final ChatViewModel chatViewModel;


  PickImageBloc(this.chatViewModel) : super(PickImageState()) {
    on<PickImageFromGallery>(_pickImageFromGallery);
  }

  void _pickImageFromGallery(PickImageFromGallery event , Emitter emit) async {
    XFile? file = await chatViewModel.pickImageFromGllery();
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ShowDetailImageView()));
    emit(state.copyWith(file: file));
  }


}