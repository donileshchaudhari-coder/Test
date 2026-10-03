import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../navigation/screen_routes.dart';

class NativeScreenPage extends StatelessWidget {
  const NativeScreenPage({super.key, required this.route});

  final ScreenRoute route;

  static const _ink = Color(0xFF171923);
  static const _muted = Color(0xFF697386);
  static const _blue = Color(0xFF087EFF);
  static const _green = Color(0xFF21C45A);
  static const _canvas = Color(0xFFF2F3F8);

  @override
  Widget build(BuildContext context) {
    final hasNavigation = !_isModalOrAuth;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: _canvas,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: route == ScreenRoute.addNumbers
                    ? _addNumbers(context)
                    : _screenBody(context),
              ),
              if (hasNavigation) _bottomNavigation(context),
            ],
          ),
        ),
      ),
    );
  }

  bool get _isModalOrAuth =>
      route == ScreenRoute.splash ||
      route == ScreenRoute.addNumbers ||
      route == ScreenRoute.profileAppleSignIn ||
      route == ScreenRoute.profileGoogleSignIn;

  Widget _screenBody(BuildContext context) {
    switch (route) {
      case ScreenRoute.splash:
        return _splash(context);
      case ScreenRoute.freedomEmpty:
        return _freedomEmpty(context);
      case ScreenRoute.addNumbers:
        return const SizedBox.shrink();
      case ScreenRoute.freedomDashboard:
      case ScreenRoute.freedomSummary:
        return _freedomDashboard(context);
      case ScreenRoute.freedomDetails:
        return _freedomDetails(context);
      case ScreenRoute.projection:
        return _projection(context);
      case ScreenRoute.journey:
        return _journey(context);
      case ScreenRoute.cashFlow:
        return _cashFlow(context);
      case ScreenRoute.categoryDetail:
        return _categoryDetail(context);
      case ScreenRoute.assets:
        return _assets(context);
      case ScreenRoute.savingsAllocation:
        return _savingsAllocation(context);
      case ScreenRoute.coach:
        return _coach(context);
      case ScreenRoute.profile:
        return _profile(context);
      case ScreenRoute.profileSettings:
        return _profileSettings(context);
      case ScreenRoute.profileSignedIn:
        return _profileSignedIn(context);
      case ScreenRoute.profileAppleSignIn:
        return _providerSignIn(context, apple: true);
      case ScreenRoute.profileGoogleSignIn:
        return _providerSignIn(context, apple: false);
    }
  }

  Widget _scroll(List<Widget> children,
      {EdgeInsets padding = const EdgeInsets.fromLTRB(16, 16, 16, 24)}) {
    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  Widget _heading(String title,
      {String? subtitle, Widget? trailing, double size = 30}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: size,
                      height: 1.1,
                      fontWeight: FontWeight.w700,
                      color: _ink)),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(color: _muted, fontSize: 14)),
              ],
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _profileShortcut(BuildContext context) => _iconButton(
        context,
        Icons.circle,
        'View profile settings',
        ScreenRoute.profileSettings,
        color: _blue,
      );

  Widget _iconButton(
    BuildContext context,
    IconData icon,
    String label,
    ScreenRoute target, {
    Color color = _ink,
    bool back = false,
  }) {
    return Semantics(
      excludeSemantics: true,
      button: true,
      label: label,
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(side: BorderSide(color: Color(0xFFE0E2E9))),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => _navigate(context, target, replace: back),
          child: SizedBox(
            width: 42,
            height: 42,
            child: Icon(icon, size: 19, color: color),
          ),
        ),
      ),
    );
  }

  Widget _backHeader(
    BuildContext context,
    String title,
    ScreenRoute target, {
    String? backLabel,
  }) {
    return Row(
      children: [
        _iconButton(
            context, Icons.arrow_back, backLabel ?? 'Back to $title', target,
            color: _blue, back: true),
        const SizedBox(width: 12),
        Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w700, color: _ink))),
      ],
    );
  }

  Widget _card(
      {required Widget child,
      EdgeInsets padding = const EdgeInsets.all(16),
      Color color = Colors.white}) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0E2E9)),
        boxShadow: const [
          BoxShadow(
              color: Color(0x080D1525), blurRadius: 12, offset: Offset(0, 3))
        ],
      ),
      child: child,
    );
  }

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(title,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: _ink)),
      );

  Widget _actionButton(
    BuildContext context,
    String text,
    String label,
    ScreenRoute target, {
    bool filled = true,
    bool replace = false,
    Color fill = _blue,
    Color textColor = Colors.white,
    double height = 50,
  }) {
    return Semantics(
      excludeSemantics: true,
      button: true,
      label: label,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: filled
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: fill,
                  foregroundColor: textColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                onPressed: () => _navigate(context, target, replace: replace),
                child: Text(text,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              )
            : OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: _muted,
                  side: const BorderSide(color: Color(0xFFD8DBE4)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => _navigate(context, target, replace: replace),
                child: Text(text,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
      ),
    );
  }

  Widget _bottomNavigation(BuildContext context) {
    const routes = [
      ScreenRoute.freedomDashboard,
      ScreenRoute.cashFlow,
      ScreenRoute.assets,
      ScreenRoute.coach,
    ];
    const labels = ['Freedom', 'Cash Flow', 'Assets', 'Coach'];
    const icons = [
      Icons.auto_awesome,
      Icons.bar_chart,
      Icons.square,
      Icons.circle
    ];
    final selected = switch (route) {
      ScreenRoute.cashFlow || ScreenRoute.categoryDetail => 1,
      ScreenRoute.assets || ScreenRoute.savingsAllocation => 2,
      ScreenRoute.coach => 3,
      _ => 0,
    };
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFD8DAE1))),
      ),
      child: Row(
        children: [
          for (var index = 0; index < routes.length; index++)
            Expanded(
              child: Semantics(
                excludeSemantics: true,
                button: true,
                label: 'Open ${labels[index]} screen',
                child: InkWell(
                  onTap: () => _navigate(context, routes[index], replace: true),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icons[index],
                          size: 21,
                          color: index == selected
                              ? _blue
                              : const Color(0xFF9699A3)),
                      const SizedBox(height: 4),
                      Text(labels[index],
                          style: TextStyle(
                              fontSize: 11,
                              color: index == selected
                                  ? _blue
                                  : const Color(0xFF858894))),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _splash(BuildContext context) => Center(
        child: Semantics(
          container: true,
          excludeSemantics: true,
          button: true,
          label: 'Continue to Freedom setup',
          onTap: () =>
              _navigate(context, ScreenRoute.freedomEmpty, replace: true),
          child: InkWell(
            onTap: () =>
                _navigate(context, ScreenRoute.freedomEmpty, replace: true),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 58,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.check, size: 38, color: _ink),
                ),
                SizedBox(height: 26),
                Text('Financial Freedom',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: _ink)),
                SizedBox(height: 8),
                Text('Build Freedom. One Month At A Time.',
                    style: TextStyle(color: _muted)),
              ],
            ),
          ),
        ),
      );

  Widget _freedomEmpty(BuildContext context) => _scroll([
        _heading('Freedom',
            subtitle: 'Summary', trailing: _profileShortcut(context)),
        const SizedBox(height: 14),
        _card(
          child: Column(
            children: [
              const Row(children: [
                _Pill('LEVEL 1'),
                SizedBox(width: 8),
                Text('DEPENDENT',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w700)),
              ]),
              const SizedBox(height: 18),
              Row(children: [
                _ring('0%', 0, color: const Color(0xFFDADCE3)),
                const SizedBox(width: 20),
                const Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('0%',
                            style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w700,
                                color: _ink)),
                        Text('Financial Freedom',
                            style: TextStyle(color: _muted)),
                      ]),
                ),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(children: [
          Expanded(
              child: _smallMetric(
                  'Asset Income',
                  'Passive / Investment returns',
                  '₹0/mo',
                  Icons.trending_up,
                  Colors.green)),
          const SizedBox(width: 12),
          Expanded(
              child: _smallMetric('Lifestyle Cost', 'Target monthly expenses',
                  '₹0/mo', Icons.show_chart, Colors.orange)),
        ]),
        const SizedBox(height: 12),
        _labelValueCard(
            'Freedom Date', 'Based on current accumulation', 'Unknown'),
        const SizedBox(height: 12),
        _labelValueCard(
            'Next Level', 'Required score increase', 'Add data to calculate',
            valueColor: _blue),
        const SizedBox(height: 14),
        _card(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Text("Let's calculate your freedom score",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700, color: _ink)),
            const SizedBox(height: 8),
            const Text(
                'It only takes two simple numbers to kickstart your tracking journey.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _muted)),
            const SizedBox(height: 14),
            _actionButton(
                context,
                'Add My Numbers',
                'Add monthly income and lifestyle cost',
                ScreenRoute.addNumbers),
          ]),
        ),
      ]);

  Widget _freedomDashboard(BuildContext context) => _scroll([
        _heading('Freedom',
            subtitle: 'Summary of your path to financial freedom',
            trailing: _profileShortcut(context),
            size: 34),
        const SizedBox(height: 16),
        _card(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Pill('LEVEL 3'),
                  Text('SECURE',
                      style:
                          TextStyle(color: _green, fontWeight: FontWeight.w700))
                ]),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _ring('37%', .37),
              const SizedBox(width: 18),
              const Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('37%',
                          style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w700,
                              color: _ink)),
                      Text('Financial Freedom Achieved',
                          style: TextStyle(color: _muted)),
                    ]),
              ),
            ]),
          ]),
        ),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(
              child: _smallMetric(
                  'Asset Income',
                  'Passive / Investment returns',
                  '₹45,000/mo',
                  Icons.trending_up,
                  Colors.green)),
          const SizedBox(width: 12),
          Expanded(
              child: _smallMetric(
                  'Lifestyle Cost',
                  'Target monthly expenses',
                  '₹120,000/mo',
                  Icons.account_balance_wallet,
                  Colors.blueGrey)),
        ]),
        const SizedBox(height: 12),
        _labelValueCard('Freedom Date', 'Based on accumulation', 'March 2036'),
        const SizedBox(height: 12),
        _labelValueCard(
            'Next Level', 'Required score increase', 'Need ₹15,000/mo more',
            valueColor: Colors.deepOrange),
        const SizedBox(height: 12),
        _card(
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              _SmallEyebrow('◆  HIGHEST IMPACT ACTION'),
              SizedBox(height: 10),
              Text('Increase Asset Income +₹10,000/month',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16, color: _ink)),
              SizedBox(height: 5),
              Text(
                  'This will push your freedom score past 45% and advance your target milestone year by 14 months.',
                  style: TextStyle(color: _muted)),
            ])),
        const SizedBox(height: 12),
        _actionButton(context, 'View Freedom details', 'View Freedom details',
            ScreenRoute.freedomDetails,
            filled: false),
        const SizedBox(height: 10),
        _actionButton(context, 'View journey stages', 'View journey stages',
            ScreenRoute.journey,
            filled: false),
      ]);

  Widget _addNumbers(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          _freedomEmpty(context),
          const ColoredBox(color: Color(0x550F1320)),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 28, 16, 20),
              child: _card(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                          child: SizedBox(
                              width: 40, child: Divider(thickness: 4))),
                      const SizedBox(height: 14),
                      const Text('Add My Numbers',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: _ink)),
                      const SizedBox(height: 8),
                      const Text(
                          "We'll use these to compute your immediate passive freedom score.",
                          style: TextStyle(color: _muted)),
                      const SizedBox(height: 22),
                      const _FieldLabel('MONTHLY LIFESTYLE COST'),
                      const SizedBox(height: 8),
                      const _NumberField(value: '120,000'),
                      const SizedBox(height: 16),
                      const _FieldLabel('MONTHLY ASSET INCOME'),
                      const SizedBox(height: 8),
                      const _NumberField(value: '45,000'),
                      const SizedBox(height: 20),
                      _actionButton(context, 'Compute Freedom',
                          'Compute Freedom score', ScreenRoute.freedomSummary,
                          replace: true, fill: Colors.black),
                      const SizedBox(height: 10),
                      _actionButton(
                          context,
                          'Cancel',
                          'Cancel and return to Freedom setup',
                          ScreenRoute.freedomEmpty,
                          filled: false,
                          replace: true),
                    ]),
              ),
            ),
          ),
        ],
      );

  Widget _freedomDetails(BuildContext context) => _scroll([
        _backHeader(context, 'Freedom Details', ScreenRoute.freedomDashboard,
            backLabel: 'Back to Freedom'),
        const SizedBox(height: 16),
        _card(
            child: Column(children: [
          _ring('37%', .37, color: _green, size: 130),
          const SizedBox(height: 16),
          const Text('Calculation Breakdown', style: TextStyle(color: _muted)),
          const SizedBox(height: 6),
          const Text('₹45,000  ÷  ₹120,000  =  37.5%',
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 16, color: _ink)),
        ])),
        _section('Historical Progress'),
        _card(
            padding: EdgeInsets.zero,
            child: const Column(children: [
              _DataRow('Current Score', '37.5%', '+2.5%'),
              Divider(height: 1),
              _DataRow('3 Months Ago', '35.0%', '+6.0%'),
              Divider(height: 1),
              _DataRow('1 Year Ago', '29.0%', 'Baseline'),
            ])),
        const SizedBox(height: 20),
        _actionButton(context, 'View Projection', 'View Freedom projection',
            ScreenRoute.projection),
      ]);

  Widget _projection(BuildContext context) => _scroll([
        Row(children: [
          _iconButton(context, Icons.arrow_back, 'Back to Freedom details',
              ScreenRoute.freedomDetails,
              color: _blue, back: true),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Projection',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),
          ),
        ]),
        const SizedBox(height: 18),
        const Text('Your Path to 100%',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: _ink)),
        const SizedBox(height: 5),
        const Text(
            'Projected trajectory based on adding ₹5,000/mo extra savings continuously.',
            style: TextStyle(color: _muted)),
        const SizedBox(height: 16),
        _card(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              for (final item in const [
                (2026, 37),
                (2027, 44),
                (2028, 52),
                (2029, 61),
                (2030, 70),
                (2031, 82),
                (2032, 94),
                (2033, 100)
              ])
                _ProgressYear(item.$1, item.$2, last: item.$1 == 2033),
            ])),
        const SizedBox(height: 16),
        _card(
            child: const Row(children: [
          CircleAvatar(
              backgroundColor: _green,
              child: Icon(Icons.emoji_events, color: Colors.white)),
          SizedBox(width: 12),
          Expanded(
              child: Text(
                  '2033 • Freedom Target\nYou are on track to achieve complete financial independence in exactly 7 years!',
                  style: TextStyle(color: _ink, height: 1.45))),
        ])),
      ]);

  Widget _journey(BuildContext context) => _scroll([
        _backHeader(context, 'Journey Stages', ScreenRoute.freedomDashboard,
            backLabel: 'Back to Freedom'),
        const SizedBox(height: 18),
        const Text('Your Path Through the Levels',
            style: TextStyle(fontWeight: FontWeight.w700, color: _ink)),
        const SizedBox(height: 5),
        const Text(
            'Quiet stages designed to map progress from dependent to abundant wealth.',
            style: TextStyle(color: _muted)),
        const SizedBox(height: 12),
        for (final stage in const [
          ('Abundance', '₹1,000,000/mo passive', 'LOCKED'),
          ('Freedom', '₹500,000/mo passive', 'LOCKED'),
          ('Nearly Free', '₹250,000/mo passive', 'LOCKED'),
          ('Independent', 'Need ₹15,000/mo more passive', 'NEXT LEVEL'),
          ('Secure', '₹45,000/mo achieved', 'YOU ARE HERE'),
          ('Stable', 'Stable emergency reserve', 'COMPLETED'),
          ('Dependent', 'Accumulating core reserves', 'COMPLETED'),
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _card(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              child: Row(children: [
                CircleAvatar(
                    radius: 18,
                    backgroundColor: stage.$1 == 'Secure'
                        ? const Color(0xFF635BEE)
                        : const Color(0xFFF0F1F5),
                    child: Icon(stage.$1 == 'Secure' ? Icons.star : Icons.lock,
                        size: 18,
                        color: stage.$1 == 'Secure'
                            ? Colors.white
                            : const Color(0xFF9296A1))),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(stage.$1,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, color: _ink)),
                      Text(stage.$2,
                          style: const TextStyle(color: _muted, fontSize: 12))
                    ])),
                _Pill(stage.$3),
              ]),
            ),
          ),
        const SizedBox(height: 6),
        _actionButton(context, 'View current Freedom level details',
            'View current Freedom level details', ScreenRoute.freedomDetails,
            filled: false),
      ]);

  Widget _cashFlow(BuildContext context) => _scroll([
        _heading('Cash Flow',
            subtitle: "This month's run rate",
            trailing: _profileShortcut(context),
            size: 34),
        const SizedBox(height: 16),
        _card(
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Row(children: [
                Expanded(child: _SmallEyebrow("THIS MONTH'S RUN RATE")),
                SizedBox(width: 8),
                _Pill('40% SAVINGS RATE',
                    color: Color(0xFFEAF4FF), textColor: _blue)
              ]),
              SizedBox(height: 14),
              _SmallEyebrow('NET SAVINGS'),
              Text('₹80,000',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF11B8A5))),
              SizedBox(height: 10),
              Row(children: [
                Expanded(
                    child: _AmountBox(
                        title: 'INFLOW (INCOME)',
                        amount: '₹200,000',
                        color: Color(0xFF18A85A))),
                SizedBox(width: 10),
                Expanded(
                    child: _AmountBox(
                        title: 'OUTFLOW (EXPENSES)',
                        amount: '₹120,000',
                        color: Color(0xFFEE5B18))),
              ]),
              SizedBox(height: 10),
              _AmountBox(
                  title: 'NET SAVINGS',
                  amount: '₹80,000',
                  color: Color(0xFF11B8A5)),
            ])),
        _section('Historical Baseline'),
        _card(
            child: const Column(children: [
          Row(children: [
            Expanded(child: _PercentBox('40%', 'This Month')),
            SizedBox(width: 8),
            Expanded(child: _PercentBox('37%', '3M Avg')),
            SizedBox(width: 8),
            Expanded(child: _PercentBox('34%', '12M Avg')),
          ]),
          SizedBox(height: 14),
          _BarChart(),
          SizedBox(height: 12),
          _Callout(
              text:
                  'Your Freedom score is projected to rise from 37% → 38% this month.'),
        ])),
        _section('Expense Categories'),
        _card(
            padding: EdgeInsets.zero,
            child: Column(children: [
              for (final item in const [
                ('Housing', '₹45,000', Icons.home, Colors.green),
                ('Food & Dining', '₹22,000', Icons.coffee, Colors.deepOrange),
                ('Education', '₹15,000', Icons.menu_book, _blue),
                ('Travel & Commute', '₹12,000', Icons.place, Colors.deepPurple),
                ('Shopping', '₹18,000', Icons.shopping_bag, Colors.teal),
                ('Other Expenses', '₹8,000', Icons.credit_card, Colors.red)
              ])
                _CategoryRow(item.$1, item.$2, item.$3, item.$4,
                    onTap: () =>
                        _navigate(context, ScreenRoute.categoryDetail)),
            ])),
      ]);

  Widget _categoryDetail(BuildContext context) => _scroll([
        _backHeader(context, 'Housing', ScreenRoute.cashFlow,
            backLabel: 'Back to Cash Flow'),
        const SizedBox(height: 18),
        _card(
            child: const Column(children: [
          Row(children: [
            Expanded(
                child: Text('This Month', style: TextStyle(color: _muted))),
            SizedBox(width: 8),
            Text('₹45,000',
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 28, color: _ink)),
          ]),
          Divider(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('₹44,000\n3M Avg',
                textAlign: TextAlign.left,
                style: TextStyle(color: _muted, height: 1.5)),
            Text('₹42,000\n12M Avg',
                textAlign: TextAlign.right,
                style: TextStyle(color: _muted, height: 1.5)),
          ]),
        ])),
        _section('Historical Trend (6 Months)'),
        _card(child: const SizedBox(height: 150, child: _TrendChart())),
        _section('Recent Transactions'),
        _card(
            padding: EdgeInsets.zero,
            child: const Column(children: [
              _DataRow('Monthly Rent', '₹40,000', '01 Mar 2026'),
              Divider(height: 1),
              _DataRow('Plumbing Repair', '₹3,500', '12 Feb 2026'),
              Divider(height: 1),
              _DataRow('Electric Bill', '₹1,500', '08 Feb 2026'),
            ])),
      ]);

  Widget _assets(BuildContext context) => _scroll([
        const Text('PERSONAL VIEW',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8A8E9B),
                letterSpacing: .5)),
        const SizedBox(height: 5),
        _heading('Assets', trailing: _profileShortcut(context), size: 38),
        const SizedBox(height: 10),
        const Text('A quiet overview of income-producing and growth assets.',
            style: TextStyle(color: _muted)),
        const SizedBox(height: 14),
        _card(
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              _SmallEyebrow('●  TOTAL MONTHLY PASSIVE INCOME'),
              SizedBox(height: 10),
              Text('₹33,000/mo',
                  style: TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w700, color: _ink)),
              SizedBox(height: 12),
              Row(children: [
                Expanded(
                    child: _AmountBox(
                        title: 'Monthly preview', amount: '3 assets')),
                SizedBox(width: 10),
                Expanded(
                    child: _AmountBox(title: 'Latest month', amount: '₹33,000'))
              ]),
              SizedBox(height: 10),
              _BarChart(),
            ])),
        const SizedBox(height: 12),
        _actionButton(
          context,
          'View monthly asset income allocation',
          'View monthly asset income allocation',
          ScreenRoute.savingsAllocation,
          filled: false,
        ),
        _section('Income Producing Assets'),
        _card(
            padding: EdgeInsets.zero,
            child: Column(children: [
              for (final item in const [
                (
                  'Goa Property',
                  'Airbnb Rental yield',
                  '₹20,000/mo',
                  Icons.home
                ),
                (
                  'Dividend Portfolio',
                  'Equity distributions',
                  '₹8,000/mo',
                  Icons.trending_up
                ),
                (
                  'Fixed Deposit (FD)',
                  'Guaranteed quarterly income',
                  '₹5,000/mo',
                  Icons.shield
                )
              ])
                _AssetRow(item.$1, item.$2, item.$3, item.$4),
            ])),
        _section('Growth Assets'),
        _card(
            padding: EdgeInsets.zero,
            child: const Column(children: [
              _DataRow('Mutual Funds', '₹10,00,000', '+₹45,000 this month'),
              Divider(height: 1),
              _DataRow('Stocks', '₹5,00,000', '+₹12,000 this month'),
              Divider(height: 1),
              _DataRow('Land Equity', '₹15,00,000', 'Stable'),
            ])),
        const SizedBox(height: 12),
        _actionButton(context, 'View savings allocation',
            'View savings allocation', ScreenRoute.savingsAllocation,
            filled: false),
      ]);

  Widget _savingsAllocation(BuildContext context) => _scroll([
        _backHeader(context, 'Savings Allocation', ScreenRoute.assets,
            backLabel: 'Back to Assets'),
        const SizedBox(height: 18),
        _card(
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              _SmallEyebrow('TOTAL MONTHLY SAVINGS'),
              SizedBox(height: 8),
              Text('₹80,000',
                  style: TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w700, color: _ink)),
            ])),
        _section('Active Allocations'),
        for (final item in const [
          ('Mutual Funds', '₹40,000', '50%', _blue),
          ('Emergency Fund', '₹20,000', '25%', _green),
          ('Rental Fund', '₹20,000', '25%', Colors.orange)
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _card(
                child: Column(children: [
              Row(children: [
                Icon(Icons.circle, size: 12, color: item.$4),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(item.$1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, color: _ink))),
                Text(item.$2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: _ink)),
                const SizedBox(width: 8),
                Text('(${item.$3})', style: const TextStyle(color: _muted)),
              ]),
              const SizedBox(height: 10),
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                      value: double.parse(item.$3.replaceAll('%', '')) / 100,
                      minHeight: 7,
                      color: item.$4,
                      backgroundColor: const Color(0xFFF0F1F5))),
            ])),
          ),
      ]);

  Widget _coach(BuildContext context) => _scroll([
        _heading('Coach', trailing: _profileShortcut(context)),
        const SizedBox(height: 16),
        _card(
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Row(children: [
                CircleAvatar(
                    backgroundColor: Color(0xFFF0F1F5),
                    child: Icon(Icons.auto_awesome, color: _ink)),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Freedom Coach',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: _ink)),
                      Text('AI Advisor • Active',
                          style: TextStyle(color: _muted))
                    ],
                  ),
                ),
              ]),
              SizedBox(height: 16),
              Text(
                  'Ask me anything about your financial journey. I can analyze your cash flow, calculate early retirement milestones, or suggest higher-impact allocations.',
                  style: TextStyle(height: 1.5, color: _muted)),
            ])),
        _section('SUGGESTED DISCUSSIONS'),
        for (final question in const [
          'How do I retire sooner?',
          'Can I buy a house next year?',
          'How much more passive income do I need?',
          'Analyze my savings rate potential'
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Semantics(
              excludeSemantics: true,
              button: true,
              label: question == 'How do I retire sooner?'
                  ? 'Ask how to retire sooner'
                  : question,
              child: _card(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: InkWell(
                  onTap: () => _navigate(
                      context,
                      question.startsWith('How do I')
                          ? ScreenRoute.projection
                          : question.startsWith('Analyze')
                              ? ScreenRoute.cashFlow
                              : ScreenRoute.assets),
                  child: Row(children: [
                    Expanded(
                        child: Text(question,
                            style: const TextStyle(color: _ink))),
                    const Icon(Icons.chevron_right, color: _muted)
                  ]),
                ),
              ),
            ),
          ),
        const SizedBox(height: 8),
        const Text(
            'This AI assistant provides informational models. Please consult certified experts for regulated fiduciary advice.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted, fontSize: 12)),
      ]);

  Widget _profile(BuildContext context) => _scroll([
        _heading('Profile'),
        const SizedBox(height: 14),
        _card(
            child: const Column(children: [
          CircleAvatar(
              radius: 38,
              backgroundColor: _canvas,
              child: Icon(Icons.person_outline, size: 38, color: _muted)),
          SizedBox(height: 10),
          Text('Alerzano Sen',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: _ink)),
          _SmallEyebrow('LEVEL 3 SECURE MEMBER'),
        ])),
        const SizedBox(height: 14),
        _card(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              const _SmallEyebrow('OPTIONAL SIGN-IN'),
              const SizedBox(height: 8),
              const Text(
                  'Keep your profile private, or link a provider to sync access across devices.',
                  style: TextStyle(color: _muted)),
              const SizedBox(height: 14),
              _actionButton(context, 'Sign In with Apple', 'Sign in with Apple',
                  ScreenRoute.profileAppleSignIn,
                  fill: Colors.black),
              const SizedBox(height: 10),
              _actionButton(context, 'Continue with Google',
                  'Continue with Google', ScreenRoute.profileGoogleSignIn,
                  filled: false),
            ])),
        _section('ACCOUNT PERKS'),
        _card(
            padding: EdgeInsets.zero,
            child: const Column(children: [
              _PerkRow(Icons.cloud_sync, 'Secure Backup',
                  'Secure cloud vault for financial logs'),
              Divider(height: 1),
              _PerkRow(Icons.sync, 'Cross-Device Sync',
                  'Auto-sync with iPad & desktop nodes'),
              Divider(height: 1),
              _PerkRow(Icons.shield_outlined, 'Milestone protection',
                  'Set up strict lockouts for target targets'),
            ])),
        const SizedBox(height: 12),
        _actionButton(context, 'Open profile settings', 'Open profile settings',
            ScreenRoute.profileSettings,
            filled: false),
      ]);

  Widget _profileSettings(BuildContext context) => _scroll([
        Row(children: [
          _iconButton(
              context, Icons.arrow_back, 'Back to Profile', ScreenRoute.profile,
              color: _blue, back: true),
          const SizedBox(width: 10),
          const Expanded(
              child: Text('Profile Settings',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700, color: _ink))),
          const Icon(Icons.settings, color: _muted),
        ]),
        const SizedBox(height: 22),
        const CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white,
            child: Icon(Icons.person_outline, size: 38, color: _muted)),
        const SizedBox(height: 8),
        const Text('Alerzano Sen',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18, color: _ink)),
        const Text('LEVEL 3 SECURE MEMBER',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _blue, fontWeight: FontWeight.w600, fontSize: 12)),
        _section('APPEARANCE'),
        _card(
            child: Column(children: [
          _SettingRow(
              Icons.dark_mode, 'Dark Theme', 'Reduce eye strain in low light',
              trailing: Switch(value: false, onChanged: (_) {})),
          const Divider(height: 1),
          _SettingRow(Icons.bolt, 'OLED Black Mode',
              'Pure black background for battery saving',
              trailing: Switch(value: false, onChanged: (_) {})),
          const Divider(height: 1),
          _SettingRow(Icons.text_fields, 'App Typography',
              'Inter, DM Sans, 12/16/24 scale',
              trailing:
                  const Icon(Icons.chevron_right, color: Color(0xFFB8BBC4)),
              onTap: () => _navigate(context, ScreenRoute.profile)),
        ])),
        _section('SYNC & BACKUP'),
        _card(
            child: const Column(children: [
          _PerkRow(Icons.cloud_sync, 'Secure Backup',
              'Secure cloud vault for financial logs'),
          Divider(height: 1),
          _PerkRow(Icons.sync, 'Cross-Device Sync',
              'Auto-sync with iPad & desktop nodes'),
        ])),
      ]);

  Widget _profileSignedIn(BuildContext context) => _scroll([
        _heading('Profile'),
        const SizedBox(height: 12),
        _card(
            child: const Column(children: [
          CircleAvatar(
              radius: 35,
              backgroundColor: _canvas,
              child: Icon(Icons.person, size: 36, color: _muted)),
          SizedBox(height: 8),
          Text('Alerzano Sen',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w700, color: _ink)),
          _SmallEyebrow('LEVEL 3 SECURE MEMBER'),
          Divider(height: 24),
          Row(children: [
            Expanded(
                child: Text('99.9%\nUptime Sync', textAlign: TextAlign.center)),
            Expanded(
                child: Text('1m ago\nLast Backup', textAlign: TextAlign.center))
          ]),
        ])),
        _section('ACTIVE ACCOUNT PERKS'),
        _card(
            padding: EdgeInsets.zero,
            child: const Column(children: [
              _PerkRow(Icons.cloud, 'Secure Cloud Syncing',
                  'Synchronized across 2 personal devices'),
              Divider(height: 1),
              _PerkRow(Icons.shield_outlined, 'Premium Milestone Vault',
                  'Maximum unlock lockouts activated'),
              Divider(height: 1),
              _PerkRow(Icons.sync, 'Automated Weekly Backups',
                  'Last backup succeeded today at 4:32 AM'),
            ])),
        const SizedBox(height: 14),
        _actionButton(context, 'Manage Security Keys', 'Manage security keys',
            ScreenRoute.profileSettings,
            filled: false),
        const SizedBox(height: 10),
        _actionButton(context, 'Sign Out of All Devices',
            'Sign out of all devices', ScreenRoute.profile,
            filled: false, replace: true, textColor: Colors.red),
      ]);

  Widget _providerSignIn(BuildContext context, {required bool apple}) => Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: _card(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                const Center(
                    child: SizedBox(width: 40, child: Divider(thickness: 4))),
                const SizedBox(height: 14),
                Text(apple ? 'Sign in with Apple ID' : 'Sign in with Google',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _ink)),
                const SizedBox(height: 8),
                Text(
                    apple
                        ? 'Use Apple ID to secure and synchronize your account to Freedom.'
                        : 'Select a Google account to continue to Freedom Wealth.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: _muted)),
                const SizedBox(height: 18),
                _card(
                  padding: const EdgeInsets.all(12),
                  color: _canvas,
                  child: Row(children: [
                    const CircleAvatar(
                        child: Text('AS', style: TextStyle(fontSize: 12))),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          const Text('Alerzano Sen',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, color: _ink)),
                          Text(
                              apple
                                  ? 'a.sen@icloud.com'
                                  : 'alerzano.sen@gmail.com',
                              style:
                                  const TextStyle(color: _muted, fontSize: 12))
                        ])),
                    const Icon(Icons.check_circle, color: _ink),
                  ]),
                ),
                const SizedBox(height: 20),
                _actionButton(
                    context,
                    apple
                        ? 'Continue'
                        : 'Continue with selected Google account',
                    apple
                        ? 'Continue with Apple ID'
                        : 'Continue with selected Google account',
                    ScreenRoute.profileSignedIn,
                    replace: true,
                    fill: Colors.black),
                if (!apple) ...[
                  const SizedBox(height: 10),
                  _actionButton(context, 'Use another account',
                      'Use another Google account', ScreenRoute.profileSignedIn,
                      replace: true, filled: false),
                ],
                const SizedBox(height: 10),
                _actionButton(
                    context,
                    'Cancel',
                    apple ? 'Cancel Apple sign-in' : 'Cancel',
                    ScreenRoute.profile,
                    replace: true,
                    filled: false),
              ])),
        ),
      );

  Widget _labelValueCard(String title, String subtitle, String value,
          {Color valueColor = _ink}) =>
      _card(
        child: Row(children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: _ink)),
                const SizedBox(height: 3),
                Text(subtitle,
                    style: const TextStyle(color: _muted, fontSize: 13)),
              ])),
          Flexible(
              child: Text(value,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: valueColor, fontWeight: FontWeight.w700))),
        ]),
      );

  Widget _smallMetric(String title, String subtitle, String value,
          IconData icon, Color color) =>
      _card(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: color, size: 21),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.w700, color: _ink)),
          const SizedBox(height: 3),
          Text(subtitle, style: const TextStyle(color: _muted, fontSize: 12)),
          const SizedBox(height: 10),
          Text(value,
              style: const TextStyle(
                  fontSize: 19, fontWeight: FontWeight.w700, color: _ink)),
          const SizedBox(height: 8),
          const _MiniBars(),
        ]),
      );

  Widget _ring(String text, double value,
          {Color color = _blue, double size = 96}) =>
      SizedBox(
        width: size,
        height: size,
        child: Stack(alignment: Alignment.center, children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: value,
              strokeWidth: size > 110 ? 11 : 7,
              backgroundColor: const Color(0xFFE7E8ED),
              color: color,
            ),
          ),
          Text(text,
              style: TextStyle(
                  fontSize: size > 110 ? 25 : 18,
                  fontWeight: FontWeight.w700,
                  color: _ink)),
        ]),
      );

  void _navigate(BuildContext context, ScreenRoute target,
      {bool replace = false}) {
    final navigator = Navigator.of(context);
    if (replace) {
      navigator.pushReplacementNamed(target.path);
    } else {
      navigator.pushNamed(target.path);
    }
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text,
      {this.color = const Color(0xFFF0F1F5),
      this.textColor = const Color(0xFF666B78)});
  final String text;
  final Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: Text(text,
            style: TextStyle(
                color: textColor, fontSize: 10, fontWeight: FontWeight.w700)),
      );
}

class _SmallEyebrow extends StatelessWidget {
  const _SmallEyebrow(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF747B8B),
          fontWeight: FontWeight.w700,
          letterSpacing: .35));
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF747B8B),
          fontWeight: FontWeight.w700,
          letterSpacing: .4));
}

class _NumberField extends StatelessWidget {
  const _NumberField({required this.value});
  final String value;
  @override
  Widget build(BuildContext context) => Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD0D2DA)),
            borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          const Text('₹', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(width: 12),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Color(0xFF171923))),
          const Spacer(),
          const Icon(Icons.circle, size: 17, color: Color(0xFF9799A1))
        ]),
      );
}

class _DataRow extends StatelessWidget {
  const _DataRow(this.label, this.value, this.note);
  final String label;
  final String value;
  final String note;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(children: [
          Expanded(
              child: Text(label,
                  style: const TextStyle(
                      color: Color(0xFF171923), fontWeight: FontWeight.w500))),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(value,
                style: const TextStyle(
                    color: Color(0xFF171923), fontWeight: FontWeight.w700)),
            Text(note,
                style: const TextStyle(color: Color(0xFF838895), fontSize: 12)),
          ]),
        ]),
      );
}

class _ProgressYear extends StatelessWidget {
  const _ProgressYear(this.year, this.percent, {this.last = false});
  final int year;
  final int percent;
  final bool last;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(children: [
          SizedBox(
              width: 44,
              child: Text('$year',
                  style: TextStyle(
                      fontWeight: last ? FontWeight.w700 : FontWeight.w500,
                      color: const Color(0xFF687184)))),
          Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                      value: percent / 100,
                      minHeight: 11,
                      color: last
                          ? const Color(0xFF21C45A)
                          : const Color(0xFF087EFF),
                      backgroundColor: const Color(0xFFF0F1F5)))),
          const SizedBox(width: 12),
          SizedBox(
              width: 40,
              child: Text('$percent%',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, color: Color(0xFF171923)))),
        ]),
      );
}

class _AmountBox extends StatelessWidget {
  const _AmountBox(
      {required this.title,
      required this.amount,
      this.color = const Color(0xFF171923)});
  final String title;
  final String amount;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: const Color(0xFFF8F9FC),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE1E3EA))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF777C89),
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(amount,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w700, color: color)),
        ]),
      );
}

class _PercentBox extends StatelessWidget {
  const _PercentBox(this.value, this.label);
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E2E9)),
            borderRadius: BorderRadius.circular(14)),
        child: Column(children: [
          Text(value,
              style: const TextStyle(
                  color: Color(0xFF087EFF),
                  fontSize: 21,
                  fontWeight: FontWeight.w700)),
          Text(label,
              style: const TextStyle(color: Color(0xFF747986), fontSize: 11))
        ]),
      );
}

class _BarChart extends StatelessWidget {
  const _BarChart();
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 62,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final height in const [28.0, 38.0, 45.0, 51.0, 56.0, 62.0])
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                          height: height,
                          decoration: BoxDecoration(
                              color: const Color(0xFF087EFF)
                                  .withValues(alpha: .25 + height / 100),
                              borderRadius: BorderRadius.circular(10)))))
          ],
        ),
      );
}

class _Callout extends StatelessWidget {
  const _Callout({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: const Color(0xFFEAF4FF),
            border: Border.all(color: const Color(0xFFB7D8FF)),
            borderRadius: BorderRadius.circular(14)),
        child: Text(text, style: const TextStyle(color: Color(0xFF171923))),
      );
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow(this.title, this.amount, this.icon, this.color,
      {required this.onTap});
  final String title;
  final String amount;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Semantics(
        excludeSemantics: true,
        button: true,
        label: 'View $title expense details',
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            child: Row(children: [
              CircleAvatar(
                  radius: 17,
                  backgroundColor: color.withValues(alpha: .12),
                  child: Icon(icon, size: 17, color: color)),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(title,
                      style: const TextStyle(color: Color(0xFF171923)))),
              Text(amount,
                  style: TextStyle(color: color, fontWeight: FontWeight.w700)),
              const Icon(Icons.chevron_right, color: Color(0xFFB0B3BD)),
            ]),
          ),
        ),
      );
}

class _AssetRow extends StatelessWidget {
  const _AssetRow(this.title, this.subtitle, this.amount, this.icon);
  final String title;
  final String subtitle;
  final String amount;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(children: [
          CircleAvatar(
              backgroundColor: const Color(0xFFEAF5EF),
              child: Icon(icon, color: const Color(0xFF18A85A), size: 20)),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: Color(0xFF171923))),
                Text(subtitle,
                    style:
                        const TextStyle(fontSize: 12, color: Color(0xFF747986)))
              ])),
          Text(amount,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, color: Color(0xFF171923))),
        ]),
      );
}

class _PerkRow extends StatelessWidget {
  const _PerkRow(this.icon, this.title, this.subtitle);
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(children: [
          CircleAvatar(
              radius: 17,
              backgroundColor: const Color(0xFFF0F1F5),
              child: Icon(icon, color: const Color(0xFF087EFF), size: 18)),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: Color(0xFF171923))),
                Text(subtitle,
                    style:
                        const TextStyle(color: Color(0xFF747986), fontSize: 12))
              ])),
        ]),
      );
}

class _SettingRow extends StatelessWidget {
  const _SettingRow(this.icon, this.title, this.subtitle,
      {required this.trailing, this.onTap});
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(children: [
            CircleAvatar(
                radius: 17,
                backgroundColor: const Color(0xFFF0F1F5),
                child: Icon(icon, size: 18, color: const Color(0xFF087EFF))),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF171923))),
                  Text(subtitle,
                      style: const TextStyle(
                          color: Color(0xFF858A96), fontSize: 12))
                ])),
            trailing,
          ]),
        ),
      );
}

class _MiniBars extends StatelessWidget {
  const _MiniBars();
  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final height in const [12.0, 17.0, 23.0, 29.0, 35.0])
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                        height: height,
                        decoration: BoxDecoration(
                            color: const Color(0xFFDDEBFF),
                            borderRadius: BorderRadius.circular(4)))))
        ],
      );
}

class _TrendChart extends StatelessWidget {
  const _TrendChart();
  @override
  Widget build(BuildContext context) =>
      CustomPaint(painter: _TrendPainter(), child: const SizedBox.expand());
}

class _TrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * .8)
      ..lineTo(size.width * .2, size.height * .63)
      ..lineTo(size.width * .4, size.height * .72)
      ..lineTo(size.width * .6, size.height * .32)
      ..lineTo(size.width * .8, size.height * .28)
      ..lineTo(size.width, size.height * .05);
    canvas.drawPath(
        path,
        Paint()
          ..color = const Color(0xFF087EFF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
