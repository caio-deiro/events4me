import 'package:events4me/app/modules/home/event/states/event_state.dart';

abstract class EventRepository {
  /// Create a event
  Future<EventsStates> createEvent({
    required String title,
    required String description,
    required DateTime date,
  });

  /// Get all events from user
  Future<EventsStates> getAllEvents({required int userId});
}
