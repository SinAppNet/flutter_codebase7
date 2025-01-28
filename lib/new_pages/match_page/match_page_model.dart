import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'match_page_widget.dart' show MatchPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class MatchPageModel extends FlutterFlowModel<MatchPageWidget> {
  ///  Local state fields for this page.

  bool tutorial = true;

  UsersRow? currentProfile;

  ///  State fields for stateful widgets in this page.

  // State field(s) for SwipeableStack widget.
  late CardSwiperController swipeableStackController;
  Stream<List<UsuariosSemConexoesRow>>? swipeableStackSupabaseStream;

  @override
  void initState(BuildContext context) {
    swipeableStackController = CardSwiperController();
  }

  @override
  void dispose() {}
}
