import 'package:dio/dio.dart';
import 'package:events4me/app/modules/home/event/models/event_model.dart';
import 'package:events4me/app/modules/home/event/repositories/event_repository.dart';
import 'package:events4me/app/modules/home/event/states/event_state.dart';
import 'package:events4me/app/shared/services/dio/dio_service.dart';
import 'package:events4me/app/shared/services/dio/error/api_error.dart';

class EventRepositoryImpl implements EventRepository {
  // DioService instance
  final DioService dio;

  /// CreateEventState instance
  final EventsStates state;

  EventRepositoryImpl({required this.dio, required this.state});
  @override
  Future<EventsStates> createEvent({
    required String title,
    required String description,
    required DateTime date,
  }) async {
    try {
      final data = {
        'title': title,
        'description': description,
        'date': date,
      };

      await dio.post('', data: FormData.fromMap(data));
      return state.copyWith(status: EventStatus.success);
    } on ApiError catch (e) {
      return state.copyWith(
        status: EventStatus.error,
        error: e.apiErrorMessage,
      );
    }
  }

  @override
  Future<EventsStates> getAllEvents({required int userId}) async {
    try {
      final response = await dio.get('');
      final result =
          (response.data as List).map((e) => EventModel.fromMap(e)).toList();

      return state.copyWith(status: EventStatus.success, eventList: result);
    } on ApiError catch (e) {
      return state.copyWith(
        status: EventStatus.error,
        error: e.apiErrorMessage,
      );
    }
  }
}
