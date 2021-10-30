import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/service/login_controller.dart';
import 'package:flutter_ecommerce_laravel/utils/color.dart';
import 'package:flutter_ecommerce_laravel/utils/text_style.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.emailTo, required this.nameTo})
      : super(key: key);

  final String emailTo, nameTo;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final storeMessage = FirebaseFirestore.instance;
  TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: black,
        appBar: AppBar(
          title: Text(widget.nameTo),
          backgroundColor: black,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // display chat
              ShowMessage(
                emailTo: widget.emailTo,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: "Enter Message"),
                            controller: msgController,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (msgController.text.isNotEmpty) {
                          storeMessage.collection("Messages").doc().set({
                            "message": msgController.text.trim(),
                            "user": Provider.of<LoginController>(context,
                                    listen: false)
                                .userDetails!
                                .email!,
                            "time": DateTime.now(),
                            'to': widget.emailTo,
                          }).then((value) => msgController.clear());
                        }
                      },
                      icon: Icon(Icons.send, color: white)),
                ],
              )
            ],
          ),
        ));
  }
}

class ShowMessage extends StatelessWidget {
  const ShowMessage({Key? key, required this.emailTo}) : super(key: key);

  final String emailTo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: (MediaQuery.of(context).size.height / 2) - 64,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Messages")
              .orderBy("time")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Container(
                width: MediaQuery.of(context).size.width - 20,
                height: (MediaQuery.of(context).size.height / 2) - 64,
                child: ListView.builder(
                    shrinkWrap: true,
                    primary: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, i) {
                      QueryDocumentSnapshot x = snapshot.data!.docs[i];

                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: 10.0,
                            right: Provider.of<LoginController>(context,
                                            listen: false)
                                        .userDetails!
                                        .email! !=
                                    x['user']
                                ? 100
                                : 0,
                            left: Provider.of<LoginController>(context,
                                            listen: false)
                                        .userDetails!
                                        .email! ==
                                    x['user']
                                ? 100
                                : 0),
                        child: Column(
                          crossAxisAlignment: (Provider.of<LoginController>(
                                          context,
                                          listen: false)
                                      .userDetails!
                                      .email! ==
                                  x['user']
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start),
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: ListTile(
                                title: AutoSizeText(
                                  x['message'],
                                  style: headingStyle2.copyWith(color: black),
                                ),
                                subtitle: AutoSizeText(
                                  x['user'],
                                  style: subTitleTextStyle.copyWith(
                                      color: grey, fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            } else {
              return SizedBox(
                height: 0,
              );
            }
          },
        ),
      ),
    );
  }
}
