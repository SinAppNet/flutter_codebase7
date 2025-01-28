import '/backend/supabase/supabase.dart';
import '/componentes/empty/empty_widget.dart';
import '/componentes/empty_chats/empty_chats_widget.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/new_pages/new_app_bar/new_app_bar_widget.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'new_chats_model.dart';
export 'new_chats_model.dart';

class NewChatsWidget extends StatefulWidget {
  const NewChatsWidget({super.key});

  @override
  State<NewChatsWidget> createState() => _NewChatsWidgetState();
}

class _NewChatsWidgetState extends State<NewChatsWidget> {
  late NewChatsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool pesquisaNomeFocusListenerRegistered = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewChatsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      unawaited(
        () async {
          await action_blocks.appTracking(
            context,
            userid: FFAppState().currentUser.id,
            eventName: 'page-loaded',
            pageName: 'chats',
          );
        }(),
      );
    });

    _model.pesquisaNomeTextController ??= TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0x00FFFFFF),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(32.0, 32.0, 0.0, 0.0),
                  child: Text(
                    'Chat',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          fontSize: 28.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(32.0, 12.0, 32.0, 0.0),
                  child: FutureBuilder<List<UsersRow>>(
                    future: UsersTable().queryRows(
                      queryFn: (q) => q,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return const Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: SpinKitPulse(
                              color: Color(0xFF009C3B),
                              size: 50.0,
                            ),
                          ),
                        );
                      }
                      List<UsersRow> containerUsersRowList = snapshot.data!;

                      return Container(
                        width: double.infinity,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: const Color(0x53D0D0D0),
                          borderRadius: BorderRadius.circular(1.0),
                          border: Border.all(
                            color: (_model.pesquisaNomeFocusNode?.hasFocus ??
                                    false)
                                ? const Color(0xFF6CEB57)
                                : const Color(0xFFD0D5DD),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 8.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/search-lg.png',
                                  width: 20.0,
                                  height: 20.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Autocomplete<String>(
                                  initialValue: const TextEditingValue(),
                                  optionsBuilder: (textEditingValue) {
                                    if (textEditingValue.text == '') {
                                      return const Iterable<String>.empty();
                                    }
                                    return containerUsersRowList
                                        .map((e) => e.nome)
                                        .withoutNulls
                                        .toList()
                                        .where((option) {
                                      final lowercaseOption =
                                          option.toLowerCase();
                                      return lowercaseOption.contains(
                                          textEditingValue.text.toLowerCase());
                                    });
                                  },
                                  optionsViewBuilder:
                                      (context, onSelected, options) {
                                    return AutocompleteOptionsList(
                                      textFieldKey: _model.pesquisaNomeKey,
                                      textController:
                                          _model.pesquisaNomeTextController!,
                                      options: options.toList(),
                                      onSelected: onSelected,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                      textHighlightStyle: const TextStyle(),
                                      elevation: 4.0,
                                      optionBackgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      optionHighlightColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      maxHeight: 200.0,
                                    );
                                  },
                                  onSelected: (String selection) {
                                    safeSetState(() =>
                                        _model.pesquisaNomeSelectedOption =
                                            selection);
                                    FocusScope.of(context).unfocus();
                                  },
                                  fieldViewBuilder: (
                                    context,
                                    textEditingController,
                                    focusNode,
                                    onEditingComplete,
                                  ) {
                                    _model.pesquisaNomeFocusNode = focusNode;
                                    if (!pesquisaNomeFocusListenerRegistered) {
                                      pesquisaNomeFocusListenerRegistered =
                                          true;
                                      _model.pesquisaNomeFocusNode!.addListener(
                                        () async {
                                          _model.usr =
                                              await UsersTable().queryRows(
                                            queryFn: (q) => q.eqOrNull(
                                              'nome',
                                              _model.pesquisaNomeTextController
                                                  .text,
                                            ),
                                          );
                                          if ((_model.usr != null &&
                                                  (_model.usr)!.isNotEmpty) ==
                                              false) {
                                            safeSetState(() {
                                              _model.pesquisaNomeTextController
                                                  ?.clear();
                                            });
                                            _model.searched =
                                                _model.usr?.firstOrNull;
                                            safeSetState(() {});
                                          } else {
                                            FFAppState().filtroOn = true;
                                            safeSetState(() {});
                                            _model.searched =
                                                _model.usr?.firstOrNull;
                                            safeSetState(() {});
                                          }

                                          safeSetState(() {});
                                        },
                                      );
                                    }
                                    _model.pesquisaNomeTextController =
                                        textEditingController;
                                    return TextFormField(
                                      key: _model.pesquisaNomeKey,
                                      controller: textEditingController,
                                      focusNode: focusNode,
                                      onEditingComplete: onEditingComplete,
                                      autofocus: false,
                                      textInputAction: TextInputAction.done,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText:
                                            'Pesquise pelo nome do usuário',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color: const Color(0xFF667085),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00E0E3E7),
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x004B39EF),
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00FF5963),
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00FF5963),
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        contentPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                10.0, 20.0, 10.0, 0.0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                          ),
                                      validator: _model
                                          .pesquisaNomeTextControllerValidator
                                          .asValidator(context),
                                    );
                                  },
                                ),
                              ),
                              if (_model.searched != null)
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _model.searched = null;
                                    safeSetState(() {});
                                    safeSetState(() {
                                      _model.pesquisaNomeTextController
                                          ?.clear();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Color(0xFFFF0303),
                                    size: 24.0,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (responsiveVisibility(
                  context: context,
                  phone: false,
                  tablet: false,
                  tabletLandscape: false,
                  desktop: false,
                ))
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(32.0, 24.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.tab = 'all';
                            safeSetState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _model.tab == 'all'
                                  ? const Color(0xFF009C3B)
                                  : const Color(0xFFB6B6B6),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 8.0, 12.0, 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Todas',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.tab = 'unread';
                            safeSetState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _model.tab == 'unread'
                                  ? const Color(0xFF009C3B)
                                  : const Color(0xFFB6B6B6),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 8.0, 12.0, 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Não lidas',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ].divide(const SizedBox(width: 12.0)),
                    ),
                  ),
                if (_model.searched == null)
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F1),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            width: 2.0,
                          ),
                        ),
                        child: FutureBuilder<List<ChatRow>>(
                          future: ChatTable().queryRows(
                            queryFn: (q) => q
                                .containsOrNull(
                                  'users',
                                  '{${FFAppState().currentUser.id}}',
                                )
                                .order('last_update', ascending: true),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return const Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: SpinKitPulse(
                                    color: Color(0xFF009C3B),
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            List<ChatRow> listViewChatRowList = snapshot.data!;

                            if (listViewChatRowList.isEmpty) {
                              return const Center(
                                child: EmptyChatsWidget(),
                              );
                            }

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewChatRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewChatRow =
                                    listViewChatRowList[listViewIndex];
                                return Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        25.0, 0.0, 25.0, 0.0),
                                    child: FutureBuilder<List<UsersRow>>(
                                      future: UsersTable().querySingleRow(
                                        queryFn: (q) => q
                                            .inFilterOrNull(
                                              'id',
                                              listViewChatRow.users,
                                            )
                                            .neqOrNull(
                                              'id',
                                              FFAppState().currentUser.id,
                                            ),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return const Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: SpinKitPulse(
                                                color: Color(0xFF009C3B),
                                                size: 50.0,
                                              ),
                                            ),
                                          );
                                        }
                                        List<UsersRow> containerUsersRowList =
                                            snapshot.data!;

                                        final containerUsersRow =
                                            containerUsersRowList.isNotEmpty
                                                ? containerUsersRowList.first
                                                : null;

                                        return Container(
                                          width: 360.0,
                                          height: 94.0,
                                          decoration: const BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 10.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  'newChat',
                                                  queryParameters: {
                                                    'chat': serializeParam(
                                                      listViewChatRow,
                                                      ParamType.SupabaseRow,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        const TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                      duration: Duration(
                                                          milliseconds: 0),
                                                    ),
                                                  },
                                                );

                                                unawaited(
                                                  () async {
                                                    await action_blocks
                                                        .appTracking(
                                                      context,
                                                      userid: FFAppState()
                                                          .currentUser
                                                          .id,
                                                      eventName: 'abrir-chat',
                                                      props: <String, dynamic>{
                                                        'page': 'chats',
                                                        'usuario-id':
                                                            containerUsersRow
                                                                ?.id,
                                                        'usuario-nome':
                                                            containerUsersRow
                                                                ?.nome,
                                                      },
                                                    );
                                                  }(),
                                                );
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'userProfile',
                                                            queryParameters: {
                                                              'user':
                                                                  serializeParam(
                                                                containerUsersRow,
                                                                ParamType
                                                                    .SupabaseRow,
                                                              ),
                                                            }.withoutNulls,
                                                            extra: <String,
                                                                dynamic>{
                                                              kTransitionInfoKey:
                                                                  const TransitionInfo(
                                                                hasTransition:
                                                                    true,
                                                                transitionType:
                                                                    PageTransitionType
                                                                        .fade,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        0),
                                                              ),
                                                            },
                                                          );

                                                          unawaited(
                                                            () async {
                                                              await action_blocks
                                                                  .appTracking(
                                                                context,
                                                                userid: FFAppState()
                                                                    .currentUser
                                                                    .id,
                                                                eventName:
                                                                    'perfil-visualizado',
                                                                props: <String,
                                                                    dynamic>{
                                                                  'page':
                                                                      'chats',
                                                                  'usuario-id':
                                                                      containerUsersRow
                                                                          ?.id,
                                                                  'usuario-nome':
                                                                      containerUsersRow
                                                                          ?.nome,
                                                                },
                                                              );
                                                            }(),
                                                          );
                                                        },
                                                        child: Container(
                                                          width: 62.0,
                                                          height: 62.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0x00ECECEC),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  containerUsersRow
                                                                      ?.profilePic,
                                                                  'https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg',
                                                                ),
                                                              ).image,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        200.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    14.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                containerUsersRow
                                                                    ?.nome,
                                                                'Username',
                                                              ).maybeHandleOverflow(
                                                                maxChars: 18,
                                                                replacement:
                                                                    '…',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    color: const Color(
                                                                        0xFF101828),
                                                                    fontSize:
                                                                        18.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  listViewChatRow
                                                                      .lastMessage,
                                                                  'Ultima mensagem',
                                                                ).maybeHandleOverflow(
                                                                  maxChars: 25,
                                                                  replacement:
                                                                      '…',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      color: const Color(
                                                                          0xFF101828),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          FutureBuilder<
                                                              List<
                                                                  MensagensRow>>(
                                                            future: MensagensTable()
                                                                .querySingleRow(
                                                              queryFn: (q) => q
                                                                  .eqOrNull(
                                                                    'chat',
                                                                    listViewChatRow
                                                                        .id,
                                                                  )
                                                                  .order(
                                                                      'created_at'),
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return const Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    child:
                                                                        SpinKitPulse(
                                                                      color: Color(
                                                                          0xFF009C3B),
                                                                      size:
                                                                          50.0,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              List<MensagensRow>
                                                                  textMensagensRowList =
                                                                  snapshot
                                                                      .data!;

                                                              final textMensagensRow =
                                                                  textMensagensRowList
                                                                          .isNotEmpty
                                                                      ? textMensagensRowList
                                                                          .first
                                                                      : null;

                                                              return Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  dateTimeFormat(
                                                                    "relative",
                                                                    textMensagensRow
                                                                        ?.createdAt,
                                                                    locale: FFLocalizations.of(context)
                                                                            .languageShortCode ??
                                                                        FFLocalizations.of(context)
                                                                            .languageCode,
                                                                  ),
                                                                  'Há 1 hora',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      color: const Color(
                                                                          0xFF888F9D),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              );
                                                            },
                                                          ),
                                                          Container(
                                                            width: 12.0,
                                                            height: 12.0,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xFF009C3B),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                        ].divide(const SizedBox(
                                                            height: 12.0)),
                                                      ),
                                                    ].divide(
                                                        const SizedBox(height: 10.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                if (_model.searched != null)
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F1),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            width: 2.0,
                          ),
                        ),
                        child: FutureBuilder<List<ChatRow>>(
                          future: ChatTable().queryRows(
                            queryFn: (q) => q
                                .containsOrNull(
                                  'users',
                                  '{${FFAppState().currentUser.id}}',
                                )
                                .containsOrNull(
                                  'users',
                                  '{${_model.searched?.id}}',
                                )
                                .order('last_update', ascending: true),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return const Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: SpinKitPulse(
                                    color: Color(0xFF009C3B),
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            List<ChatRow> listViewChatRowList = snapshot.data!;

                            if (listViewChatRowList.isEmpty) {
                              return const Center(
                                child: EmptyWidget(
                                  message: 'Nenhum chat encontrado.',
                                ),
                              );
                            }

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewChatRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewChatRow =
                                    listViewChatRowList[listViewIndex];
                                return Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        25.0, 0.0, 25.0, 0.0),
                                    child: FutureBuilder<List<UsersRow>>(
                                      future: UsersTable().querySingleRow(
                                        queryFn: (q) => q
                                            .inFilterOrNull(
                                              'id',
                                              listViewChatRow.users,
                                            )
                                            .neqOrNull(
                                              'id',
                                              FFAppState().currentUser.id,
                                            ),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return const Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: SpinKitPulse(
                                                color: Color(0xFF009C3B),
                                                size: 50.0,
                                              ),
                                            ),
                                          );
                                        }
                                        List<UsersRow> containerUsersRowList =
                                            snapshot.data!;

                                        final containerUsersRow =
                                            containerUsersRowList.isNotEmpty
                                                ? containerUsersRowList.first
                                                : null;

                                        return Container(
                                          width: 360.0,
                                          height: 94.0,
                                          decoration: const BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 10.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  'newChat',
                                                  queryParameters: {
                                                    'chat': serializeParam(
                                                      listViewChatRow,
                                                      ParamType.SupabaseRow,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        const TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                      duration: Duration(
                                                          milliseconds: 0),
                                                    ),
                                                  },
                                                );

                                                unawaited(
                                                  () async {
                                                    await action_blocks
                                                        .appTracking(
                                                      context,
                                                      userid: FFAppState()
                                                          .currentUser
                                                          .id,
                                                      eventName: 'abrir-chat',
                                                      props: <String, dynamic>{
                                                        'page': 'chats',
                                                        'usuario-id':
                                                            containerUsersRow
                                                                ?.id,
                                                        'usuario-nome':
                                                            containerUsersRow
                                                                ?.nome,
                                                      },
                                                    );
                                                  }(),
                                                );
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'userProfile',
                                                            queryParameters: {
                                                              'user':
                                                                  serializeParam(
                                                                containerUsersRow,
                                                                ParamType
                                                                    .SupabaseRow,
                                                              ),
                                                            }.withoutNulls,
                                                            extra: <String,
                                                                dynamic>{
                                                              kTransitionInfoKey:
                                                                  const TransitionInfo(
                                                                hasTransition:
                                                                    true,
                                                                transitionType:
                                                                    PageTransitionType
                                                                        .fade,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        0),
                                                              ),
                                                            },
                                                          );

                                                          unawaited(
                                                            () async {
                                                              await action_blocks
                                                                  .appTracking(
                                                                context,
                                                                userid: FFAppState()
                                                                    .currentUser
                                                                    .id,
                                                                eventName:
                                                                    'perfil-visualizado',
                                                                props: <String,
                                                                    dynamic>{
                                                                  'page':
                                                                      'chats',
                                                                  'usuario-id':
                                                                      containerUsersRow
                                                                          ?.id,
                                                                  'usuario-nome':
                                                                      containerUsersRow
                                                                          ?.nome,
                                                                },
                                                              );
                                                            }(),
                                                          );
                                                        },
                                                        child: Container(
                                                          width: 62.0,
                                                          height: 62.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0x00ECECEC),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  containerUsersRow
                                                                      ?.profilePic,
                                                                  'https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg',
                                                                ),
                                                              ).image,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        200.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    14.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                containerUsersRow
                                                                    ?.nome,
                                                                'Username',
                                                              ).maybeHandleOverflow(
                                                                maxChars: 18,
                                                                replacement:
                                                                    '…',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    color: const Color(
                                                                        0xFF101828),
                                                                    fontSize:
                                                                        18.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  listViewChatRow
                                                                      .lastMessage,
                                                                  'Ultima mensagem',
                                                                ).maybeHandleOverflow(
                                                                  maxChars: 25,
                                                                  replacement:
                                                                      '…',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      color: const Color(
                                                                          0xFF101828),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          FutureBuilder<
                                                              List<
                                                                  MensagensRow>>(
                                                            future: MensagensTable()
                                                                .querySingleRow(
                                                              queryFn: (q) => q
                                                                  .eqOrNull(
                                                                    'chat',
                                                                    listViewChatRow
                                                                        .id,
                                                                  )
                                                                  .order(
                                                                      'created_at'),
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return const Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    child:
                                                                        SpinKitPulse(
                                                                      color: Color(
                                                                          0xFF009C3B),
                                                                      size:
                                                                          50.0,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              List<MensagensRow>
                                                                  textMensagensRowList =
                                                                  snapshot
                                                                      .data!;

                                                              final textMensagensRow =
                                                                  textMensagensRowList
                                                                          .isNotEmpty
                                                                      ? textMensagensRowList
                                                                          .first
                                                                      : null;

                                                              return Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  dateTimeFormat(
                                                                    "relative",
                                                                    textMensagensRow
                                                                        ?.createdAt,
                                                                    locale: FFLocalizations.of(context)
                                                                            .languageShortCode ??
                                                                        FFLocalizations.of(context)
                                                                            .languageCode,
                                                                  ),
                                                                  'Há 1 hora',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      color: const Color(
                                                                          0xFF888F9D),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              );
                                                            },
                                                          ),
                                                          Container(
                                                            width: 12.0,
                                                            height: 12.0,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xFF009C3B),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                        ].divide(const SizedBox(
                                                            height: 12.0)),
                                                      ),
                                                    ].divide(
                                                        const SizedBox(height: 10.0)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                wrapWithModel(
                  model: _model.newAppBarModel,
                  updateCallback: () => safeSetState(() {}),
                  child: const NewAppBarWidget(
                    currentPage: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
