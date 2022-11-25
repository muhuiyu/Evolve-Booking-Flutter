import 'dart:convert';

import 'package:evolve_api/evolve_api.dart';
import 'package:evolve_api/src/requests/book_event_request.dart';

ApiRequest<EventBookingResponseBody> cancelEventBookingRequest({
  required YearMonthDay eventDate,
  required String eventId,
  required String memberId,
}) {
  return ApiRequest.post(
    path: '/booking/book-class',
    jsonBody: {
      'action': 'cancel',
      'eventDate': eventDate.toString(),
      'eventId': eventId,
      'memberId': memberId,
    },
    parseResponse: (response) =>
        EventBookingResponseBody.fromJson(jsonDecode(response.body)),
  );
}
