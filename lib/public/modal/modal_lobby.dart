import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

class LobbyModel {
  final String id;
  final String name;
  final String matchSettingId;
  final String? owner;
  final DateTime scheduledAt;
  final DateTime createdAt;

  LobbyModel({
    required this.id,
    required this.name,
    required this.matchSettingId,
    this.owner,
    required this.scheduledAt,
    required this.createdAt,
  });

  factory LobbyModel.fromJson(Map<String, dynamic> json) {
    return LobbyModel(
      id: json['id_'],
      name: json['name'],
      matchSettingId: json['match_setting_id'],
      owner: json['owner'],
      scheduledAt: DateTime.parse(json['scheduled_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}