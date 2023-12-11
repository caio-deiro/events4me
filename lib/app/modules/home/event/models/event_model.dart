// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EventModel {
  final int id;
  final String title;
  final String description;
  final String? status;
  final DateTime date;
  final int? guestNumber;
  final int? guestConfirmed;

  EventModel({
    this.status,
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.guestNumber,
    this.guestConfirmed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'date': date.millisecondsSinceEpoch,
      'guestNumber': guestNumber,
      'guestConfirmed': guestConfirmed,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      status: map['status'] != null ? map['status'] as String : null,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      guestNumber:
          map['guestNumber'] != null ? map['guestNumber'] as int : null,
      guestConfirmed:
          map['guestConfirmed'] != null ? map['guestConfirmed'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
