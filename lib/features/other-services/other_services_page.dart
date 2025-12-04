import 'package:flutter/material.dart';
import 'package:miigaik/features/common/extensions/num_widget_extension.dart';
import 'package:miigaik/features/common/widgets/simple_app_bar.dart';
import 'package:miigaik/features/edini-dekanat/edini_dekanat_page.dart';
import 'package:miigaik/features/other-services/widgets/item_service.dart';
import 'package:miigaik/features/other-services/widgets/text_block.dart';
import 'package:miigaik/theme/values.dart';

class OtherServicesPage extends StatelessWidget {
  const OtherServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "Полезные сервисы",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingPage),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 30,
            children: [
              TextBlock(
                title: "Вспомогательные ресурсы",
                children: [
                  ItemService(
                    title: "Заказ справок",
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EdiniDekanatPage.spravki()
                        )
                      );
                    },
                    subTitle: "Ресурс для заказа справок прямо в приложении"
                  ),
                  ItemService(
                    title: "Заказ допусков",
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EdiniDekanatPage.dopuski()
                        )
                      );
                    },
                    subTitle: "Ресурс для заказа доступов прямо в приложении"
                  ),
                  ItemService(
                    title: "Служба социального обеспечения",
                    url: "https://www.miigaik.ru/students/social-security-service",
                    subTitle: "Структурное подразделение университета"
                  ),
                ]
              ),
              TextBlock(
                title: "Электронные образовательные ресурсы",
                children: [
                  ItemService(
                    title: "IPR Books",
                    url: "https://www.iprbookshop.ru",
                    subTitle: "В данной системе студент может найти учебные пособия, монографии и прочую литературу"
                  ),
                  ItemService(
                    title: "Elsevier",
                    url: "https://www.sciencedirect.com",
                    subTitle: "Полнотекстовая база данных научно-технической литературы"
                  ),
                  ItemService(
                    title: "Springer",
                    url: "https://link.springer.com",
                    subTitle: "Полнотекстовая база данных научно-технической и медицинской литературы"
                  ),
                  ItemService(
                    title: "Электронный каталог библиотеки МИИГАиК",
                    url: "https://lib.miigaik.ru/cgi-bin/irbis64r_plus/cgiirbis_64_ft.exe",
                    subTitle: "Сервис позволяет ознакомиться с книгами, имеющимися в библиотеке университета"
                  ),
                  ItemService(
                    title: "ЭБС Лань",
                    url: "https://e.lanbook.com",
                    subTitle: "Электронно-библиотечная система (ЭБС) Лань, предоставляет образовательным организациям доступ к электронным версиям книг ведущих издательств учебной, научной, профессиональной литературы и периодики по различным направлениям подготовки"
                  ),
                  ItemService(
                    title: "ЭБС «SocHum»",
                    url: "https://sochum.ru",
                    subTitle: "Материалы, представленные в SOCHUM, отражают результаты современных исследований и проходят обязательную экспертизу в ведущих научно-исследовательских институтах Российской академии наук, что обеспечивает их высокое качество."
                  ),
                ]
              ),
              TextBlock(
                title: "Административные сервисы университета",
                hint: "Для использования данных сервисов вы должны оставить заявку на Внутреннем портале МИИГАиК. Доступно только из локальной сети ВУЗа",
                children: [
                  ItemService(
                    title: "1C:Университет",
                    url: "https://solutions.1c.ru/catalog/university/features",
                    subTitle: "Система автоматизации учета, хранения обработки и анализа корпоративной информации"
                  ),
                  ItemService(
                    title: "Антиплагиат",
                    url: "https://miigaik.antiplagiat.ru",
                    subTitle: "Данный сервис предназначен для проверки рефератов, дипломных работ и ВКР"
                  ),
                  ItemService(
                    title: "КонсультантПлюс",
                    url: "https://student2.consultant.ru/cgi/online.cgi",
                    subTitle: "Справочная система, содержащая нормативно-правовые акты РФ"
                  ),
                  ItemService(
                    title: "Корпоративная почта МИИГАиК",
                    url: "https://webmail.miigaik.ru",
                    subTitle: "Веб-интерфейс для корпоративной почты МИИГАиК"
                  )
                ]
              ),
              TextBlock(
                title: "Прочие важные сервисы",
                children: [
                  ItemService(
                    title: "СДО МИИГАиК (LMS)",
                    subTitle: "Система дистанционного обучения МИИГАиК",
                    url: "https://lms.miigaik.ru/login/index.php",
                  ),
                  ItemService(
                    title: "Yandex 360",
                    subTitle: "Для доступа к сервисам Яндекс 360 (почта, документы, диск и т.д.) используйте имеющуюся учетную запись студента. В качестве логина для входа в Яндекс 360 используйте свой логин (login@edu.miigaik.ru)",
                    url: "https://id.yandex.ru",
                  ),
                  ItemService(
                    title: "Расписание занятий сетевой магистратуры",
                    subTitle: "Расписание занятий сетевой магистратуры",
                    url: "https://schedule.miigaik.ru",
                  ),
                ]
              ),
              30.vs(),
            ],
          ),
        ),
      ),
    );
  }
}