import '/backend/supabase/supabase.dart';
import '/componentes/app_bar/app_bar_widget.dart';
import '/componentes/init_chat_messages/init_chat_messages_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'chat_widget.dart' show ChatWidget;
import 'package:flutter/material.dart';

class ChatModel extends FlutterFlowModel<ChatWidget> {
  ///  Local state fields for this page.

  bool all = false;

  int? num = 0;

  bool isRecording = false;

  String? currentAudio;

  ///  State fields for stateful widgets in this page.

  // Model for appBar component.
  late AppBarModel appBarModel;
  // State field(s) for Mensagens widget.
  ScrollController? mensagens;
  Stream<List<MensagensRow>>? mensagensSupabaseStream;
  // Model for initChatMessages component.
  late InitChatMessagesModel initChatMessagesModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<MensagensRow>? msgs;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<UsersRow>? user1;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<UsersRow>? user2;

  @override
  void initState(BuildContext context) {
    appBarModel = createModel(context, () => AppBarModel());
    mensagens = ScrollController();
    initChatMessagesModel = createModel(context, () => InitChatMessagesModel());
  }

  @override
  void dispose() {
    appBarModel.dispose();
    mensagens?.dispose();
    initChatMessagesModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
