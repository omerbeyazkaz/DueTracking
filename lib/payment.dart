import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isBankSelected = false; // Banka / Kredi Kartı seçili mi
  bool isTransferSelected = false; // Havale seçili mi
  String selectedMonthYear = "Aralık 2024"; // Varsayılan seçili ay/yıl
  bool showUnpaidMonths = false; // Aylar açılma durumu
  List<String> unpaidMonths = ["Kasım 2024", "Ekim 2024", "Eylül 2024"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Ödemeler'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red.shade50, // Renkli alan
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.red.shade50, // Tüm arka plan rengi
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Başlık ve Tarih Seçimi
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showUnpaidMonths = !showUnpaidMonths;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      selectedMonthYear,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.keyboard_arrow_down,
                                        color: Colors.black),
                                  ],
                                ),
                              ),
                              Text(
                                "₺200.00",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Divider(),

                          // Ödeme Yöntemi
                          Text(
                            "Ödeme Yöntemi",
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          _buildExpandableSection(
                            title: "Banka / Kredi Kartı",
                            isSelected: isBankSelected,
                            onTap: () {
                              setState(() {
                                isBankSelected = !isBankSelected;
                                isTransferSelected = false;
                              });
                            },
                            children: isBankSelected
                                ? [
                                    _buildSimpleTextField("İsim Soyisim"),
                                    _buildCardNumberField("Kart Numarası"),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Son Kullanma Tarihi",
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        
                                        Expanded(
                                          flex: 2,
                                          child: _buildDropdownField(
                                            label: "Ay",
                                            items: List.generate(
                                                12, (index) => "${index + 1}"),
                                            value: null,
                                            onChanged: (value) {},
                                          ),
                                        ),
                                    
                                        const SizedBox(width: 4), // Daha dar
                                        Expanded(
                                          flex: 4,
                                          child: _buildDropdownField(
                                            label: "Yıl",
                                            items: List.generate(
                                                7, (index) => "${2024 + index}"),
                                            value: null,
                                            onChanged: (value) {},
                                          ),
                                        ),
                                        const SizedBox(width: 12), // Daha uzak
                                        Expanded(
                                          flex: 2,
                                          child: _buildSimpleTextField(
                                            "CVV",
                                            isNumeric: true,
                                            maxLength: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]
                                : [],
                          ),
                          const SizedBox(height: 8),
                          _buildExpandableSection(
                            title: "Havale",
                            isSelected: isTransferSelected,
                            onTap: () {
                              setState(() {
                                isTransferSelected = !isTransferSelected;
                                isBankSelected = false;
                              });
                            },
                            children: isTransferSelected
                                ? [
                                    _buildSimpleTextField("IBAN"),
                                    _buildSimpleTextField("Açıklama"),
                                  ]
                                : [],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Ödeme Butonu
                    ElevatedButton(
                      onPressed: () {
                        // Ödeme İşlemi
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "₺200.00 öde",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Geçmiş İşlemler
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Geçmiş İşlemler",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllTransactionsPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Hepsini Görüntüle",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildTransactionItem("Aralık", "-₺200.00", "12/12/24"),
                    _buildTransactionItem("Kasım", "-₺200.00", "11/11/24"),
                  ],
                ),
              ),
            ),
            if (showUnpaidMonths)
              Positioned(
                top: 90, // Daha yukarı taşındı
                left: 16,
                right: 16,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: ListView(
                    shrinkWrap: true,
                    children: unpaidMonths
                        .map(
                          (month) => ListTile(
                            title: Text(month),
                            onTap: () {
                              setState(() {
                                selectedMonthYear = month;
                                showUnpaidMonths = false;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          onTap: onTap,
        ),
        if (isSelected) ...children,
      ],
    );
  }

  Widget _buildSimpleTextField(String label,
      {bool isNumeric = false, int? maxLength}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildCardNumberField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(16),
          CardNumberInputFormatter(),
        ],
        decoration: InputDecoration(
          labelText: label,
          hintText: "____-____-____-____",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    required String? value,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      value: value,
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildTransactionItem(String title, String amount, String date) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(Icons.receipt_long, color: Colors.grey),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(date),
        trailing: Text(
          amount,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll('-', '');
    final newText = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) newText.write('-');
      newText.write(text[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class AllTransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tüm İşlemler"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Filtrele",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildTransactionItem("Aralık", "-₺200.00", "12/12/24"),
                  _buildTransactionItem("Kasım", "-₺200.00", "11/11/24"),
                  _buildTransactionItem("Ekim", "-₺200.00", "10/10/24"),
                  _buildTransactionItem("Eylül", "-₺200.00", "09/09/24"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String title, String amount, String date) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(Icons.receipt_long, color: Colors.grey),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(date),
        trailing: Text(
          amount,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
