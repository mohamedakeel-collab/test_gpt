part of '../imports/products_imports.dart';

/// Simple confirm dialog. Returns `true` from `pop` on confirm,
/// `false`/`null` otherwise — let the caller decide what to do.
class _ProductDeleteDialog extends StatelessWidget {
  const _ProductDeleteDialog({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('حذف المنتج'),
      content: Text('هل تريد حذف "$name" من القائمة؟'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('إلغاء'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('حذف'),
        ),
      ],
    );
  }
}
