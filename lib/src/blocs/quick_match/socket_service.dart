import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../resources/repository.dart';
class SocketService {
  late IO.Socket socket;
  static const platform = MethodChannel('com.splat/background');

  void initializeSocket(String url, String userId) {
    socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      print('Connected to socket server');
      // Optionally, authenticate the user
      socket.emit('authenticate', {'userId': userId});
    });

    socket.onDisconnect((_) => print('Disconnected from socket server'));
  }

  void sendInvite(String inviterId, String inviteeId, String matchId) {
    socket.emit('invite_friend', {
      'inviter_id': inviterId,
      'invitee_id': inviteeId,
      'match_id': matchId,
    });
  }

  void onInviteReceived(Function(Map<String, dynamic>) callback) {
    socket.on('invite_received', (data) {
      callback(data);
    });
  }

  void dispose() {
    socket.disconnect();
  }
}

final socketService = SocketService();


class InviteService {
  final String apiBaseUrl = "https://ample-crawdad-kind.ngrok-free.app"; // Replace with your API URL
  final String inviteEndpoint = "/v1/invitations"; // Replace with the endpoint

  Future<void> createInvitation(BuildContext context,{
    required String type,
    required String lobbyId,
    required String lobbyName,
    required String destinationId,
    required String destinationType,
  }) async {
    try {
      Response response = await repository.createInvitation(
        context: context,
        lobbyId: lobbyId,
        lobbyName: lobbyName,
        type: type,
        destinationId: destinationId,
        destinationType: destinationType,
      );
      print("Xinhcheck -----${response.body}");
      if (response.statusCode == 200) {
        // Parse the response
        final responseData = jsonDecode(response.body);

        // Send the socket invite
        _sendSocketInvite(
          inviterId: "your_inviter_id", // Replace with your inviter's ID
          inviteeId: responseData['data']['inviteeId'], // Parse from API response
          matchId: responseData['data']['matchId'], // Parse from API response
        );

        print("Invitation created successfully!");
      } else {
        print("Failed to create invitation: ${response.body}");
      }
    } catch (e) {
      print("Error creating invitation: $e");
    }
  }

  void _sendSocketInvite({
    required String inviterId,
    required String inviteeId,
    required String matchId,
  }) {
    // Replace with your WebSocket implementation
    socketService.sendInvite(inviterId, inviteeId, matchId);
    print("Socket invite sent successfully!");
  }
}
