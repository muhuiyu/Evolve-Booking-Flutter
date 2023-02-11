import 'dart:developer';

import 'package:evolve_api/evolve_api.dart';
import 'package:evolve_flutter/constants/all_constants.dart';
import 'package:evolve_flutter/features/dashboard/upcoming_session_card.dart';
import 'package:evolve_flutter/helpers/auth_consumer.dart';
import 'package:evolve_flutter/helpers/auth_context.dart';
import 'package:evolve_flutter/helpers/session_manager.dart';
import 'package:evolve_flutter/models/session.dart';
import 'package:evolve_flutter/widgets/mount_observer.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  _fetchEvents(ApiClient client, List<Membership> memberships) async {
    _upcomingSessions = await SessionManager.shared
        .getUpcomingBookedSessions(client, memberships);
    _bookedSessionsInThePastWeek = await SessionManager.shared
        .getSessionsBookedInThePastWeek(client, memberships);
    log('fetched ${_bookedSessionsInThePastWeek.length}');
    setState(() {});
  }

  _onMount(ApiClient client, List<Membership> memberships) {
    _fetchEvents(client, memberships);
    setState(() {});
  }

  _onSessionTileTapped(Session session) {
    // TODO: show bottomsheet
  }

  List<Session> _upcomingSessions = [];
  List<Session> _bookedSessionsInThePastWeek = [];

  @override
  Widget build(BuildContext context) {
    return AuthConsumer(
        builder: (context, auth) => ApiClientConsumer(
              builder: ((context, apiClient) => MountObserver(
                  onMount: () => _onMount(apiClient, auth.memberships),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      // padding: PaddingConstant.screenLayoutMarginsguide,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _renderHeader(auth),
                          const SizedBox(height: 20),
                          _renderUpcomingSession(),
                          // const SizedBox(height: 20),
                          // _renderBookAgain(),
                        ],
                      ),
                    ),
                  ))),
            ));
  }

  _renderUpcomingSession() {
    List<Widget> items = [
      ListTile(
          title: Text(
        TextConstant.upcomingSessions,
        style: TextStyleConstant.h3(
            context, ColorConstant.label, TextStyleWeight.bold),
      ))
    ];

    if (_upcomingSessions.isEmpty) {
      items.add(UpcomingSessionCard.emptyCard(context));
    } else {
      for (var session in _upcomingSessions) {
        items.add(UpcomingSessionCard(session: session));
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: items,
    );
  }

  Widget _renderBookAgain() {
    List<Widget> items = [];
    if (_bookedSessionsInThePastWeek.isNotEmpty) {
      items.add(ListTile(
          title: Text(
        TextConstant.bookAgain,
        style: TextStyleConstant.h3(
            context, ColorConstant.label, TextStyleWeight.bold),
      )));

      for (var session in _upcomingSessions) {
        items.add(UpcomingSessionCard(session: session));
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: items,
    );
  }

  _renderHeader(AuthContext auth) {
    final name = auth.memberships.first.firstName;

    return ListTile(
      title: Text(
        'Hello, $name',
        style: TextStyleConstant.h2(
            context, ColorConstant.label, TextStyleWeight.bold),
        textAlign: TextAlign.left,
      ),
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(
    //       'Hello, $name',
    //       style: TextStyleConstant.h2(
    //           context, ColorConstant.label, TextStyleWeight.bold),
    //       textAlign: TextAlign.left,
    //     ),
    //   ],
    // );
  }
}
