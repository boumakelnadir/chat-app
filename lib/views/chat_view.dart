import 'dart:developer';

import 'package:chatapp1/helper/constans.dart';
import 'package:chatapp1/models/message_model.dart';
import 'package:chatapp1/widgets/chat_view_file/chat_bubles.dart';
import 'package:chatapp1/widgets/chat_view_file/custom_text_field_normal.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatelessWidget {
  ChatView({
    super.key,
    this.email,
  });
  final TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();
  final String? email;

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kCollectionMessages);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messagesList = [];
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: kPrimeryColor,
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogoSignIn,
                      height: 35,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Scholar chat',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: 'SingleDay',
                      ),
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: scrollController,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].email == email
                              ? ChatBubles(
                                  message: messagesList[index],
                                )
                              : ChatBublesForFriend(
                                  message: messagesList[index],
                                );
                        }),
                  ),
                  CustomTextFieldNormal(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        kEmail: email,
                      });
                      controller.clear();
                      scrollController.animateTo(
                        0,
                        curve: Curves.easeOut,
                        duration: const Duration(microseconds: 500),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Loading......'),
              ),
            );
          }
        });
  }
}
