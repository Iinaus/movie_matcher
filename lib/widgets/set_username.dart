import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/moviematch.dart';

class SetUsername extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final style = theme.textTheme.headlineMedium!.copyWith(
      color: theme.colorScheme.primary,
    );
   
    var movieMatch = context.read<MovieMatchProvider>();

    final TextEditingController controller = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Enter your username',
            style: style,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              String userName = controller.text.trim();
              if (userName.isNotEmpty) {
                movieMatch.setUserName(userName);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Username cannot be empty")),
                );
              }
            },
            child: const Text("Save"),
          ),
        ),
      ],
    );
  }
}
