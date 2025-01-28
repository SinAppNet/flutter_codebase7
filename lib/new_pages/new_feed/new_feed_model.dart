import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/new_pages/new_app_bar/new_app_bar_widget.dart';
import 'dart:async';
import 'new_feed_widget.dart' show NewFeedWidget;
import 'package:flutter/material.dart';

class NewFeedModel extends FlutterFlowModel<NewFeedWidget> {
  ///  State fields for stateful widgets in this page.

  Stream<List<FeedPostagensRow>>? listViewSupabaseStream;
  // Model for newAppBar component.
  late NewAppBarModel newAppBarModel;

  @override
  void initState(BuildContext context) {
    newAppBarModel = createModel(context, () => NewAppBarModel());
  }

  @override
  void dispose() {
    newAppBarModel.dispose();
  }
}
