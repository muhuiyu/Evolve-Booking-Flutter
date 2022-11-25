import 'package:evolve_api/src/requests/book_event_request.dart';
import 'package:evolve_api/src/requests/cancel_event_booking_request.dart';
import 'package:evolve_api/src/requests/get_events_request.dart';
import 'package:evolve_api/src/requests/get_memberships_request.dart';
import 'package:evolve_api/src/requests/sign_in_request.dart';
import 'package:evolve_api/src/requests/verify_code_request.dart';

class Api {
  const Api._();

  static const signIn = signInRequest;
  static const verifyCode = verifyCodeRequest;
  static const getMemberships = getMembershipsRequest;
  static const getEvents = getEventsRequest;
  static const bookEvent = bookEventRequest;
  static const cancelEventBooking = cancelEventBookingRequest;
}
