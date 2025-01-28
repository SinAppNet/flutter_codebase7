import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/componentes/empty/empty_widget.dart';
import '/componentes/postagem/postagem_widget.dart';
import '/componentes/write_post/write_post_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/new_pages/new_app_bar/new_app_bar_widget.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'new_feed_model.dart';
export 'new_feed_model.dart';

class NewFeedWidget extends StatefulWidget {
  const NewFeedWidget({super.key});

  @override
  State<NewFeedWidget> createState() => _NewFeedWidgetState();
}

class _NewFeedWidgetState extends State<NewFeedWidget> {
  late NewFeedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewFeedModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      unawaited(
        () async {
          await action_blocks.appTracking(
            context,
            userid: FFAppState().currentUser.id,
            eventName: 'page-loaded',
            pageName: 'feed',
          );
        }(),
      );
    });

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
              children: [
                Container(
                  width: double.infinity,
                  height: 125.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(18.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Feed',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    fontSize: 32.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 24.0, 0.0),
                        child: FutureBuilder<List<UsersRow>>(
                          future: UsersTable().querySingleRow(
                            queryFn: (q) => q.eqOrNull(
                              'uuid',
                              currentUserUid,
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

                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  'userProfile',
                                  queryParameters: {
                                    'user': serializeParam(
                                      containerUsersRow,
                                      ParamType.SupabaseRow,
                                    ),
                                  }.withoutNulls,
                                );

                                unawaited(
                                  () async {
                                    await action_blocks.appTracking(
                                      context,
                                      userid: FFAppState().currentUser.id,
                                      eventName: 'perfil-visualizado',
                                      props: <String, dynamic>{
                                        'page': 'feed',
                                        'usuario-id': containerUsersRow?.id,
                                        'usuario-nome': containerUsersRow?.nome,
                                      },
                                    );
                                  }(),
                                );
                              },
                              child: Container(
                                width: 62.0,
                                height: 62.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF0000),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.network(
                                      valueOrDefault<String>(
                                        FFAppState().currentUser.profilePic,
                                        'https://static.vecteezy.com/system/resources/thumbnails/003/337/584/small/default-avatar-photo-placeholder-profile-icon-vector.jpg',
                                      ),
                                    ).image,
                                  ),
                                  borderRadius: BorderRadius.circular(200.0),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 18.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return WebViewAware(
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.8,
                                        child: WritePostWidget(
                                          callback: () async {},
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));

                            unawaited(
                              () async {
                                await action_blocks.appTracking(
                                  context,
                                  userid: FFAppState().currentUser.id,
                                  eventName: 'escrever-post',
                                  pageName: 'feed',
                                );
                              }(),
                            );
                          },
                          child: Container(
                            width: 38.0,
                            height: 38.0,
                            decoration: BoxDecoration(
                              color: const Color(0x43009C3B),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Icon(
                              Icons.add_sharp,
                              color: Color(0x7214181B),
                              size: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F1F1),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                      child: StreamBuilder<List<FeedPostagensRow>>(
                        stream: _model.listViewSupabaseStream ??= SupaFlow
                            .client
                            .from("feed_postagens")
                            .stream(primaryKey: ['id'])
                            .order('created_at')
                            .map((list) => list
                                .map((item) => FeedPostagensRow(item))
                                .toList()),
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
                          List<FeedPostagensRow> listViewFeedPostagensRowList =
                              snapshot.data!;

                          if (listViewFeedPostagensRowList.isEmpty) {
                            return const Center(
                              child: EmptyWidget(
                                message: 'Nenhuma postagem no momento.',
                              ),
                            );
                          }

                          return ListView.separated(
                            padding: const EdgeInsets.fromLTRB(
                              0,
                              24.0,
                              0,
                              52.0,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listViewFeedPostagensRowList.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 18.0),
                            itemBuilder: (context, listViewIndex) {
                              final listViewFeedPostagensRow =
                                  listViewFeedPostagensRowList[listViewIndex];
                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                child: PostagemWidget(
                                  key: Key(
                                      'Key7ik_${listViewIndex}_of_${listViewFeedPostagensRowList.length}'),
                                  feed: listViewFeedPostagensRow,
                                  callback: () async {},
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
                    currentPage: 1,
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
