


import 'package:bloc/bloc.dart';
import 'package:chatter_box/view/chat_view/show_detail_image_view/show_detail_image_view.dart';
import 'package:chatter_box/view_model/bloc/pick_image_from_gallery/pick_image_event_bloc/pick_image_event_bloc.dart';
import 'package:chatter_box/view_model/bloc/pick_image_from_gallery/pick_image_state/pick_image_state.dart';
import 'package:chatter_box/view_model/chat_view_model/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageBloc extends Bloc<PickImageEventBloc , PickImageState> {

  final ChatViewModel chatViewModel;


  PickImageBloc(this.chatViewModel) : super(const PickImageState()) {
    on<PickImageFromGallery>(_pickImageFromGallery);
  }

  void _pickImageFromGallery(PickImageFromGallery event , Emitter emit) async {
    XFile? file = await chatViewModel.pickImageFromGallery();
    if(file != null){
      Navigator.push(event.context, MaterialPageRoute(builder: (context) => ShowDetailImageView(imagePath: file.path,reciverId: event.reciverId,)));
    }
    emit(state.copyWith(file: file));
  }


}