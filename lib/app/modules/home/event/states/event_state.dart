// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:events4me/app/modules/home/event/models/event_model.dart';

enum EventStatus { initial, success, loading, error }

// ignore: must_be_immutable
class EventsStates extends Equatable {
  EventStatus status;
  String? error;
  List<EventModel>? eventList;
  List<EventModel>? filterEventList;
  List<DateTime>? dateList;

  EventsStates({
    this.status = EventStatus.initial,
    this.error,
    this.eventList,
    this.filterEventList,
    this.dateList,
  });

  @override
  List<Object?> get props =>
      [status, error, eventList, dateList, filterEventList];

  EventsStates copyWith({
    EventStatus? status,
    String? error,
    List<EventModel>? eventList,
    List<DateTime>? dateList,
    List<EventModel>? filterEventList,
  }) {
    return EventsStates(
      status: status ?? this.status,
      error: error ?? this.error,
      eventList: eventList ?? this.eventList,
      dateList: dateList ?? this.dateList,
      filterEventList: filterEventList ?? this.filterEventList,
    );
  }
}
