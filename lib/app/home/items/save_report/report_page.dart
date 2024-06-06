import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'dart:ui' as ui;
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';
import 'package:patrimony/entity/item_entity.dart';
import 'package:patrimony/uikit/components/appBar/custom_dynamic_app_bar.dart';
import 'package:share_plus/share_plus.dart';

class SaveReportPage extends StatefulWidget {
  final CompanyEntity companyEntity;
  final CommonValueEntity categoryEntity;
  final List<ItemEntity> items;
  const SaveReportPage({super.key, required this.companyEntity, required this.categoryEntity, required this.items});

  @override
  State<SaveReportPage> createState() => _SaveReportPageState();
}

class _SaveReportPageState extends State<SaveReportPage> {
  final GlobalKey _boundaryKey = GlobalKey();
  Uint8List _imageBytes = Uint8List(0);
  final _valueFormatter = CurrencyTextInputFormatter(
      decimalDigits: 2,
      locale: 'pt_BR',
      symbol: 'R\$'
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDynamicAppBar(
          title: widget.categoryEntity.name ?? "",
          items: [
            MenuItem("Enviar relatório", () => _capturePng())
          ]
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _screen(),
      ),
    );
  }

  Widget _screen() {
    var statusList = widget.items.map((e) => e.status).toSet();
    var spacer = const SizedBox(height: 4.0,);

    return SingleChildScrollView(
      child: RepaintBoundary(
        key: _boundaryKey,
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.companyEntity.name}\n'),
              spacer,
              Text('Categoria: ${widget.categoryEntity.name}'),
              spacer,
              Text('      Quantidade: ${widget.items.length}'),
              spacer,
              Text('      Valor Total: ${_valueFormatter.formatDouble(widget.items.map((e) => e.value ?? 0).toList().sum.toDouble())}'),
              spacer,
              const Text('      Itens:'),
              spacer,
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: statusList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var status = statusList.elementAt(index);
                    var itemsInStatus = widget.items.where((element) => element.status == status);
                    var workingStatusList = itemsInStatus.map((e) => e.workingStatus).toSet();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('            * ${status ?? 'Sem status definido'}'),
                        spacer,
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: workingStatusList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var workingStatus = workingStatusList.elementAt(index);
                              var itemsInWorkingStatus = itemsInStatus.where((element) => element.workingStatus == workingStatus);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('                  - $workingStatus'),
                                  spacer,
                                  ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: itemsInWorkingStatus.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        var item = itemsInWorkingStatus.elementAt(index);
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('                        * ${item.name} - ${_valueFormatter.formatDouble(item.value?.toDouble() ?? 0.0)}'),
                                            spacer,
                                          ],
                                        );
                                      }
                                  ),
                                  spacer,
                                  spacer,
                                  spacer,
                                ],
                              );
                            }
                        )
                      ],
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _capturePng() async {
    try {
      RenderRepaintBoundary? boundary =
      _boundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      ui.Image? image = await boundary?.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image?.toByteData(format: ui.ImageByteFormat.png);

      Share.shareXFiles([XFile.fromData(byteData!.buffer.asUint8List())]);
    } catch (e) {
      print(e);
    }
  }
}
