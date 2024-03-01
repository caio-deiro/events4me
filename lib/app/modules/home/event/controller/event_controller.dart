import 'package:bloc/bloc.dart';
import 'package:events4me/app/modules/home/event/repositories/event_repository.dart';
import 'package:events4me/app/modules/home/event/states/event_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/services/user/user_service.dart';

class EventController extends Cubit<EventsStates> {
  /// Repository instance
  final EventRepository repository;
  EventController(this.repository) : super(EventsStates());

  var userService = Modular.get<UserService>();

  /// General methods
  Future<void> getAllEvents() async {
    emit(state.copyWith(status: EventStatus.loading));
    final result = await repository.getAllEvents(userId: userService.user!.id);
    emit(result);
  }

  /// Home events methods
  void filterEventsByStatus({String? eventStatus}) {
    var filterStatus = state.eventList?.where((events) => events.status == eventStatus).toList();
    emit(state.copyWith(filterEventList: filterStatus));
  }

  /// Create events methods
  Future<void> createEvent({
    required String title,
    required String description,
    required DateTime date,
  }) async {
    emit(state.copyWith(status: EventStatus.loading));
    final result = await repository.createEvent(
      title: title,
      description: description,
      date: date,
    );
    emit(result);
  }

  /// Events calendar methods
  void filterDates() {
    final result = state.eventList;
    final dateList = result?.map((element) => element.date).toList();
    emit(state.copyWith(dateList: dateList));
  }
}
