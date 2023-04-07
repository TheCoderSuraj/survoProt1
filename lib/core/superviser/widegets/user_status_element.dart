import 'package:flutter/material.dart';
import 'package:survo_protv1/core/server/models/account_model.dart';

class UserStatusElement extends StatelessWidget {
  const UserStatusElement({
    super.key,
    required this.ac,
    this.onPressed,
  });
  final AccountModel ac;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        onTap: onPressed,
        tileColor: ac.isActive ? Colors.green[200] : Colors.red[200],
        leading: const Icon(Icons.person),
        title: Text(ac.name),
        subtitle: Text(ac.id),
        trailing: Icon(
          ac.isActive ? Icons.done : Icons.close,
          color: ac.isActive ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
