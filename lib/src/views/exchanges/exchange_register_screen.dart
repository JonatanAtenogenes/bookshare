import 'package:bookshare/src/data/exchange_data.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/book/api_book_list_provider.dart';
import 'package:bookshare/src/view_models/exchange/exchange_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/button.dart';
import 'package:bookshare/src/views/common/widgets/custom_cards.dart';
import 'package:bookshare/src/views/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:toastification/toastification.dart';

import '../../data/book_data.dart';
import '../../view_models/book/book_provider.dart';
import '../../view_models/exchange/api_exchange_provider.dart';
import '../common/widgets/show_information.dart';

class ExchangeRegisterScreen extends ConsumerStatefulWidget {
  const ExchangeRegisterScreen({super.key});

  @override
  ConsumerState<ExchangeRegisterScreen> createState() =>
      _ExchangeRegisterScreenState();
}

class _ExchangeRegisterScreenState
    extends ConsumerState<ExchangeRegisterScreen> {
  DateTime _selectedDate = DateTime.now();

  /// Displays a date picker dialog to select a date.
  ///
  /// This function allows the user to choose a date from a calendar interface.
  /// It sets the selected date to `_selectedDate` if the user picks a valid date.
  ///
  /// - [context]: The BuildContext used to show the date picker dialog.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 25)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        ref.read(currentSessionExchangeInformation.notifier).update(
              (state) => state.copyWith(
                exchangeDate: DateTime(
                  _selectedDate.year,
                  _selectedDate.month,
                  _selectedDate.day,
                  state.exchangeDate.hour,
                  state.exchangeDate.minute,
                ),
              ),
            );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextDirection textDirection = TextDirection.ltr;
    TimeOfDay? selectedTime = TimeOfDay.now();
    final exchange = ref.watch(currentSessionExchangeInformation);
    final userBooks = ref.watch(userBooksProvider);
    final loadingSelectedBooks = ref.watch(loadingSelectedUserBookListProvider);
    final selectedUserBooks = ref.watch(selectedUserBooksProvider);
    const duration = 3;
    final userIdentifier = (exchange.offeringUser.name != null &&
            exchange.offeringUser.name!.isNotEmpty)
        ? exchange.offeringUser.name!
        : exchange.offeringUser.id.isNotEmpty
            ? exchange.offeringUser.id.substring(10)
            : "Desconocido";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.appTitle,
        ),
      ),
      body: Visibility(
        visible: !loadingSelectedBooks,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SubtitleText(
                  subtitle: AppStrings.exchanges,
                ),
                Text(
                  "User: $userIdentifier",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Valor: ${ref.read(sessionExchangesProvider.notifier).valueOfUserBooks(exchange.offeredBooks)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "Valor Alcanzado: ${ref.read(sessionExchangesProvider.notifier).valueOfUserBooks(exchange.offeringUserBooks)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Text(
                  "Libros seleccionados",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: Visibility(
                    visible: exchange.offeredBooks.isNotEmpty,
                    replacement: const Center(
                      child: Text("No hay libros seleccionados"),
                    ),
                    child: ListView.builder(
                      itemCount: exchange.offeredBooks.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return BookCard(
                          book: exchange.offeredBooks[index],
                          onTap: () {
                            final bookRemoved = ref
                                .read(sessionExchangesProvider.notifier)
                                .removeFromOfferedBooks(
                                  exchange.offeredBooks[index],
                                );
                            final message = bookRemoved
                                ? "Libro eliminado correctamente"
                                : "El libro no se pudo eliminar";
                            toastification.show(
                              context: context,
                              title: Text(message),
                              type: bookRemoved
                                  ? ToastificationType.success
                                  : ToastificationType.error,
                              style: ToastificationStyle.flat,
                              autoCloseDuration: const Duration(
                                seconds: duration,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                TextLink(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(
                                thickness: 5,
                                endIndent: 150,
                                indent: 150,
                              ),
                              const SubtitleText(
                                subtitle: 'Libros del usuario a intercambiar',
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.36,
                                child: ListView.builder(
                                  itemCount: selectedUserBooks.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return BookCard(
                                      book: selectedUserBooks[index],
                                      onTap: () {
                                        final bookAdded = ref
                                            .read(sessionExchangesProvider
                                                .notifier)
                                            .addingToOfferedBooks(
                                              selectedUserBooks[index],
                                            );
                                        final message = bookAdded
                                            ? "Libro agregado correctamente"
                                            : "El libro ya existe en el intercambio";
                                        toastification.show(
                                          context: context,
                                          title: Text(message),
                                          type: bookAdded
                                              ? ToastificationType.success
                                              : ToastificationType.error,
                                          style: ToastificationStyle.flat,
                                          autoCloseDuration: const Duration(
                                            seconds: duration,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  text: "Agregar Libros",
                ),
                const Text(
                  "Libros a intercambiar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: Visibility(
                    visible: exchange.offeringUserBooks.isNotEmpty,
                    replacement: const Center(
                      child: Text("Agrega libros al intercambio"),
                    ),
                    child: ListView.builder(
                      itemCount: exchange.offeringUserBooks.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return BookCard(
                          book: exchange.offeringUserBooks[index],
                          onTap: () {
                            final bookRemoved = ref
                                .read(sessionExchangesProvider.notifier)
                                .removeFromOfferedUserBooks(
                                  exchange.offeringUser,
                                  exchange.offeringUserBooks[index],
                                );
                            final message = bookRemoved
                                ? "Libro eliminado correctamente"
                                : "El libro no se pudo eliminar";
                            toastification.show(
                              context: context,
                              title: Text(message),
                              type: bookRemoved
                                  ? ToastificationType.success
                                  : ToastificationType.error,
                              style: ToastificationStyle.flat,
                              autoCloseDuration: const Duration(
                                seconds: duration,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                TextLink(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(
                                thickness: 5,
                                endIndent: 150,
                                indent: 150,
                              ),
                              const SubtitleText(
                                  subtitle: 'Libros del usuario'),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.36,
                                child: ListView.builder(
                                  itemCount: userBooks.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return BookCard(
                                      book: userBooks[index],
                                      onTap: () {
                                        final bookAdded = ref
                                            .read(sessionExchangesProvider
                                                .notifier)
                                            .addingToOfferedUserBooks(
                                              exchange.offeringUser,
                                              userBooks[index],
                                            );
                                        final message = bookAdded
                                            ? "Libro agregado correctamente"
                                            : "El libro ya existe en el intercambio";
                                        toastification.show(
                                          context: context,
                                          title: Text(message),
                                          type: bookAdded
                                              ? ToastificationType.success
                                              : ToastificationType.error,
                                          style: ToastificationStyle.flat,
                                          autoCloseDuration: const Duration(
                                            seconds: duration,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  text: "Agregar Libros",
                ),
                const SizedBox(
                  height: 25,
                ),
                const Divider(),
                SelectInfoImproved(
                  data: "Fecha de intercambio",
                  selectedData: DateFormat('dd-MM-yyyy').format(_selectedDate),
                  textButton: AppStrings.select,
                  onPressed: () => _selectDate(context),
                ),
                SelectInfoImproved(
                  data: "Hora de intercambio",
                  selectedData:
                      DateFormat('HH:mm').format(exchange.exchangeDate),
                  textButton: AppStrings.select,
                  onPressed: () async {
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: selectedTime ?? TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.inputOnly,
                      orientation: Orientation.portrait,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                          ),
                          child: Directionality(
                            textDirection: textDirection,
                            child: MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                alwaysUse24HourFormat: true,
                              ),
                              child: child!,
                            ),
                          ),
                        );
                      },
                    );
                    setState(() {
                      selectedTime = time;
                    });
                    ref.read(currentSessionExchangeInformation.notifier).update(
                          (state) => state.copyWith(
                            exchangeDate: DateTime(
                              state.exchangeDate.year,
                              state.exchangeDate.month,
                              state.exchangeDate.day,
                              selectedTime!.hour,
                              selectedTime!.minute,
                            ),
                          ),
                        );
                  },
                ),
                SelectInfoImproved(
                  data: "Ubicacion de intercambio",
                  selectedData:
                      "${exchange.exchangeAddress.latitude.toString().substring(0, 8)}, ${exchange.exchangeAddress.longitude.toString().substring(0, 8)}",
                  textButton: AppStrings.select,
                  onPressed: () => context.pushNamed(
                    RouteNames.locationSelectionScreen,
                  ),
                ),
                CustomButton(
                  onPressed: () async {
                    await ref.read(exchangeDataProvider).saveExchange(
                          ref.read(currentSessionExchangeInformation),
                        );
                    final exchangeCreated =
                        ref.read(apiCreateExchangeProvider).success;
                    final message = exchangeCreated
                        ? "Intercambio guardado con exito"
                        : ref.read(apiCreateExchangeProvider).message;
                    toastification.show(
                      title: Text(message),
                      type: exchangeCreated
                          ? ToastificationType.success
                          : ToastificationType.error,
                      style: ToastificationStyle.flat,
                      autoCloseDuration: const Duration(
                        seconds: duration,
                      ),
                    );

                    if (!exchangeCreated) return;

                    // Update the book data
                    ref.read(bookDataProvider).getUserBooks();
                    ref.read(bookDataProvider).getBooks();
                    ref
                        .read(exchangeDataProvider)
                        .listExchanges(ref.read(currentUserProvider).id);

                    WidgetsBinding.instance.addPostFrameCallback((callback) {
                      ref
                          .read(sessionExchangesProvider.notifier)
                          .removeExchange(exchange.offeringUser);

                      context.pop();
                    });
                  },
                  text: "Realizar intercambio",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
