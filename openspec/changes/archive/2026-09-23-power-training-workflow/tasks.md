# Tasks

> Верификация: `flutter analyze`, `dart run melos run codegen`, `flutter test` и сборку на устройстве выполняет пользователь локально (в песочнице Flutter/Dart отсутствуют). Ассистент вносит правки и, дойдя до шага верификации, запрашивает у пользователя результат команды, прежде чем двигаться дальше.

## 1. Доменные сущности (packages/entity)

- [x] 1.1 Добавить сущность Category (id, name, parentId?) с @JsonSerializable и Equatable; проверить `dart run melos run codegen` и `flutter analyze` без ошибок
- [x] 1.2 Добавить сущность Exercise (id, name, categoryId); проверить кодген и analyze
- [x] 1.3 Добавить ExerciseSet (id, name, description, isCurrent) и ExerciseSetItem (exerciseId, position, isDeleted); проверить кодген и analyze
- [x] 1.4 Расширить PowerTraining полями date? и exerciseSetId? (сохранив id/name/description); проверить кодген и analyze
- [x] 1.5 Добавить PowerTrainingApproach (id, powerTrainingId, exerciseId, position, reps, weight, source) с enum-полем source (manual/applied); проверить кодген и analyze
- [x] 1.6 Обновить экспорты entity.dart новыми сущностями и расширенным PowerTraining; проверить `flutter analyze`

## 2. Интерфейсы хранилища (packages/storage_api)

- [x] 2.1 Добавить BaseCategoryRepository и BaseExerciseRepository (create/findAll/delete + уникальность названия); проверить `flutter analyze`
- [x] 2.2 Добавить BaseExerciseSetRepository (create/findAll/setCurrent/reorder/softDeleteItem/delete с защитой используемого); проверить analyze
- [x] 2.3 Расширить BasePowerTrainingRepository (findAll с сортировкой по дате) и добавить BasePowerTrainingApproachRepository (подходы по тренировке/упражнению); проверить analyze
- [x] 2.4 Обновить экспорты в storage_api.dart; проверить `flutter analyze`

## 3. Схема drift и миграция (packages/storage_local_api)

- [x] 3.1 Объявить таблицы category, exercise, exercise_set, exercise_set_item, power_training_approach и перестроить power_training_table (name/description/date/exercise_set_id) с FK и unique-индексами; проверить `dart run melos run codegen`
- [x] 3.2 Поднять schemaVersion до 3 и написать миграцию: создать новые таблицы, перестроить power_training_table (извлечь name/description из JSON data, добавить date/exercise_set_id); проверить миграцию на устройстве (существующие записи сохраняются)
- [x] 3.3 Перегенерировать database.g.dart; проверить `flutter analyze`

## 4. Реализации репозиториев (storage_local_api + storage_mock_api)

- [x] 4.1 Реализовать CategoryRepository (drift): create с проверкой уникальности, findAll с вложенными подкатегориями, delete с блокировкой непустой; проверить сценарии «пустое название/дубликат/удаление непустой» на устройстве
- [x] 4.2 Реализовать ExerciseRepository (drift): create/findAll по категории/delete; проверить добавление и удаление упражнения
- [x] 4.3 Реализовать ExerciseSetRepository (drift): create (первый набор — current), setCurrent, reorder, softDeleteItem (is_deleted), delete с защитой используемого; проверить «удаление используемого набора отклоняется»
- [x] 4.4 Расширить PowerTrainingRepository (drift): create/findAll с сортировкой по дате, фиксация даты при завершении; реализовать PowerTrainingApproachRepository (добавление/удаление подхода); проверить сценарии спек workouts/workout-execution
- [x] 4.5 Добавить mock-реализации всех репозиториев в storage_mock_api (параллельно drift); проверить `flutter analyze`

## 5. Bloc-слой (lib/bloc)

- [x] 5.1 Создать ExerciseCatalogBloc (load/addCategory/addSubcategory/addExercise/delete) с состояниями; проверить `flutter analyze`
- [x] 5.2 Создать ExerciseSetBloc (load/create/setCurrent/reorder/removeItem/delete); проверить analyze
- [x] 5.3 Расширить PowerTrainingBloc (load с группировкой/сортировкой, create, delete); проверить analyze
- [x] 5.4 Создать PowerTrainingExecutionBloc (load подходов, addApproach, removeApproach, timer, applyPrevious, finish); проверить analyze

## 6. Экраны (lib)

- [x] 6.1 Экран справочника: категории → подкатегории → упражнения со счётчиками, кнопки «Добавить категорию/подкатегорию/упражнение», удаление с подтверждением; проверить навигацию и добавление на устройстве
- [x] 6.2 Экран наборов: список с количеством упражнений, создание/редактирование, выбор текущего, reorder (ReorderableListView), мягкое удаление; проверить сценарии спек exercise-sets
- [x] 6.3 Экран списка тренировок: группировка по месяцам, выбор сортировки, создание (выбор/создание набора), удаление; проверить сценарии спек workouts
- [x] 6.4 Экран выполнения: упражнения с подходами (повторы/вес), добавление/удаление подхода, таймер (ExpansionTile + Timer), «Следующее упражнение», завершение с подтверждением; проверить сценарии спек workout-execution
- [x] 6.5 Экран истории: предыдущие записи по упражнению с чекбоксом «все/только эта тренировка», применение прошлых значений, цветовое различие; проверить сценарий «применение прошлых значений»
- [x] 6.6 Экран статистики: итог тренировки (дата, выполнено упражнений, набор, список); проверить сценарий спек workout-statistics

## 7. Локализация (lib/l10n)

- [x] 7.1 Добавить новые строки ru/en в l10n (категории, наборы, подходы, таймер, история, статистика и т.д.); проверить `flutter gen-l10n` и отсутствие отсутствующих ключей

## 8. Интеграция и приёмка

- [x] 8.1 Прогнать полный сценарий из наброска на устройстве: создать категорию/упражнение → набор → тренировку → выполнить с подходами и таймером → применить прошлые значения → завершить → посмотреть статистику; проверить, что всё работает без крашей
- [x] 8.2 Проверить миграцию старых данных (записи PowerTraining из предыдущих коммитов видны в новом списке тренировок) и `flutter analyze`/`flutter test` без ошибок
