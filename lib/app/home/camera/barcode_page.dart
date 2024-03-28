import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:patrimony/uikit/components/appBar/custom_dynamic_app_bar.dart';

class BarcodePage extends StatelessWidget {
  BarcodePage({super.key});
  var hasBack = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomDynamicAppBar(
        title: "Código de Barras",
        items: [],
      ),
      body: SafeArea(
        child: MobileScanner(
          onDetect: (capture) async {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              var value = barcode.rawValue;
              if(value?.trim().isNotEmpty == true && !hasBack) {
                hasBack = true;
                Navigator.of(context).pop(value?.trim());
              }
            }
          },
          errorBuilder: (context, exception, widget) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Ocorreu um erro ao tentar acessar a câmera.\nPor favor, ative a câmera nas configurações do aplicativo.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
