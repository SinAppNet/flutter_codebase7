import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Supabase Group Code

class SupabaseGroup {
  static String getBaseUrl() => 'https://zzkdkcmagsfmryaijywn.supabase.co/';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'apikey':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp6a2RrY21hZ3NmbXJ5YWlqeXduIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDM3MTExMiwiZXhwIjoyMDM1OTQ3MTEyfQ.B-C2xyOUofAqtQV20-43bAvtDmp1zD4cAop-VCAVEqE',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp6a2RrY21hZ3NmbXJ5YWlqeXduIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDM3MTExMiwiZXhwIjoyMDM1OTQ3MTEyfQ.B-C2xyOUofAqtQV20-43bAvtDmp1zD4cAop-VCAVEqE',
  };
  static CommonConnectionCall commonConnectionCall = CommonConnectionCall();
}

class CommonConnectionCall {
  Future<ApiCallResponse> call({
    int? userAtual,
    int? userSect,
  }) async {
    final baseUrl = SupabaseGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "useratual": $userAtual,
  "usersect": $userSect
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'common connection',
      apiUrl: '${baseUrl}rest/v1/rpc/find_common_connections',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp6a2RrY21hZ3NmbXJ5YWlqeXduIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDM3MTExMiwiZXhwIjoyMDM1OTQ3MTEyfQ.B-C2xyOUofAqtQV20-43bAvtDmp1zD4cAop-VCAVEqE',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp6a2RrY21hZ3NmbXJ5YWlqeXduIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDM3MTExMiwiZXhwIjoyMDM1OTQ3MTEyfQ.B-C2xyOUofAqtQV20-43bAvtDmp1zD4cAop-VCAVEqE',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$[:].user_id''',
      ));
}

/// End Supabase Group Code

/// Start Segment Group Code

class SegmentGroup {
  static String getBaseUrl() => 'https://api.segment.io/v1';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  static TrackingCall trackingCall = TrackingCall();
  static IdentifyCall identifyCall = IdentifyCall();
  static PageCall pageCall = PageCall();
}

class TrackingCall {
  Future<ApiCallResponse> call({
    int? userId,
    String? eventName = '',
    String? timestamp = '',
    String? writeKey = 'JK5WJ6o6LxKEytfoQVNDEaw1n35vmLK7',
    dynamic propsJson,
  }) async {
    final baseUrl = SegmentGroup.getBaseUrl();

    final props = _serializeJson(propsJson);
    final ffApiRequestBody = '''
{
  "userId": "$userId",
  "event": "${escapeStringForJson(eventName)}",
  "context": {
    "ip": "24.5.68.47"
  },
  "properties": $props,
  "timestamp": "${escapeStringForJson(timestamp)}",
  "writeKey": "${escapeStringForJson(writeKey)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'tracking',
      apiUrl: '$baseUrl/track',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class IdentifyCall {
  Future<ApiCallResponse> call({
    int? userId,
    String? writeK = 'JK5WJ6o6LxKEytfoQVNDEaw1n35vmLK7',
    String? email = '',
    String? name = '',
    String? databaseUuid = '',
    String? timestamp = '',
    String? whatsapp = '',
  }) async {
    final baseUrl = SegmentGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId": $userId,
  "traits": {
    "email": "${escapeStringForJson(email)}",
    "name": "${escapeStringForJson(name)}",
    "whatsapp": "${escapeStringForJson(whatsapp)}",
    "db_uuid": "${escapeStringForJson(databaseUuid)}"
  },
  "context": {
    "ip": "24.5.68.47"
  },
  "timestamp": "${escapeStringForJson(timestamp)}",
  "writeKey": "${escapeStringForJson(writeK)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'identify',
      apiUrl: '$baseUrl/identify',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PageCall {
  Future<ApiCallResponse> call({
    int? userId,
    String? pageName = '',
    String? writeK = 'JK5WJ6o6LxKEytfoQVNDEaw1n35vmLK7',
    String? timestamp = '',
  }) async {
    final baseUrl = SegmentGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId": $userId,
  "name": "${escapeStringForJson(pageName)}",
  "timestamp": "${escapeStringForJson(timestamp)}",
  "writeKey": "${escapeStringForJson(writeK)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'page',
      apiUrl: '$baseUrl/page',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Segment Group Code

class UptUserCall {
  static Future<ApiCallResponse> call({
    String? jwtUser = '',
    String? newPassword = '',
  }) async {
    final ffApiRequestBody = '''
{
  "password": "$newPassword"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'upt user',
      apiUrl: 'https://zzkdkcmagsfmryaijywn.supabase.co/auth/v1/user',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer $jwtUser',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp6a2RrY21hZ3NmbXJ5YWlqeXduIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMDM3MTExMiwiZXhwIjoyMDM1OTQ3MTEyfQ.B-C2xyOUofAqtQV20-43bAvtDmp1zD4cAop-VCAVEqE',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SendPushCall {
  static Future<ApiCallResponse> call({
    String? fcmToken = '',
    String? pushTitle = '',
    String? pushMessage = '',
    String? pushImg = '',
  }) async {
    final ffApiRequestBody = '''
{
  "fcm": "$fcmToken",
  "pushTitle": "$pushTitle",
  "pushMessage": "$pushMessage",
  "pushImg": "$pushImg"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'send push',
      apiUrl: 'https://hook.us2.make.com/g3lzu2xujruo3utxogj7ijfey2bct37s',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class NnAccCreatedCall {
  static Future<ApiCallResponse> call({
    String? email = '',
  }) async {
    final ffApiRequestBody = '''
{
"email": "$email"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'nn acc created',
      apiUrl:
          'https://primary-production-21be.up.railway.app/webhook/accCreated',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddAsaasCustomerCall {
  static Future<ApiCallResponse> call({
    String? name = '',
    String? email = '',
    String? phone = '',
    String? cpf = '',
  }) async {
    final ffApiRequestBody = '''
{
  "name": "$name",
  "email": "$email",
  "phone": "$phone",
  "cpfCnpj": "$cpf"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'add asaas customer',
      apiUrl: 'https://asaas.com/api/v3/customers',
      callType: ApiCallType.POST,
      headers: {
        'accept': 'application/json',
        'content-type': 'application/json',
        'user-agent':
            '\$aact_YTU5YTE0M2M2N2I4MTliNzk0YTI5N2U5MzdjNWZmNDQ6OjAwMDAwMDAwMDAwMDA0OTc0MzQ6OiRhYWNoXzE0NDlhNDk4LWI5NWItNDJhNi04NzI4LTkwYjc3MmNkYjRmNQ==',
        'access_token':
            '\$aact_YTU5YTE0M2M2N2I4MTliNzk0YTI5N2U5MzdjNWZmNDQ6OjAwMDAwMDAwMDAwMDA0OTc0MzQ6OiRhYWNoXzE0NDlhNDk4LWI5NWItNDJhNi04NzI4LTkwYjc3MmNkYjRmNQ==',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? cusId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
}

class SetTrialCall {
  static Future<ApiCallResponse> call({
    int? id,
  }) async {
    final ffApiRequestBody = '''
{"paciente":$id }''';
    return ApiManager.instance.makeApiCall(
      callName: 'set trial',
      apiUrl:
          'https://primary-production-21be.up.railway.app/webhook/5dacc29f-9f41-49c8-a09b-9c5aef2d26c4',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
