import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  Future<void> getRate() async {
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
      log(response.body);
    } catch (error) {
      log("$error", error: error);
    }
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
            const Text("You send exactly"),
            const SizedBox(height: 4),
            const TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.network(
                  "https://wise.com/web-art/assets/flags/aud.svg",
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  "AUD",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 8),
                const Icon(Icons.currency_exchange)
              ],
            ),
            Text(
              "Title data ชื่อเรื่อง",
              style: Theme.of(context).textTheme.titleMedium,
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
