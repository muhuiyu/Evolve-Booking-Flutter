import 'package:evolve_api/evolve_api.dart';
import 'package:evolve_flutter/constants/all_constants.dart';
import 'package:evolve_flutter/features/booking/session_tile.dart';
import 'package:evolve_flutter/helpers/auth_consumer.dart';
import 'package:evolve_flutter/helpers/session_manager.dart';
import 'package:evolve_flutter/models/date.dart';
import 'package:evolve_flutter/models/session.dart';
import 'package:evolve_flutter/models/session_category.dart';
import 'package:evolve_flutter/models/session_location.dart';
import 'package:evolve_flutter/widgets/custom_button.dart';
import 'package:evolve_flutter/widgets/mount_observer.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  _fetchEvents(ApiClient client, List<Membership> memberships) async {
    _isWaitingForFetchedData = true;
    _sessions = await SessionManager.shared
        .getSessionsOnDate(_currentDate, client, memberships);
    _isWaitingForFetchedData = false;
  }

  _onMount(ApiClient client, List<Membership> memberships) {
    _fetchEvents(client, memberships);
    setState(() {});
  }

  List<Session> _sessions = [];
  List<Session> _displayedSessions = [];
  final _today = DateTime.now();
  late Date _currentDate;
  SessionCategory? _currentCategory;
  bool _isWaitingForFetchedData = true;
  bool _isWaitingForButtonActionResponse = false;

  @override
  void initState() {
    _currentDate = Date.fromDateTime(DateTime.now());
    _currentCategory = null;
    _sessions = [];
    _isWaitingForFetchedData = true;
    _isWaitingForButtonActionResponse = false;
    super.initState();
  }

  Future<void> _onCurrentDateChanged(
      ApiClient client, List<Membership> memberships) async {
    await _reloadSessions(client, memberships);
  }

  _configureDisplayedSessions() {
    if (_currentCategory != null) {
      _displayedSessions = _sessions
          .where((element) => (element.details.category == _currentCategory))
          .toList();
    }
  }

  Future<void> _reloadSessions(
      ApiClient client, List<Membership> memberships) async {
    await _fetchEvents(client, memberships);
    _configureDisplayedSessions();
    setState(() {});
  }

  _onCurrentCategoryChanged() {
    _configureDisplayedSessions();
  }

  Future<void> _afterReceivingAPIResponse(ApiClient client,
      List<Membership> memberships, SessionAction action) async {
    setState(() {
      _isWaitingForButtonActionResponse = false;
    });
    await _reloadSessions(client, memberships);
    Navigator.pop(context, action.name);
  }

  Future<void> _onActionButtonTapped(
      ApiClient client,
      List<Membership> memberships,
      Session session,
      SessionAction action) async {
    setState(() {
      _isWaitingForButtonActionResponse = true;
    });

    // TODO: add circular indicator
    switch (action) {
      case SessionAction.book:
        await SessionManager.shared.bookSession(client, memberships, session);
        // await Future.delayed(const Duration(seconds: 1));
        _afterReceivingAPIResponse(client, memberships, action);
        break;
      case SessionAction.cancel:
        await SessionManager.shared.cancelSession(client, memberships, session);
        _afterReceivingAPIResponse(client, memberships, action);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthConsumer(
      builder: (context, auth) => ApiClientConsumer(
        builder: ((context, apiClient) => MountObserver(
            onMount: () => _onMount(apiClient, auth.memberships),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _renderCategoryPicker(),
                  _renderDatePicker(apiClient, auth.memberships),
                  Expanded(
                      child: _renderSessionList(apiClient, auth.memberships)),
                ],
              ),
            ))),
      ),
    );
  }

  _renderCategoryPicker() {
    List<Widget> items = SessionCategory.values
        .map((e) => Padding(
              padding: const EdgeInsets.all(4),
              child: ActionChip(
                label: Text(e.name),
                onPressed: () {
                  _currentCategory = e;
                  _onCurrentCategoryChanged();
                  setState(() {});
                },
                labelStyle: TextStyleConstant.small(
                    context,
                    _currentCategory == e
                        ? ColorConstant.primary
                        : ColorConstant.secondaryLabel,
                    TextStyleWeight.normal),
                side: BorderSide(
                    color: _currentCategory == e
                        ? ColorConstant.primary
                        : ColorConstant.tertiaryLabel),
                backgroundColor: _currentCategory == e
                    ? ColorConstant.primary.withAlpha(50)
                    : ColorConstant.background,
              ),
            ))
        .toList();

    items.insert(
        0,
        Padding(
            padding: const EdgeInsets.all(4),
            child: ActionChip(
              label: const Text(TextConstant.all),
              onPressed: () {
                _currentCategory = null;
                setState(() {});
              },
              labelStyle: TextStyleConstant.small(
                  context,
                  _currentCategory == null
                      ? ColorConstant.primary
                      : ColorConstant.secondaryLabel,
                  TextStyleWeight.normal),
              side: BorderSide(
                  color: _currentCategory == null
                      ? ColorConstant.primary
                      : ColorConstant.tertiaryLabel),
              backgroundColor: _currentCategory == null
                  ? ColorConstant.primary.withAlpha(50)
                  : ColorConstant.background,
            )));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items,
        ),
      ),
    );
  }

  _renderDatePicker(ApiClient client, List<Membership> memberships) {
    Widget renderDateItem(Date date) => Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: date == _currentDate
                          ? ColorConstant.primary
                          : Colors.transparent,
                      width: 2))),
          child: MaterialButton(
            onPressed: () {
              _currentDate = date;
              _onCurrentDateChanged(client, memberships);
              setState(() {});
            },
            child: Text(
              date.weekdayAndDay,
              style: TextStyleConstant.small(
                  context,
                  date == _currentDate
                      ? ColorConstant.primary
                      : ColorConstant.label,
                  TextStyleWeight.normal),
            ),
          ),
        );

    var startDate = Date.init(_today);
    List<Widget> items = [];
    for (var i = 0; i < 7; i++) {
      var date = startDate.add(Duration(days: i));
      items.add(renderDateItem(date));
    }
    return Container(
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: ColorConstant.tertiaryLabel))),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, child: Row(children: items)),
    );
  }

  _renderBottomSheetOnSessionTileTapped(
      ApiClient client, List<Membership> memberships, Session session) {
    SessionAction action =
        session.isBookedByMe ? SessionAction.cancel : SessionAction.book;

    String buttonText;

    switch (action) {
      case SessionAction.book:
        buttonText = TextConstant.bookingConfirmationButtonText;
        break;
      case SessionAction.cancel:
        buttonText = TextConstant.cancelSessionConfirmationButtonText;
        break;
    }

    List<Widget> dialogContent = [
      Text(
        session.name,
        style: TextStyleConstant.h3(
            context, ColorConstant.label, TextStyleWeight.bold),
      ),
      SizedBox(height: SpacingConstant.small(context)),
      Text(
        session.getBookingConfirmationTimeDurationString,
        style: TextStyleConstant.body(
            context, ColorConstant.label, TextStyleWeight.normal),
      ),
      SizedBox(height: SpacingConstant.small(context)),
      Text(
        session.location.fullName,
        style: TextStyleConstant.body(
            context, ColorConstant.label, TextStyleWeight.normal),
      ),
      SizedBox(height: SpacingConstant.medium(context)),
      CustomTextButton(
        text: buttonText,
        onPressed: () =>
            _onActionButtonTapped(client, memberships, session, action),
        type: CustomButtonType.primary,
      ),
      SizedBox(height: SpacingConstant.medium(context)),
      Text(
        session.isWithinCancellationWindow
            ? TextConstant.bookingConfirmationCancelWarnings
            : session.getCancellationText,
        style: TextStyleConstant.small(
            context, ColorConstant.secondaryLabel, TextStyleWeight.normal),
      ),
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
          color: ColorConstant.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: dialogContent,
      ),
    );
  }

  _renderSessionList(ApiClient client, List<Membership> memberships) {
    if (_isWaitingForFetchedData) {
      return const Center(child: CircularProgressIndicator());
    } else {
      final sessions =
          _currentCategory == null ? _sessions : _displayedSessions;

      List<Widget> sessionList = sessions.map((e) {
        return SessionTile(
          session: e,
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) =>
                  _renderBottomSheetOnSessionTileTapped(client, memberships, e),
              isDismissible: true),
        );
      }).toList();
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: sessionList),
      );
    }
  }
}
