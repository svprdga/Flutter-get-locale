import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_get_locale/currency.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter get locale'),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 20.0,
              right: 16.0,
            ),
            child: Text(
              'In order to try this sample, try to change the language of '
              'your device and see the results.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 20.0,
              right: 16.0,
            ),
            child:
                const Text('Get locale with Localizations.localeOf(context):'),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 16.0,
              right: 16.0,
            ),
            child: FutureBuilder<LocaleDetails>(
              future: _getCurrencyLocalizations(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final localeDetails = snapshot.data as LocaleDetails;

                  return Center(
                    child: Text(
                        'Lang: ${localeDetails.language}, country: ${localeDetails.country}, currency: ${localeDetails.currency}'),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 20.0,
              right: 16.0,
            ),
            child: const Text('Get locale with Devicelocale.currentLocale:'),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 16.0,
              right: 16.0,
            ),
            child: FutureBuilder<LocaleDetails>(
              future: _getCurrencyDeviceLocale(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final localeDetails = snapshot.data as LocaleDetails;

                  return Center(
                    child: Text(
                        'Lang: ${localeDetails.language}, country: ${localeDetails.country}, currency: ${localeDetails.currency}'),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<LocaleDetails> _getCurrencyLocalizations(BuildContext context) async {
    final locale = Localizations.localeOf(context);
    final language = locale.languageCode;
    final country = locale.countryCode;
    final format = NumberFormat.simpleCurrency(locale: locale.toString());
    return LocaleDetails(
      language: language,
      country: country ?? '',
      currency: format.currencyName ?? '',
    );
  }

  Future<LocaleDetails> _getCurrencyDeviceLocale() async {
    final locale = await Devicelocale.currentLocale;

    String language = '';
    String country = '';

    if (locale != null && locale.length >= 2) {
      try {
        language = locale.substring(0, 2);
      } catch (e) {
        debugPrint('Error when fetching user language: $e');
      }
    }

    if (locale != null && locale.length >= 5) {
      try {
        country = locale.substring(3, 5);
      } catch (e) {
        debugPrint('Error when fetching user country: $e');
      }
    }

    final format = NumberFormat.simpleCurrency(locale: locale.toString());
    return LocaleDetails(
      language: language,
      country: country,
      currency: format.currencyName ?? '',
    );
  }
}
