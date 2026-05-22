part of '../imports/products_imports.dart';

/// Modal bottom sheet for picking a status filter. Returns the picked
/// status from `pop`; `null` means "clear filter".
class _ProductsFilterSheet extends StatelessWidget {
  const _ProductsFilterSheet({required this.current});

  final ProductStatus? current;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'تصفية حسب الحالة',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(null),
                    child: const Text('مسح'),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Material 3: a single `RadioGroup` owns the selection; child
            // `RadioListTile`s just declare their `value`. Replaces the
            // deprecated per-tile `groupValue` + `onChanged`.
            RadioGroup<ProductStatus>(
              groupValue: current,
              onChanged: (s) => Navigator.of(context).pop(s),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final status in ProductStatus.values)
                    if (status != ProductStatus.unknown)
                      RadioListTile<ProductStatus>(
                        value: status,
                        title: Text(status.name),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
