import 'package:evolve_flutter/constants/all_constants.dart';
import 'package:evolve_flutter/extensions/date_time_extensions.dart';
import 'package:evolve_flutter/models/session.dart';
import 'package:evolve_flutter/models/session_location.dart';
import 'package:flutter/material.dart';

class SessionTile extends StatelessWidget {
  const SessionTile({
    super.key,
    required this.session,
    this.onTap,
  });

  final Session session;
  final Function? onTap;

  _onTap() {
    onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        decoration: BoxDecoration(
          border: const Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          ),
          color: session.isBookingAvailable
              ? Colors.transparent
              : ColorConstant.inactiveGrayBackground,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderTime(context),
            SizedBox(width: SpacingConstant.large(context)),
            _renderTitles(context),
            _renderReservationStatus(context),
          ],
        ),
      ),
    );
  }

  _renderTime(BuildContext context) {
    return SizedBox(
      width: 65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            session.startTime.getString,
            style: TextStyleConstant.small(
                context,
                session.isBookingAvailable
                    ? ColorConstant.label
                    : ColorConstant.label.withAlpha(80),
                TextStyleWeight.normal),
          ),
          SizedBox(height: SpacingConstant.trival(context)),
          Text(
            session.getDurationString,
            style: TextStyleConstant.small(
                context,
                session.isBookingAvailable
                    ? ColorConstant.secondaryLabel
                    : ColorConstant.secondaryLabel.withAlpha(80),
                TextStyleWeight.normal),
          )
        ],
      ),
    );
  }

  _renderTitles(BuildContext context) {
    var items = [
      Text(
        session.name,
        style: TextStyleConstant.body(
            context,
            session.isBookingAvailable
                ? ColorConstant.label
                : ColorConstant.label.withAlpha(80),
            TextStyleWeight.medium),
      ),
      SizedBox(height: SpacingConstant.trival(context)),
      Text(
        session.location.fullName,
        style: TextStyleConstant.small(
            context,
            session.isBookingAvailable
                ? ColorConstant.secondaryLabel
                : ColorConstant.secondaryLabel.withAlpha(80),
            TextStyleWeight.normal),
      )
    ];

    // TODO: determine timeslot conflict
    // if (!session.isBookingAvailable) {
    //   items.add(SizedBox(
    //     height: SpacingConstant.trival(context),
    //   ));
    //   items.add(Text(
    //     TextConstant.haveAnotherBookedSessionHintText,
    //     style: TextStyleConstant.desc(
    //         context, ColorConstant.secondaryLabel, TextStyleWeight.normal),
    //   ));
    // }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      ),
    );
  }

  _renderReservationStatus(BuildContext context) {
    if (session.isBookedByMe) {
      // return const Text(TextConstant.reserved);
      return Chip(
        padding: const EdgeInsets.all(2),
        backgroundColor: Colors.lightGreen.withAlpha(150),
        label: Text(
          TextConstant.reserved.toUpperCase(),
          style: TextStyleConstant.desc(
              context, ColorConstant.secondaryLabel, TextStyleWeight.normal),
        ),
      );
    } else {
      return Container();
    }
  }
}
