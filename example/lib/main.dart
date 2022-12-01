import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var darkTheme = ThemeData.dark().copyWith(primaryColor: Colors.blue);

    return MaterialApp(
      title: 'Demo',
      themeMode: ThemeMode.light,
      darkTheme: darkTheme,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(title: Text('Demo')),
          body: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
              },
              onInputValidated: (bool value) {
                print(value);
              },
              searchBoxDecoration: InputDecoration(border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: BorderSide(color: Color(0xFFCCCCDA)),
              ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                hintText: '국가를 검색해보세요',
                suffixIcon: Icon(Icons.search)
              ),
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                useEmoji: true,
                emojiStyle: TextStyle(fontSize: 17),
                selectorTitleText: '국가를 선택해주세요',
                selectorTitleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1D1928))
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.always,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: controller,
              formatInput: true,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: OutlineInputBorder(),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
            ),
            ElevatedButton(
              onPressed: () {
                formKey.currentState?.validate();
              },
              child: Text('Validate'),
            ),
            ElevatedButton(
              onPressed: () {
                getPhoneNumber('+15417543010');
              },
              child: Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                formKey.currentState?.save();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
