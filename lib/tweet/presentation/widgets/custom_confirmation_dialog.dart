import 'package:flutter/material.dart';

showConfirmationDialog(BuildContext context, 
                      String title, 
                      String content, 
                      String cancelText,
                      String confirmActionText, 
                      Function onCancel, 
                      Function onConfirmAction) 
{
  
  showDialog(
    context: context, 
    builder:(dialogContext) => AlertDialog(
      title: Text(title),
      titlePadding: const EdgeInsets.fromLTRB(24, 15, 24, 8),
      content: Text(content),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      actionsPadding: const EdgeInsets.only(right: 16, bottom: 0),
      actions: [
        TextButton(
          onPressed: () => onCancel(dialogContext),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Theme.of(dialogContext).textTheme.bodyLarge!.color)
          ), 
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () => onConfirmAction(dialogContext),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Theme.of(dialogContext).textTheme.bodyLarge!.color)
          ), 
          child: Text(confirmActionText),
        )
      ],
    ),
  );
}