import 'dart:convert';

import 'package:evolve_api/evolve_api.dart';

class EventBookingResponseBody {
  final Event event;
  final String message;

  EventBookingResponseBody._({
    required this.event,
    required this.message,
  });

  factory EventBookingResponseBody.fromJson(Map<String, dynamic> json) {
    return EventBookingResponseBody._(
      event: Event.fromJson(json['event']),
      message: json['message'],
    );
  }
}

ApiRequest<EventBookingResponseBody> bookEventRequest({
  required YearMonthDay eventDate,
  required String eventId,
  required String memberId,
}) {
  return ApiRequest.post(
    path: '/booking/book-class',
    jsonBody: {
      'action': 'book',
      'eventDate': eventDate.toString(),
      'eventId': eventId,
      'memberId': memberId,
    },
    parseResponse: (response) =>
        EventBookingResponseBody.fromJson(jsonDecode(response.body)),
  );
}
