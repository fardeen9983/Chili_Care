import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatusPage extends StatefulWidget {
  final File file;
  final int state;
  final String text;

  const StatusPage({Key key, this.file, this.state, this.text})
      : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  String url;
  DocumentReference constant;
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          url = data["FileUrl"] + widget.text;
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: NetworkImage(url),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: fetchStatus(widget.state),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
      stream: Firestore.instance.document("user/Constants").snapshots(),
    );
  }

  @override
  void initState() {
    super.initState();
    constant = Firestore.instance.document("user/Constants");
  }

  Text fetchStatus(int state) {
    String res = "";
    switch (state) {
      case 1:
        res =
            "Bacterial Leaf Spot\nOne spray of Streptocycline @ 150 ppm alternated with Kasugamycin @ 0.2%. •\tSeed dipping in Streptocycline solution @ 100 ppm for 30 minutes.";
        break;
      case 2:
        res =
            "White Rot\nCut the infected plant parts along with some healthy portion in morning and carefully collect in polythene to avoid falling of sclerotia in the field. Burn all these materials away from field. \\n •\tFoliar spray of Carbendazim @ 0.1% at flowering stage followed by Mancozeb @ 0.25%.";
        break;
      case 3:
        res =
            "Leaf Curl Complex (CMV and Gemini Virus)\nRoot dipping of the seedlings in Imidacloprid solution @ 4-5 ml per litre of water for one hour during transplanting. •\tNursery should be grown in nylon net to check the vector infestation. •\tSeed treatment with hot water at 50° C or 10% tri sodium phosphate solution for 25 minutes. •\tBarrier crop of taller non-host crops like maize, bajra and sorghum. •\tCollect healthy seeds from disease-free plants •\tPeriodical alternate spray of Dicofal @ 0.25% with wettable sulpher @ 0.2% and one to two spray of systemic insecticide •\tUse tolerant varieties •\tInitial rouging of infected plants soon after infection and burn it.";
        break;
      case 4:
        res =
            "Phytophthora Leaf blight(Fruit Rot)\nAlways use healthy and certifi ed seeds collected from disease-free area. •\tInfected crop debris and fruits must be collected from the fi eld and burnt. •\tPreventive sprays of Mancozeb@ 0.25% provide good control in cloudy, cold and drizzling weather. •\tOne spray of Metalaxyl+ Mancozeb @ 0.2% is very eff ective when applied within two days of infection but repetitive sprays should not be given. •\tStaking of plant reduces the disease infection.. •\tRotation, water management and drainage are the cultural methods. •\tAvoid over cropping and high nitrogen.";
        break;
      case 5:
        res =
            "Dieback and Anthracnose (Choanephora capsici, Colletotrichum capsici)\nDisease free seeds should be collected from healthy fruits. •\tScreening of diseased fruits must be done after drying of the fruits. •\tSeeds should be treated with Carbendazim @ 0.25% during sowing •\tSeedling should be sprayed by Carbendazim @ 0.1% before transplanting •\tCut the rotting twigs along with healthy part and burn it. •\tFoliar spray of Copper Oxychloride @ 0.3% followed by Carbendazim @ 0.1% at flowering stage •\tAvoid apical injury during transplanting and also at flowering stage •\tCollect all the green fruits of fi rst setting and consume it. Do not keep these fruits for seed purpose";
        break;
      default:
        res =
            "Plant is Healthy \nWonderfull <b>NO disease </b> has been detected<br> <ul><li>continue to provide adequate water and humidity</li> <li>use sensors to check if plant is getting adequate water and temprature.</li></ul>";
        break;
    }
    return Text(
      "State : " + res,
      style: TextStyle(fontSize: 32.0),
      textAlign: TextAlign.center,
    );
  }
}
