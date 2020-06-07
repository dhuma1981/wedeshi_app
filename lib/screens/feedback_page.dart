import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:wedeshi/common/custom_appbar.dart';
import 'package:wedeshi/utils/api_provider.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _feedback = TextEditingController();
  bool _nameError = false;
  bool _numberError = false;
  bool _feedbackError = false;
  bool isLoaing = false;

  Future<void> submitFeedback() async {
    if (_name.text.isEmpty) {
      _nameError = true;
    } else {
      _nameError = false;
    }

    if (_number.text.isEmpty || _number.text.length != 10) {
      _numberError = true;
    } else {
      _numberError = false;
    }
    if (_feedback.text.isEmpty) {
      _feedbackError = true;
    } else {
      _feedbackError = false;
    }
    if (!_nameError && !_numberError && !_feedbackError) {
      setState(() {
        isLoaing = true;
      });
      FocusScope.of(context).unfocus();
      String message = await ApiProvider.submitFeedback(
          name: _name.text, number: _number.text, feedback: _feedback.text);
      setState(() {
        isLoaing = false;
      });
      Flushbar(
        message: message,
        duration: Duration(seconds: 3),
      )..show(context);
      _name.clear();
      _number.clear();
      _feedback.clear();
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.getCustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Submit your feedback",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _name,
              decoration: InputDecoration(
                labelText: "Your name",
                hintText: "Enter your name",
                errorText: _nameError ? "Please entter name" : null,
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _number,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                labelText: "Mobile Number",
                hintText: "Enter your mobile number",
                errorText:
                    _numberError ? "Please entter valid mobile number" : null,
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _feedback,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Feedback",
                hintText: "Enter your feedback",
                errorText:
                    _feedbackError ? "Please entter mobile number" : null,
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                color: Colors.red,
                child: Text(
                  "SUBMIT",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: !isLoaing ? submitFeedback : null)
          ],
        ),
      ),
    );
  }
}
