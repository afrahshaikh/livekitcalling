import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:livekit_example/model/access_token_model.dart';
import 'package:livekit_example/network/dio_helper.dart';


class ApiCalls {
  static Dio dio = DioHelper().dio;

  // room id ABC  (Medhat/Afrah)
  // room id ABC  (Medhat/Afrah)

  //SECTION -------------------> CREATE ROOM REQUEST
  static Future<AccessTokenModel?> createRoom(
      {required String authToken,
      required String roomName,
      required String participantIdentity}) async {
    Response res = await dio.post(
      '/generateTokenForRoom',
      data: {
        'RoomName': roomName,
        'MaxParticipants': 10,
        'ParticipantIdentity': participantIdentity
      },
      options: Options(headers: {"Authorization": authToken}),
    );
    if (res.statusCode != 201) {
      return null;
    } else {
      return AccessTokenModel.fromJson(res.data);
    }
  }

  //SECTION -------------------> GENERATE LK ACCESS TOKEN REQUEST
  static Future<AccessTokenModel?> generateLKAccessToken(
      {required String authToken,
      required String roomName,
      required String participantIdentity}) async {
    log('Start Generating');
    Response res = await dio.post(
      '/generateLKToken',
      data: {
        'RoomName': roomName,
        'ParticipantIdentity': participantIdentity,
      },
      options: Options(headers: {"Authorization": authToken}),
    );
    if (res.statusCode != 201) {
      log('Generate LK Access Token ${res.statusCode}');
      log('Generate LK Access Token ${res.data}');
      return null;
    } else {
      log('Generate LK Access Token Data ${res.data}');
      return AccessTokenModel.fromJson(res.data);
    }
  }
}
