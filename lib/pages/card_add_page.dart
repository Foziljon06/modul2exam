import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../madels/credit_card_model.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiredDateController = TextEditingController();

  String changeNumber = " ";
  String changeDate = " ";

  var cardNumberMaskFormatter = new MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
  var validateMaskFormatter = new MaskTextInputFormatter(
      mask: '##/##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  void saveCreditCard() {
    setState(() {
      String cardNumber = cardNumberController.text;
      String expiredDate = expiredDateController.text;
      CreditCard creditCard = CreditCard(cardNumber: cardNumber, expiredDate: expiredDate);
      if (cardNumber.startsWith("4")) {
        creditCard.cardImage = "assets/images/ic_card_visa.png";
        creditCard.cardType = "visa";
      } else if (cardNumber.startsWith("5")) {
        creditCard.cardImage = "assets/images/ic_card_master.png";
        creditCard.cardType = "master";
      } else {
        showToast("Enter onl master and visa cards");
        return;
      }
      backToFinish(creditCard);
    });
  }

  void backToFinish(CreditCard creditCard) {
    Navigator.of(context).pop(creditCard);
  }

  void showToast(String massage) {
    Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Add Card"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1005 / 555,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/im_card_bg.png"),
                              fit: BoxFit.cover)),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "VISA",
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 20
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    changeNumber,
                                    style: TextStyle(color: Colors.white,fontSize: 25),
                                  ),

                                  Text(
                                    changeDate,
                                    style: TextStyle(color: Colors.white,fontSize: 20),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    height: 45,
                    margin: EdgeInsets.only(top: 5),
                    child: TextField(
                      controller: cardNumberController,
                      decoration: InputDecoration(hintText: "Card Number"),
                      onChanged: (value){
                        setState(() {
                          changeNumber=value;
                        });
                      },
                      inputFormatters: [cardNumberMaskFormatter],
                    ),
                  ),

                  Container(
                    height: 45,
                    margin: EdgeInsets.only(top: 5),
                    child: TextField(
                      controller: expiredDateController,
                      decoration: InputDecoration(hintText: "expired Date"),
                      onChanged: (value){
                        setState(() {
                          changeDate=value;
                        });
                      },
                      inputFormatters: [validateMaskFormatter],
                    ),
                  ),
                ],
              ),
            ),


            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue.shade900,
              ),
              child: MaterialButton(
                onPressed: () {
                  saveCreditCard();
                },
                child: Text(
                  "Add Card",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
