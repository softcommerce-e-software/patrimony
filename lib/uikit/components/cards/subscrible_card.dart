import 'package:flutter/material.dart';
import 'package:patrimony/uikit/components/buttons/custom_button.dart';

class SubscribleCard extends StatelessWidget {
  SubscribleCard({super.key});

  final List<String> mock = [
    'Criar propriedade uma propriedade',
    'Criar categorias ilimitadas',
    'Cadastro de itens ilimitados',
    'Cadastro ilimitado de usuários por propriedade',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 300,
        height: 340,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 4,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            Text(
              'Assinatura',
              style: Theme.of(context).textTheme.displayLarge?.apply(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            Text(
              'Mensal R\$ 7,98',
              style: Theme.of(context).textTheme.displayMedium?.apply(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const Spacer(),
            Column(
              children: mock.map((item) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          item,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.apply(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            CustomButton(
              context: context,
              background: Theme.of(context).primaryColor,
              textColor: Theme.of(context).primaryColorLight,
              buttonText: 'Assinar',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
