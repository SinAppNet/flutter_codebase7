import '/backend/supabase/supabase.dart';
import '/componentes/init_chat_messages/init_chat_messages_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'new_chat_widget.dart' show NewChatWidget;
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class NewChatModel extends FlutterFlowModel<NewChatWidget> {
  ///  Local state fields for this page.

  bool isRecording = false;

  String? currentAudio;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Mensagens widget.
  ScrollController? mensagens;
  Stream<List<MensagensRow>>? mensagensSupabaseStream;
  // Model for initChatMessages component.
  late InitChatMessagesModel initChatMessagesModel;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<MensagensRow>? msgsCopy;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<MensagensRow>? msgs;
  AudioRecorder? audioRecorder;
  String? stopped;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  @override
  void initState(BuildContext context) {
    mensagens = ScrollController();
    initChatMessagesModel = createModel(context, () => InitChatMessagesModel());
  }

  @override
  void dispose() {
    mensagens?.dispose();
    initChatMessagesModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
