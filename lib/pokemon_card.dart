import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poke_app/poke_data.dart';

class PokeCard extends StatelessWidget {
  final Pokemon pokemon;
  PokeCard({required this.pokemon});

  bodyWidget(BuildContext context) => Stack(
        children: [
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    pokemon.name ?? '',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Height: ${pokemon.height}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Weight: ${pokemon.weight}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Types",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                            ?.map((t) => FilterChip(
                                  backgroundColor: Colors.purple[500],
                                  label: Text(
                                    t,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onSelected: (b) {},
                                ))
                            ?.toList() ??
                        [],
                  ),
                  const Text(
                    "Weakness",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                            ?.map((t) => FilterChip(
                                  backgroundColor: Colors.red,
                                  label: Text(
                                    t,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onSelected: (b) {},
                                ))
                            .toList() ??
                        [],
                  ),
                  const Text(
                    "Next Evolution",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution == null
                        ? <Widget>[Text("This is the final form")]
                        : pokemon.nextEvolution!
                            .map((n) => FilterChip(
                                  backgroundColor: Colors.green,
                                  label: Text(
                                    n.name!,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onSelected: (b) {},
                                ))
                            .toList(),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img!,
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(pokemon.img!),
                  ),
                ),
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          '',
          style: GoogleFonts.lato(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple[300],
      ),
      body: bodyWidget(context),
    );
  }
}
