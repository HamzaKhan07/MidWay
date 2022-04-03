import 'package:flutter/material.dart';
import 'select_location.dart';

class SelectName extends StatefulWidget {
  _SelectNameState createState() => _SelectNameState();
}

class _SelectNameState extends State<SelectName> {
  TextEditingController myController = TextEditingController();
  bool isDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Enter Person Name',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: myController,
                onChanged: (newString) {
                  if (myController.text.length > 0) {
                    setState(() {
                      isDisabled = false;
                    });
                  } else {
                    setState(() {
                      isDisabled = true;
                    });
                  }
                },
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  hintText: 'John',
                  hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 18.0),
                  prefixIcon: Icon(
                    Icons.details,
                    color: Colors.black,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              FlatButton(
                padding: EdgeInsets.all(6.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Colors.black,
                onPressed: isDisabled == true
                    ? null
                    : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectLocation(
                              name: myController.text.toString().trim(),
                            ),
                          ),
                        ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
