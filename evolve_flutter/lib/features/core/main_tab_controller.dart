import 'dart:developer';

import 'package:evolve_api/evolve_api.dart';
import 'package:evolve_flutter/constants/all_constants.dart';
import 'package:evolve_flutter/features/account/account_page.dart';
import 'package:evolve_flutter/features/booking/booking_page.dart';
import 'package:evolve_flutter/features/core/main_tab_item.dart';
import 'package:evolve_flutter/features/dashboard/dashboard_page.dart';
import 'package:evolve_flutter/helpers/auth_context.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MainTabController extends StatefulWidget {
  final String token;
  final List<Membership> memberships;
  const MainTabController(
      {super.key, required this.token, required this.memberships});

  @override
  State<MainTabController> createState() => _MainTabControllerState();
}

class _MainTabControllerState extends State<MainTabController> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    const DashboardPage(),
    const BookingPage(),
    // const AccountPage(),
  ];

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthContext(
                token: widget.token, memberships: widget.memberships)),
        ChangeNotifierProvider(
            create: (_) => ApiClientContext(
                requestConfigurator: _MainApiRequestConfigurator(
                    token: widget.token,
                    baseRequestConfigurator: ApiRequestConfigurator())))
      ],
      child: Scaffold(
        appBar: AppBar(
            // title: Text(
            //   'Hello, $name',
            //   style: TextStyleConstant.h2(
            //       context, ColorConstant.label, TextStyleWeight.bold),
            // ),
            // centerTitle: false,
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          _renderAlertDialog(widget.memberships.first.id)),
                  icon: const Icon(
                    Icons.qr_code,
                    color: ColorConstant.primary,
                  ))
            ]),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (value) {
              _selectedIndex = value;
              setState(() {});
            },
            items: MainTabItem.values
                .map((e) => e.bottomNavigationBarItem)
                .toList()),
      ),
    );
  }

  _renderAlertDialog(String memberId) {
    return AlertDialog(
      title: const Text(TextConstant.qrCodeAlertTitle),
      content: SizedBox(
        width: 320,
        height: 260,
        child: QrImage(
          data: memberId,
          version: 3,
          size: 320,
          gapless: true,
          errorStateBuilder: (context, error) {
            log(error.toString());
            return const Center(
              child: Text(
                TextConstant.errorMessageGeneral,
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, TextConstant.done),
          child: const Text(TextConstant.done),
        ),
      ],
    );
  }
}

class _MainApiRequestConfigurator implements ApiRequestConfigurator {
  final ApiRequestConfigurator _baseRequestConfigurator;
  final String _token;

  _MainApiRequestConfigurator(
      {required baseRequestConfigurator, required token})
      : _baseRequestConfigurator = baseRequestConfigurator,
        _token = token;

  @override
  Request configureRequest(ApiRequest apiRequest) {
    final request = _baseRequestConfigurator.configureRequest(apiRequest);
    request.headers.addAll({'Authorization': 'Bearer $_token'});
    return request;
  }
}
