import 'package:agriconnect/apihandler/apihandler.dart';
import 'package:agriconnect/models/models.dart';
import 'package:agriconnect/uicomponents/uicomponents.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class ProdServPage extends StatefulWidget {
  const ProdServPage({super.key});

  @override
  State<ProdServPage> createState() => _ProdServPageState();
}

class _ProdServPageState extends State<ProdServPage> {
  double padding = 30;
  
  @override 
  Widget build(BuildContext context) 
  {
    var args = ModalRoute.of(context)!.settings.arguments as List;
    String prodservtype = args[0];
    late Future<List<ProdServViewDetails>> Function() getDetails;
    String title = "";
    switch (prodservtype){
      case "crop":
        getDetails = getCropsViewDetails;
        title = "Crops for Sale";
      case "transport":
        getDetails = getTransportsViewDetails;
        title = "Transport Services";
      case "storage":
        getDetails = getStoragesViewDetails;
        title = "Storage Services";
      case "land":
        getDetails = getLandsViewDetails;
        title = "Land for lease / sale";
    }
    print(prodservtype);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Expanded(
              child: ProdServView(getDetails: getDetails,),
            )
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCropsViewDetails();
          getLandsViewDetails();
          getStoragesViewDetails();
          getTransportsViewDetails();
        },
        child: Icon(Icons.mic),
      ),
    );
  }
}
