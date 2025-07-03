import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shrimp_care_mobileapp/base/components/widget/app_bar.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';
import 'dart:io';

class SamplingInputPage extends StatefulWidget {
  @override
  _SamplingInputPageState createState() => _SamplingInputPageState();
}

class _SamplingInputPageState extends State<SamplingInputPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  String? selectedTambak;
  String? selectedSamplingName;
  final beratUdangController = TextEditingController();
  final jumlahUdangController = TextEditingController();
  final catatanController = TextEditingController();
  List<File> selectedImages = [];

  final List<String> tambakList = ['Tambak A', 'Tambak B', 'Tambak C'];
  final List<String> samplingNameList = ['Sampling Pagi', 'Sampling Siang'];

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    if (selectedImages.length >= 5) return;
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImages.add(File(image.path));
      });
    }
  }

  Widget _buildImageGrid() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...selectedImages.map((image) => Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: -6,
                  right: -6,
                  child: IconButton(
                    icon: Icon(Icons.close, size: 18, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        selectedImages.remove(image);
                      });
                    },
                  ),
                )
              ],
            )),
        if (selectedImages.length < 5)
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add, color: Colors.grey),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Sampling Input",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Warning Box
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '⚠️ Agar hasil sampling lebih akurat dan bervariatif, ambil sampel dari beberapa titik berbeda di tambak.',
                  style: TextStyle(color: Colors.red),
                ),
              ),

              // Tanggal
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Tanggal *',
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                onTap: _pickDate,
                controller: TextEditingController(
                  text: selectedDate == null
                      ? ''
                      : DateFormat('dd MMM yyyy').format(selectedDate!),
                ),
              ),
              const SizedBox(height: 16),

              // Pilih Tambak
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Tambak *',
                  border: OutlineInputBorder(),
                ),
                value: selectedTambak,
                items: tambakList
                    .map((tambak) =>
                        DropdownMenuItem(value: tambak, child: Text(tambak)))
                    .toList(),
                onChanged: (value) => setState(() {
                  selectedTambak = value;
                }),
              ),
              const SizedBox(height: 16),

              // Nama Sampling
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Nama Sampling *',
                  border: OutlineInputBorder(),
                ),
                value: selectedSamplingName,
                items: samplingNameList
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                  selectedSamplingName = value;
                }),
              ),
              const SizedBox(height: 16),

              // Berat Udang dan Jumlah Udang
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: beratUdangController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Berat Udang (g)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: jumlahUdangController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Jumlah Udang',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Catatan
              TextFormField(
                controller: catatanController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Catatan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Foto Dokumentasi
              const Text(
                'Foto Dokumentasi Sampling',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              _buildImageGrid(),

              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Simpan data
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sampling disimpan')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: MyColor.primary,
                  ),
                  child: Text(
                    'Kirim',
                    style: MyTextStyle.text16.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
