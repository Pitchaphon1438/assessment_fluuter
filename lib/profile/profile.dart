import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/profile/edit_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void initState() {
    super.initState();
    getDataProfile();
  }
  List<dynamic> dataMyProfile = [];
  bool isLoading = false;

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: isLoading?
          SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200]),
                          width: MediaQuery.of(context).size.width / 2,
                          height: 35,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(dataMyProfile[0]['Fname']),
                          ),
                        ),
                        Container(
                          child: const Text(
                            "My address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200]),
                          width: MediaQuery.of(context).size.width / 2,
                          height: 35,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(dataMyProfile[0]['Phone']),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200]),
                          width: MediaQuery.of(context).size.width / 2,
                          height: 75,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(dataMyProfile[0]['Address']),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Icon(
                            Icons.account_circle_outlined,
                            size: 90,
                            color: Colors.grey[600],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EditProfile()));
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            fixedSize: Size(90, 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),

                  )
                ],
              ),
            ],
          ),
        ),
      ):const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
