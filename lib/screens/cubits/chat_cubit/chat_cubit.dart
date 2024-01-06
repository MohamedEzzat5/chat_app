import 'package:bloc/bloc.dart';
import 'package:chat_app/constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollections);
  List<Message> messagesList = [];
  void sendMessages({required String message, required String email}) {
    try {
      messages.add({
        kMessage: message,
        kCreatedAt: DateTime.now(),
        'id': email,
      });
    } on Exception catch (e) {

    }

  }

  void getMessages() {
    messages
        .orderBy(kCreatedAt, descending: true)
        .snapshots()
        .listen((event) {
      messagesList.clear();
      for(var doc in event.docs){
        messagesList.add(Message.formJson(doc));

      }
          emit(ChatSuccess(messages: messagesList));
    });
  }
}
