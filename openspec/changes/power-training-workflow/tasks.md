# Tasks

## 1. Доменные сущности (packages/entity)

- [ ] 1.1 Добавить сущность Category (id, name, parentId?) с @JsonSerializable и Equatable; проверить `dart run melos run codegen` и `flutter analyze` без ошибок
- [ ] 1.2 Добавить сущность Exercise (id, name, categoryId); проверить кодген и analyze
- [ ] 1.3 Добавить ExerciseSet (id, name, description, isCurrent) и ExerciseSetItem (exerciseId, position, isDeleted); проверить кодген и analyze
- [ ] 1.4 Добавить Workout (id, name, description, date?, exerciseSetId?); проверить кодген и analyze
- [ ] 1.5 Добавить WorkoutApproach (id, workoutId, exerciseId, position, reps, weight, source) с enum-полем source (manual/applied); проверить кодген и analyze
- [ ] 1.6 Заменить PowerTraining на Workout в entity.dart (экспорт) и удалить старую сущность; проверить `flutter analyze` — ссылок на PowerTraining не осталось

## 2. Интерфейсы хранилища (packages/storage_api)

- [ ] 2.1 Добавить BaseCategoryRepository и BaseExerciseRepository (create/findAll/delete + уникальность названия); проверить `flutter analyze`
- [ ] 2.2 Добавить BaseExerciseSetRepository (create/findAll/setCurrent/reorder/softDeleteItem/delete с защитой используемого); проверить analyze
- [ ] 2.3 Добавить BaseWorkoutRepository и BaseWorkoutApproachRepository (findAll с сортировкой по дате, подходы по тренировке/упражнению); проверить analyze
- [ ] 2.4 Обновить экспорты в storage_api.dart; проверить `flutter analyze`

## 3. Схема drift и миграция (packages/storage_local_api)

- [ ] 3.1 Объявить таблицы category, exercise, exercise_set, exercise_set_item, workout, workout_approach в database.dart с FK и unique-индексами; проверить `dart run melos run codegen` генерирует классы таблиц
- [ ] 3.2 Поднять schemaVersion до 3 и написать миграцию: создать новые таблицы, перенести строки power_training_table в workout (name/description), удалить старую таблицу; проверить миграцию на устройстве (существующие записи сохраняются)
- [ ] 3.3 Перегенерировать database.g.dart; проверить `flutter analyze`

## 4. Реализации репозиториев (storage_local_api + storage_mock_api)

- [ ] 4.1 Реализовать CategoryRepository (drift): create с проверкой уникальности, findAll с вложенными подкатегориями, delete с блокировкой непустой; проверить сценарии «пустое название/дубликат/удаление непустой» на устройстве
- [ ] 4.2 Реализовать ExerciseRepository (drift): create/findAll по категории/delete; проверить добавление и удаление упражнения
- [ ] 4.3 Реализовать ExerciseSetRepository (drift): create (первый набор — current), setCurrent, reorder, softDeleteItem (is_deleted), delete с защитой используемого; проверить «удаление используемого набора отклоняется»
- [ ] 4.4 Реализовать WorkoutRepository и WorkoutApproachRepository (drift): create/findAll с сортировкой по дате, добавление/удаление подхода, фиксация даты при завершении; проверить сценарии спек workouts/workout-execution
- [ ] 4.5 Добавить mock-реализации всех репозиториев в storage_mock_api (параллельно drift); проверить `flutter analyze`

## 5. Bloc-слой (lib/bloc)

- [ ] 5.1 Создать ExerciseCatalogBloc (load/addCategory/addSubcategory/addExercise/delete) с состояниями; проверить `flutter analyze`
- [ ] 5.2 Создать ExerciseSetBloc (load/create/setCurrent/reorder/removeItem/delete); проверить analyze
- [ ] 5.3 Создать WorkoutBloc (load с группировкой/сортировкой, create, delete); проверить analyze
- [ ] 5.4 Создать WorkoutExecutionBloc (load подходов, addApproach, removeApproach, timer, applyPrevious, finish); проверить analyze

## 6. Экраны (lib)

- [ ] 6.1 Экран справочника: категории → подкатегории → упражнения со счётчиками, кнопки «Добавить категорию/подкатегорию/упражнение», удаление с подтверждением; проверить навигацию и добавление на устройстве
- [ ] 6.2 Экран наборов: список с количеством упражнений, создание/редактирование, выбор текущего, reorder (ReorderableListView), мягкое удаление; проверить сценарии спек exercise-sets
- [ ] 6.3 Экран списка тренировок: группировка по месяцам, выбор сортировки, создание (выбор/создание набора), удаление; проверить сценарии спек workouts
- [ ] 6.4 Экран выполнения: упражнения с подходами (повторы/вес), добавление/удаление подхода, таймер (ExpansionTile + Timer), «Следующее упражнение», завершение с подтверждением; проверить сценарии спек workout-execution
- [ ] 6.5 Экран истории: предыдущие записи по упражнению с чекбоксом «все/только эта тренировка», применение прошлых значений, цветовое различие; проверить сценарий «применение прошлых значений»
- [ ] 6.6 Экран статистики: итог тренировки (дата, выполнено упражнений, набор, список); проверить сценарий спек workout-statistics

## 7. Локализация (lib/l10n)

- [ ] 7.1 Добавить новые строки ru/en в l10n (категории, наборы, подходы, таймер, история, статистика и т.д.); проверить `flutter gen-l10n` и отсутствие отсутствующих ключей

## 8. Интеграция и приёмка

- [ ] 8.1 Прогнать полный сценарий из наброска на устройстве: создать категорию/упражнение → набор → тренировку → выполнить с подходами и таймером → применить прошлые значения → завершить → посмотреть статистику; проверить, что всё работает без крашей
- [ ] 8.2 Проверить миграцию старых данных (записи PowerTraining из предыдущих коммитов видны в новом списке тренировок) и `flutter analyze`/`flutter test` без ошибок
