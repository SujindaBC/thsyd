import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class WiseWidget extends StatefulWidget {
  const WiseWidget({super.key});

  @override
  State<WiseWidget> createState() => _WiseWidgetState();
}

class _WiseWidgetState extends State<WiseWidget> {
  final Uri _wiseUrl = Uri.parse("https://wise.com/invite/dic/sujindab");
  final Uri _wiseApi =
      Uri.parse("https://api.wise.com/v1/rates?source=AUD&target=THB");

  Future<void> _launchUrl() async {
    if (!await launchUrl(_wiseUrl)) {
      throw Exception("Couldn't launch $_wiseUrl");
    }
  }

  Future<void> getWiseRate() async {
    final wiseKey = dotenv.get("WISE_KEY");
    try {
      final response = await http.get(
        _wiseApi,
        headers: {
          "Authorization": "Bearer $wiseKey",
          "Host": _wiseApi.host,
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        if (responseData.isNotEmpty) {
          final String rate = responseData[0]["rate"].toString();
          final String source = responseData[0]["source"].toString();
          final String target = responseData[0]["target"].toString();
          final String apiDateTimeString = responseData[0]["time"].toString();
          final DateTime apiDateTime = DateTime.parse(apiDateTimeString);
          final String formattedDateTime =
              DateFormat('yyyy-MM-dd HH:mm:ss').format(apiDateTime);
          log("Exchange rate: 1 $source/$rate $target, Time: $formattedDateTime");
        }
      }
    } catch (error) {
      log("$error", error: error);
    }
  }

  Future<String> getRate() async {
    final wiseKey = dotenv.get("WISE_KEY");
    try {
      final response = await http.get(
        _wiseApi,
        headers: {
          "Authorization": "Bearer $wiseKey",
          "Host": _wiseApi.host,
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        if (responseData.isNotEmpty) {
          return responseData[0]["rate"].toString();
        }
      }
    } catch (error) {
      log("$error", error: error);
    }
    return "Error"; // Return an error message or handle it accordingly
  }

  @override
  Widget build(BuildContext context) {
    getRate();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Today rate"),
                const Spacer(),
                SvgPicture.network(
                  "https://wise.com/web-art/assets/flags/aud.svg",
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.currency_exchange,
                  size: 16,
                ),
                const SizedBox(width: 4),
                SvgPicture.network(
                  "https://wise.com/web-art/assets/flags/thb.svg",
                  width: 24,
                  height: 24,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "1 AUD = ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                FutureBuilder(
                  initialData: 0.00,
                  builder: (context, snapshot) {
                    return Text(
                      "${snapshot.data} THB",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    );
                  },
                  future: getRate(),
                ),
              ],
            ),
            Center(
              child: FilledButton(
                onPressed: _launchUrl,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0XFF9FE870),
                  ),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Send money via Wise",
                      style: TextStyle(
                        color: Color.fromARGB(1255, 22, 51, 0),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
