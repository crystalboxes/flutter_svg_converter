import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../flutter_svg.dart';
import 'get_tiger.dart';

class Ui2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Retrieve Text Input'),
        ),
        body: MyApp3(),
      ),
    );
  }
}

class MyApp3 extends StatefulWidget {
  const MyApp3({
    Key key,
  }) : super(key: key);

  @override
  _MyApp3State createState() => _MyApp3State();
}

class _MyApp3State extends State<MyApp3> {
  String svgSource;
  CustomPicture resultPicture;
  String resultSource;

  @override
  void initState() {
    svgSource = getTiger();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: ButtonRow(
              onConvert: svgSource != null && svgSource.isNotEmpty
                  ? () {
                      // conversion logic
                    }
                  : null,
              onFormat: resultSource != null && resultSource.isNotEmpty
                  ? () {
                      ////
                    }
                  : null,
              onCopyToClipboard: resultSource != null && resultSource.isNotEmpty
                  ? () {
                      ////
                    }
                  : null,
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 500,
                    child: TextFormField(
                      initialValue: getTiger(),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                      onChanged: (text) {
                        setState(() {
                          svgSource = text;
                          resultPicture = null;
                          resultSource = null;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    height: 500,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

typedef void ButtonRowCallback();

class ButtonRow extends StatelessWidget {
  final ButtonRowCallback onConvert;
  final ButtonRowCallback onFormat;
  final ButtonRowCallback onCopyToClipboard;

  const ButtonRow({this.onConvert, this.onFormat, this.onCopyToClipboard});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FlatButton(
          onPressed: onConvert,
          child: Text('Convert'),
        ),
        FlatButton(
          onPressed: onFormat,
          child: Text('Format'),
        ),
        FlatButton(
          onPressed: onCopyToClipboard,
          child: Text('Copy to Clipboard'),
        )
      ],
    );
  }
}
