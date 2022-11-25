import 'package:evolve_flutter/constants/all_constants.dart';
import 'package:evolve_flutter/models/session.dart';
import 'package:evolve_flutter/models/session_location.dart';
import 'package:flutter/material.dart';

class UpcomingSessionCard extends StatelessWidget {
  const UpcomingSessionCard({super.key, required this.session});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstant.lightBackgroundGray, width: 1),
        borderRadius: BorderRadius.circular(20),
        color: ColorConstant.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _sessionDetailView(context),
          // _sessionActionView(context),
        ],
      ),
    );
  }

  static Widget emptyCard(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border:
              Border.all(color: ColorConstant.lightBackgroundGray, width: 1),
          borderRadius: BorderRadius.circular(20),
          color: ColorConstant.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/calendar.png'),
            ),
            SizedBox(height: SpacingConstant.medium(context)),
            Text(
              TextConstant.upcomingSessionEmptyStateTitle,
              style: TextStyleConstant.h4(
                  context, ColorConstant.label, TextStyleWeight.bold),
            ),
            SizedBox(height: SpacingConstant.trival(context)),
            Text(
              TextConstant.upcomingSessionEmptyStateDescription,
              style: TextStyleConstant.small(
                  context, ColorConstant.label, TextStyleWeight.normal),
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }

  Widget _sessionDetailView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            session.name,
            style: TextStyleConstant.h4(
                context, ColorConstant.label, TextStyleWeight.bold),
          ),
          SizedBox(height: SpacingConstant.trival(context)),
          Text(
            session.getBookingConfirmationTimeDurationString,
            style: TextStyleConstant.small(
                context, ColorConstant.label, TextStyleWeight.normal),
          ),
          SizedBox(height: SpacingConstant.trival(context)),
          Text(
            session.location.fullName,
            style: TextStyleConstant.small(
                context, ColorConstant.label, TextStyleWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget _sessionActionView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: ColorConstant.lightBackgroundGray, width: 0.5)),
          color: ColorConstant.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              _iconActionsBar(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconActionsBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            // TODO
          },
          icon: Icon(Icons.favorite_border,
              size: SpacingConstant.medium(context)),
        ),
        IconButton(
          onPressed: () {
            // TODO
          },
          icon: Icon(
            Icons.calendar_today_rounded,
            size: SpacingConstant.medium(context),
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO
          },
          icon: Icon(
            Icons.share,
            size: SpacingConstant.medium(context),
          ),
        ),
      ],
    );
  }
}
