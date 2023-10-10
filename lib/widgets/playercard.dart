import 'package:flutter/material.dart';

class getPlayerTurnCard extends StatefulWidget {
  final String playerImage;
  final String scoretxt;
  final String role;
  final Color borderColor;
  final List<Color> backGroundColor;
  final double width;
  final double height;

  const getPlayerTurnCard({ 
    required this.playerImage,
    required this.scoretxt,
    required this.role,
    required this.borderColor,
    required this.backGroundColor,
    required this.width,
    required this.height,
    super.key,
  });

  @override
  State<getPlayerTurnCard> createState() => _getPlayerTurnCardState();
}

class _getPlayerTurnCardState extends State<getPlayerTurnCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: widget.borderColor, width: 2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.backGroundColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage('assets/${widget.playerImage}.png'),
            width: 70,
            height: 70,
          ),
          Text(
            widget.scoretxt,
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
            ),
          ),
          Image(
            image: AssetImage('assets/${widget.role}.png'),
            width: 45,
          ),
        ],
      ),
    );
  }
}
