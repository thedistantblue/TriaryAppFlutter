# Tasks

## 1. Сущности в packages/entity

- [x] 1.1 Добавить `Exercise` (id со сентинелом `''`, name, sets, reps, `copyWith`, `props`) в `packages/entity/lib/src/training/` и экспортировать из `entity.dart` — проверка: `flutter analyze` без ошибок, класс доступен из `package:entity/entity.dart`
- [x] 1.2 Добавить `ExerciseSet` (id со сентинелом `''`, name, упорядоченный `List<String> exerciseIds`, `copyWith`, `props`) и экспортировать — проверка: `flutter analyze` без ошибок, `exerciseIds` сериализуется в JSON набора
- [x] 1.3 Добавить `setId` (String, дефолт `''`) в `PowerTraining` с обновлением `copyWith`, `props` и `power_training.g.dart` в детерминированном виде json_serializable (`setId: json['setId'] as String? ?? ''`) — проверка: `dart run melos run codegen` не даёт диффа в `power_training.g.dart`

## 2. Схема базы без миграций

- [x] 2.1 Добавить `ExerciseTable` (PK `id` + `data`) и `ExerciseSetTable` (PK `id` + `data`) — проверка: `database.g.dart` содержит оба класса и их табличные данные/companion
- [x] 2.2 Добавить `ExerciseSetLinkTable` (`set_id`, `exercise_id`, `position`, PK `{setId, exerciseId}`) и nullable-колонку `set_id` в `power_training_table` — проверка: `database.g.dart` содержит `exerciseSetLinkTable` и `setId` у таблицы тренировок
- [x] 2.3 Удалить `MigrationStrategy` целиком (вместе с шагом `from < 2` и `customStatement`-пересборкой), выставить `schemaVersion => 1`, оставить создание схемы через `onCreate: createAll()` — проверка: в `database.dart` не осталось ни одного `onUpgrade`, `flutter analyze` без ошибок
- [x] 2.4 Добавить `exercise_table`, `exercise_set_table`, `exercise_set_link_table` в список `@DriftDatabase(tables: ...)` — проверка: `database.g.dart` содержит все четыре таблицы в `allSchemaEntities`

## 3. Репозитории

- [x] 3.1 Добавить `BaseExerciseRepository implements BaseRepository<Exercise>` и `BaseExerciseSetRepository implements BaseRepository<ExerciseSet>` в `packages/storage_api` с экспортами — проверка: `flutter analyze` без ошибок
- [x] 3.2 Реализовать `ExerciseRepository` в `packages/storage_local_api` (create с выдачей id, findById, findAll через `watch()`, findAllById, deleteById) — проверка: `flutter analyze` без ошибок
- [x] 3.3 Реализовать `ExerciseSetRepository` в `packages/storage_local_api`: `create` пишет набор и линк-строки одной транзакцией (`position` = индекс в `exerciseIds`, дубли id не создают вторую строку), `deleteById` удаляет набор вместе с его линк-строками и НЕ трогает упражнения — проверка: `flutter analyze` без ошибок, чтение набора после создания отдаёт тот же порядок
- [x] 3.4 Реализовать `findAllById` у `ExerciseRepository` так, чтобы результат шёл в порядке переданных id (обход списка id, пропуск отсутствующих) — проверка: `flutter analyze` без ошибок, порядок совпадает с `exerciseIds` набора
- [x] 3.5 Добавить `update(PowerTraining)` в `BasePowerTrainingRepository`, drift-реализацию (запись `set_id` из сущности вместе с `data`) и mock-реализацию — проверка: `flutter analyze` без ошибок
- [x] 3.6 Добавить заглушки `ExerciseRepositoryMock` и `ExerciseSetRepositoryMock` в `packages/storage_mock_api` (по образцу `PowerTrainingRepositoryMock`) + экспорты — проверка: `flutter analyze` без ошибок
- [x] 3.7 Зарегистрировать `BaseExerciseRepository` и `BaseExerciseSetRepository` в провайдерах `lib/main.dart` — проверка: приложение запускается и открывает список тренировок

## 4. Тема и локализация

- [x] 4.1 Добавить `tertiary: 0xFFA78BFA` и `onTertiary: 0xFF1B1140` в `ColorScheme` в `lib/main.dart` — проверка: `flutter analyze` без ошибок, цвет доступен как `colorScheme.tertiary`
- [x] 4.2 Добавить строки `startTraining`, `changeSet`, `chooseSet`, `previousTrainings`, `edit`, `start`, `exercisesCount`, `setsCount`, `minutesShort`, `moreExercises` в `app_ru.arb` и `app_en.arb` с ICU-плюралами (`one/few/many/other`) и метаданными плейсхолдеров; `exercisesCount` и `setsCount` возвращают только слово (число подставляется в коде), чтобы число в сводке можно было покрасить отдельно — проверка: `flutter gen-l10n` без ошибок, ключи доступны через `AppLocalizations`

## 5. Экран тренировки (борды 09–13)

- [x] 5.1 Создать `WorkoutBloc` (`WorkoutStarted`, `SetExpansionToggled`), состояние с набором, списком упражнений, статусом и `isExpanded` (по умолчанию `true`), и маршрут `/workout` с аргументом `PowerTraining` — проверка: экран открывается, набор запрашивается по `training.setId`, упражнения — по списку id набора в том же порядке
- [x] 5.2 Реализовать `SetCard` (шапка 64px с именем 20/600 и повёрнутым chevron, разделители, строки упражнений 48px с повторами справа) — проверка: свёрнутая карточка 64px, развёрнутая — по числу строк
- [x] 5.3 Добавить лимит показа (`WorkoutStyle.setPreviewLimit = 3`): при большем числе упражнений показывать три строки и футер «и ещё N упражнений» с chevron, тап по футеру открывает полный список — проверка: набор из 7 упражнений показывает 3 строки и футер «и ещё 4 упражнения»
- [x] 5.4 Реализовать сводку: карточка 312×40 радиуса 12 с `Text.rich` по центру, числа 14/600 (акцент `#48CAA0` при выбранном наборе, `#9AA3AE` без набора), подписи 13/400, разделители `#3A424E`, время как «~N мин» из расчёта 4 мин на подход с округлением до 10 — проверка: 3 упражнения по 3 подхода дают «3 упражнения · 9 подходов · ~40 мин»
- [x] 5.5 Реализовать шапку экрана высотой 136 (`#1C2129`): стрелка назад, имя 28/600 на y=50, описание 14 `#9AA3AE` на y=92, разделитель 1px `#3A424E` — проверка: визуально совпадает с бордами 09/13, кнопка назад возвращает на предыдущий экран
- [x] 5.6 Реализовать полный список набора в `showModalBottomSheet` с прокруткой (имя набора, подзаголовок «N упражнений · M подходов», строки с разделителями, без крестика и без «изменить») — проверка: длинный список прокручивается, высота шторки не растёт, закрытие свайпом/тапом вне шторки возвращает экран в прежнее состояние
- [x] 5.7 Реализовать нижний блок кнопок 48/r24: «Предыдущие тренировки» (`secondary`), «Редактировать» (`tertiary`), «Начать» (`primary`), с явными disabled-цветами `#2C3039`/`#72767E`; где макет показывает кнопку активной, колбэк пустой (ничего не делает), где приглушённой — `onPressed: null` — проверка: нажатия ничего не делают и приложение не падает
- [x] 5.8 Реализовать состояние «набор не выбран»: виджет выбора набора с фоном `#1C3436`, обводкой 1px `#48CAA0` и primary-лейблом «Выбрать набор упражнений», нулевая сводка, «Начать» и «Редактировать» недоступны — проверка: при пустом `setId`, при ссылке на несуществующий набор и при пустом списке упражнений экран выглядит как борд 13, карточки набора нет
- [x] 5.9 Реализовать строку смены набора над карточкой (`ChangeSetCard`, 56/r16): «Сменить набор упражнений» 15/400 при выбранном наборе и выделенный вариант «Выбрать набор упражнений» 15/600 с обводкой — проверка: строка есть в обоих состояниях, нажатие ничего не делает

## 6. Экран деталей тренировки (борд 04)

- [x] 6.1 Добавить в `pt_details.dart` нижнюю кнопку «Начать тренировку» (48/r24, primary, отступы 16 по бокам и снизу) по макету и навигацию `pushNamed('/workout', arguments: training)` — проверка: тап открывает экран тренировки, «назад» возвращает на детали тренировки

## 7. Проверка на машине разработчика

Выполняет пользователь: Dart/Flutter в песочнице нет.

- [ ] 7.1 Прогнать `dart run melos run codegen` (`codegen.cmd`) и сверить `*.g.dart` — ожидаемый результат: `power_training.g.dart`, `exercise.g.dart`, `exercise_set.g.dart` совпадают с ручной версией, а `database.g.dart` дорастает менеджерами/композерами таблиц (в песочнице они не дописаны руками)
- [ ] 7.2 Прогнать `flutter analyze` — результат: нет ошибок и предупреждений
- [ ] 7.3 Прогнать `flutter gen-l10n` (`generateLocalizations.cmd`) — ожидаемый результат: `app_localizations*.dart` перегенерируются, ключи на месте (возможен дифф в порядке ветвей плюралов)
- [ ] 7.4 Переустановить приложение на устройстве (или очистить данные приложения) и убедиться, что схема создаётся с нуля — результат: приложение запускается на чистой базе, старые локальные данные не мешают
- [ ] 7.5 Проверить на устройстве борд 04 → кнопку → состояние борда 13 на экране тренировки → возврат назад — результат: навигация работает в обе стороны, экран без набора выглядит как макет
