import 'package:agriconnect/models/models.dart';
import 'package:flutter/material.dart';

class BigNavButton extends StatelessWidget {
  Color color;
  String name;
  void Function()? onPressed;
  BigNavButton({super.key, this.name="", this.color=Colors.yellow, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(name, style: const TextStyle(fontSize: 20),),
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward,)
            )
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}



class MessageItem extends StatelessWidget {
  final Message message; 
  const MessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    switch (message.from) {
      case "Server": 
        return Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message.content,
                style: const TextStyle(
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        );
      default:
        return Align(
          alignment: message.from=="You"?Alignment.centerRight:Alignment.centerLeft,
          child: Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 300),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: message.from=="You"?const Color(0x2598ff99):const Color(0x10ffffff), //Colors.black12
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color:Colors.lightGreen, width: 0.5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.from!="You") ...[
                  Text(message.from, style: const TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold),),
                ],
                Text(message.content)
              ],
            ),
          ),
        );
      // switch end
    }
  }
}


class MessageField extends StatefulWidget {
  final Function(String value) onSend;
  Widget? fieldprefixwidget;
  MessageField({super.key, required this.onSend, this.fieldprefixwidget});

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  final TextEditingController messagecontroller = TextEditingController();
  final FocusNode messagefocusnode = FocusNode();
  bool aggressiveHint = false;
  void onSend(String value) {
    if (value.trim()=="") {
      setState(() {
        aggressiveHint = true;
        messagecontroller.clear();
      });
      messagefocusnode.requestFocus();
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
        aggressiveHint = false;
      });
      },);
    }
    else {
      aggressiveHint = false;
      widget.onSend(value);
      messagecontroller.clear();
      messagefocusnode.requestFocus();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: aggressiveHint?Colors.red: Colors.lightGreen, width: 0.5)
      ),
      child: Row(
        children: [
          if (widget.fieldprefixwidget != null) widget.fieldprefixwidget!,
          Expanded(
            child: TextField(
              controller: messagecontroller,
              decoration: InputDecoration(
                hintText: "Enter your Message", 
                hintStyle: aggressiveHint? const TextStyle(color: Colors.red) : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(left: 10)
              ),
              autofocus: true,
              focusNode: messagefocusnode,
              onSubmitted: (value) {
                onSend(value);
              },
            )
          ),
          IconButton(
            padding: const EdgeInsets.only(right: 5),
            onPressed: (){
              onSend(messagecontroller.text);
            }, icon: const Icon(Icons.send_sharp, color: Colors.lightGreen,), splashRadius: 20,
          ),
        ],
      ),
    );
  }
}


class ProdServView extends StatefulWidget {
  final Future<List<ProdServViewDetails>> Function() getDetails;
  const ProdServView({super.key, required this.getDetails, });

  @override
  State<ProdServView> createState() => _ProdServViewState();
}

class _ProdServViewState extends State<ProdServView> {
  List<ProdServViewDetails> psv = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.getDetails(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
              // while data is loading:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
        else {
          return RefreshIndicator(
            child: ListView(
              children: snapshot.data!.map((e) => ProdServCard(prodServViewDetails: e)).toList(),
            ), 
            onRefresh: ( ) async {
              setState(() {
                
              });
            }
          );
        }
      },
      
    );
  }
}


class ProdServCard extends StatelessWidget {
  final ProdServViewDetails prodServViewDetails;
  const ProdServCard({super.key, required this.prodServViewDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(color: Colors.lightGreen),
        borderRadius: BorderRadius.circular(14)
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(prodServViewDetails.headline, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Text(prodServViewDetails.description),
          Text("City:"+prodServViewDetails.city),
          const SizedBox(height:20),
          Row(
            children: [
              Text("Posted By: "+prodServViewDetails.postedby)
            ],
          ) 
        ],
      ),
    );
  }
}