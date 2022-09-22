import 'package:flutter/material.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/data/model/response_model/history_response_model.dart';

class CheckInCard extends StatelessWidget {

  final CheckIn result;

  CheckInCard({
    required this.result
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: 100,
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: result.late! == "False" 
        ? ColorPalette.blueColor 
        : result.late! == "Tolerance" 
          ? ColorPalette.yellowColor 
        : ColorPalette.redColor
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: ClipOval(
                child: Image.network(
                  "${result.link}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              )
            )
          ),
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Positioned(
                  top: 35,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        result.late! == "False" 
                        ? "Tepat Waktu" 
                        : result.late! == "Tolerance" 
                          ? "Tolerance" 
                        : "Terlambat",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        result.createdAt.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}