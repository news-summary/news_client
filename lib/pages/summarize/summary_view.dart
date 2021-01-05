import 'dart:io';

import 'package:NewsSummary/pages/summarize/summary_cube.dart';
import 'package:NewsSummary/repository/summary_repository/model/summary.dart';
import 'package:NewsSummary/widgets/error_connection.dart';
import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class SummaryView extends CubeWidget<SummaryCube> {
  final String sourceUrl;

  SummaryView(this.sourceUrl);

  @override
  get initData => sourceUrl;

  @override
  Widget buildView(BuildContext context, SummaryCube cube) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sourceUrl),
      ),
      body: Stack(
        children: <Widget>[
          _getProgress(cube),
          _getEmpty(cube),
          _buildConnectionError(cube),
          _getSummaryViewWidget(cube, context),
        ],
      ),
    );
  }

  Widget _getSummaryViewWidget(SummaryCube cube, BuildContext context) {
    return cube.summary.build<Summary>((value) {
      return MaterialApp(
        title: 'Summary',
        home: Scaffold(
          body: ListView(
            children: [
              _buildReadingTimeRow("${value.summaryReadingTime}", "${value.finalReadingTime}"),
              _buildSummaryRow(value.finalSummary),
              _getAntLink(),
              _getLink(sourceUrl, context),
            ],
          ),
        ),
      );
    });
  }

  Widget _getProgress(SummaryCube cube) {
    return cube.progress.build<bool>(
      (value) {
        return value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox.shrink();
      },
      animate: true,
    );
  }

  Widget _getEmpty(SummaryCube cube) {
    return cube.empty.build<bool>((value) {
      return value
          ? Center(
              child: Text(Cubes.getString("error_search")),
            )
          : SizedBox.shrink();
    });
  }

  Widget _buildConnectionError(SummaryCube cube) {
    return cube.error.build((value) {
      return value
          ? ErrorConnection(tryAgain: () {
              cube.summarize(sourceUrl);
            })
          : SizedBox.shrink();
    });
  }

  Widget _buildSummaryRow(String summary) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        summary,
        softWrap: true,
        textScaleFactor: 1.25,
      ),
    );
  }

  Widget _buildReadingTimeRow(String summaryReadingTime, String finalReadingTime) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildReadingTimeColumn("Summary Reading Time", summaryReadingTime),
          _buildReadingTimeColumn("Article Reading Time", finalReadingTime),
        ],
      ),
    );
  }

  Widget _buildReadingTimeColumn(String title, String timeInString) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            timeInString,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Colors.indigo,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getAntLink() {
    return new Container(
      margin: new EdgeInsets.only(top: 30.0),
      child: new Text(
        "Read full article:",
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
            fontSize: 18),
      ),
    );
  }

  Widget _getLink(link, context) {
    return new GestureDetector(
      child: new Text(
        link,
        style: new TextStyle(color: Colors.blue, fontSize: 16),
      ),
      onTap: () {
        _launchURL(link, context);
      },
    );
  }

  _launchURL(url, context) async {
    if (Platform.isAndroid) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not launch $url');
      }
    } else {
      Clipboard.setData(new ClipboardData(text: url));
      _showDialog(context);
    }
  }

  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(Cubes.getString("text_copy")),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(Cubes.getString("text_close")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
