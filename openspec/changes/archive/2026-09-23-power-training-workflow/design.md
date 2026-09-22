# Design

## Context

Текущее состояние (см. proposal.md): плоская сущность PowerTraining (id, name, description), таблица drift `power_training_table` (id PK + data JSON), generic BaseRepository<T>, PowerTrainingBloc (Fetched/Created/Deleted/Changed — Changed заглушка), экраны-заглушки (PtDetailsScreen со статичными строками, CardioTrainingList — Placeholder). Хранение через Provider DI, состояние через flutter_bloc, локализация ru/en через gen-l10n.

Стек: Flutter, drift 2.35 + sqlite3 3.6 (без sqlite3_flutter_libs), json_serializable для сущностей, equatable 3.

## Goals / Non-Goals

**Goals:**
- Двухуровневый справочник (категории → подкатегории → упражнения).
- Переиспользуемые наборы с текущим набором и мягким удалением.
- Тренировки с датой и подходами, выполнение, история, статистика.
- Миграция существующих данных без потерь.

**Non-Goals:**
- Кардио-тренировки (отдельный будущий чейндж).
- Синхронизация/онлайн (login-экран остаётся заглушкой).
- Аналитика прогресса за пределами наброска.

## Decisions

### 1. Реляционная схема вместо JSON-блоба
Новая модель требует связей (категория→упражнение, набор→упражнение, тренировка→подход). Связи и порядок хранятся в отдельных таблицах drift, а не в JSON-колонке (как сейчас делает `data`).

Таблицы (schemaVersion 3):
- `category`: id (PK), name (unique), parent_id (nullable, FK на category).
- `exercise`: id (PK), name, category_id (FK).
- `exercise_set`: id (PK), name (unique), description, is_current.
- `exercise_set_item`: id (PK), exercise_set_id (FK), exercise_id (FK), position, is_deleted.
- `power_training`: id (PK), name, description, date (nullable), exercise_set_id (FK nullable).
- `power_training_approach`: id (PK), power_training_id (FK), exercise_id (FK), position, reps, weight, source.

`source` подхода (`manual` | `applied`) реализует цветовое различие применённых/добавленных значений.

Альтернатива: хранить состав набора и подходы как JSON в одной колонке — проще, но нет FK-целостности и сложно делать счётчики и защиту от удаления. Отвергнута.

### 2. Удаление категории — блокировка непустой
Удаление категории/подкатегории, содержащей упражнения или подкатегории, блокируется (без каскада), чтобы избежать случайной потери данных. Удаление упражнения — прямое.

### 3. Мягкое удаление элемента набора
`exercise_set_item.is_deleted` вместо физического удаления строки: новые тренировки показывают только `is_deleted = false`, статистика старых тренировок — все элементы (удалённые — серым). Прямо отвечает на заметку наброска про «серый цвет» и «0-0 в старых тренировках».

### 4. Таймер отдыха — раскрывающаяся карточка подхода
В наброске обсуждаются showModalBottomSheet vs ExpansionTile. Выбираем раскрытие карточки подхода (ExpansionTile): таймер и информация остаются привязанными к подходу, нет проблемы «закрыл шторку — сломал состояние» (набросок прямо указывает на эту сложность). Таймер работает в bloc (Timer), не в шторке.

### 5. Отдельные bloc на область
Вместо одного разросшегося PowerTrainingBloc — отдельные bloc: ExerciseCatalogBloc, ExerciseSetBloc, расширенный PowerTrainingBloc, PowerTrainingExecutionBloc. Каждый под свою фичу, общие репозитории через Provider DI.

### 6. Сущности — UUID на репозитории
ID генерируются в репозитории через существующий UuidGenerator (как сейчас у PowerTraining), сущности иммутабельны (copyWith).

## Risks / Trade-offs

- [Миграция существующих записей] → старые PowerTraining (только name+description) остаются в power_training с date=null и без набора; остаются в списке, но без подходов. Потерь нет.
- [Уникальность названий] → unique-индексы в БД + проверка перед вставкой в репозитории; ошибка ловится и показывается сообщением.
- [Таймер/фоновая работа] → таймер только на активном экране выполнения, без фоновой службы (в наброске не требуется).
- [Большой объём] → чейндж реализуется поэтапно (tasks.md), каждый этап компилируется отдельно.

## Migration Plan

schemaVersion 2 → 3:
1. Создать новые таблицы (category, exercise, exercise_set, exercise_set_item, power_training_approach).
2. Перестроить `power_training_table`: вместо колонки data (JSON) — колонки name, description, date, exercise_set_id; перенести name/description из существующего JSON.
3. Откат не предусмотрен — данные локальные, схема мигрирует вперёд.

## Open Questions

- Точные диапазоны валидации повторов/веса — уточнить при реализации, не влияет на спеки.
- Экспорт/импорт тренировок — вне наброска, не входит в чейндж.
