import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  void initState() {
    super.initState();
    getDataProfile();
  }

  late TextEditingController editFname = TextEditingController.fromValue(
      TextEditingValue(text: dataMyProfile[0]['Fname']));

  late TextEditingController editEmail = TextEditingController.fromValue(
      TextEditingValue(text: dataMyProfile[0]['Email']));

  late TextEditingController editPhone = TextEditingController.fromValue(
      TextEditingValue(text: dataMyProfile[0]['Phone']));

  late TextEditingController editAddress = TextEditingController.fromValue(
      TextEditingValue(text: dataMyProfile[0]['Address']));

  late TextEditingController editProvince = TextEditingController.fromValue(
      TextEditingValue(text: dataMyProfile[0]['Province']));

  late TextEditingController editPostalCode = TextEditingController.fromValue(
      TextEditingValue(text: dataMyProfile[0]['PostalCode']));

  late TextEditingController editCountry = TextEditingController.fromValue(
      TextEditingValue(text: dataMyProfile[0]['Country']));
  String email = "hello";
  List<dynamic> dataMyProfile = [];
  bool isLoading = false;

  late List<String> list = <String>[
    'เชียงใหม่',
    'ลำปาง',
    'กรุงเทพ',
    'พิษณุโลก'
  ];
  late String dropdownValue;

  Future<dynamic> getDataProfile() async {
    try {
      const id = '7';
      const url = 'http://10.0.2.2:8080/user/$id';
      const headers = {
        "Content-Type": "application/json;charset=UTF-8",
        "Charset": "utf-8"
      };
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        // print(response.body);
        Map<String, dynamic> responseResult =
            jsonDecode(utf8.decode(response.bodyBytes));
        var data = responseResult['data'];
        setState(() {
          dataMyProfile.add(data);
        });
        isLoading = true;
      }
      print("dataMyProfile");
      print(dataMyProfile);
    } catch (e) {
      print('$e');
    }
    return dataMyProfile;
  }

  updateProfile() async {
    try {
      dynamic body = {
        "Username": "gaylausername07",
        "Fname": "${editFname.text.toString()}",
        "Email": "${editEmail.text.toString()}",
        "Address": "${editAddress.text.toString()}",
        "Province": dropdownValue,
        "PostalCode": "${editPostalCode.text.toString()}",
        "Country": "${editCountry.text.toString()}",
        "Phone": "${editPhone.text.toString()}"
      };

      const id = '7';
      const url = 'http://10.0.2.2:8080/user/$id';
      const headers = {
        "Content-Type": "application/json;charset=UTF-8",
        "Charset": "utf-8"
      };
      await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
    } catch (e) {
      print('$e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
              color: Colors.black, onPressed: () => Navigator.pop(context)),
        ),
        body: isLoading
            ? SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: const Text(
                          "Contact information",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "Email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      inputCustom(dataMyProfile[0]['Email'], editEmail),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "Delivery addresss",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: const Text(
                          "Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      inputCustom(dataMyProfile[0]['Fname'], editFname),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: const Text(
                          "Phone no",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      inputCustom(dataMyProfile[0]['Phone'], editPhone),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: const Text(
                          "Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      inputCustom(dataMyProfile[0]['Address'], editAddress),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: const Text(
                                  "Province",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              dropdownProvince(),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: const Text(
                                  "Postal Code",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[200]),
                                width: MediaQuery.of(context).size.width /2.2,
                                height: 35,
                                child: Container(
                                   margin: EdgeInsets.only(left: 20,top: 20,bottom: 5),
                                  child: TextFormField(
                                      controller: editPostalCode,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: dataMyProfile[0]['PostalCode'],
                                      )),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: const Text(
                          "Country",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      inputCustom(dataMyProfile[0]['Country'], editCountry),
                      ElevatedButton(
                        onPressed: () async {
                          await updateProfile();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      super.widget));
                        },
                        child: Text("save",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlue.shade800),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget inputCustom(String hintText, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
      width: MediaQuery.of(context).size.width / 0.6,
      height: 35,
      child: Container(
        margin: EdgeInsets.only(left: 20,top: 20,bottom: 5),
        child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
            )),
      ),
    );
  }

  Widget dropdownProvince() {
    return DropdownMenu<String>(
      initialSelection: dataMyProfile[0]['Province'],
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
