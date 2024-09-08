import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Function to generate and open PDF with a watermark
  Future<void> generateAndOpenPDF() async {
    final pdf = pw.Document();

    // Load watermark, signature, and logo images before generating the PDF
    final watermarkImage = await loadImage('assets/cart/logo_back.jpg'); // Path to watermark image
    final signatureImage = await loadImage('assets/cart/Apple.jpg'); // Path to signature image
    final logoImage = await loadImage('assets/cart/logo.jpg'); // Path to logo image

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              // Watermark Image Behind All Content
              pw.Positioned.fill(
                child: pw.Opacity(
                  opacity: 0.12, // Adjust opacity for the watermark effect
                  child: pw.Image(pw.MemoryImage(watermarkImage), fit: pw.BoxFit.cover),
                ),
              ),
              // Actual content that goes on top of the watermark
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Header section with business name and logo image
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      // Business Name and Tagline
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Welcome To',
                            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            'QZ Travel & Tours',
                            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.red),
                          ),
                          pw.Text(
                            'Rent a Car For Tourist & Local Booking',
                            style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic),
                          ),
                        ],
                      ),
                      // Logo Image
                      pw.Image(pw.MemoryImage(logoImage), height: 100, width: 240), // Adjust the size of the logo image as needed
                    ],
                  ),
                  pw.SizedBox(height: 10),

                  // Contact details placed directly under "Rent a Car For Tourist & Local Booking"
                  pw.Row(
                    children: [
                      pw.Text('📍 Skardu  ', style: pw.TextStyle(fontSize: 10)),
                      pw.Text('✉️ qztraveltours@gmail.com  ', style: pw.TextStyle(fontSize: 10)),
                      pw.Text('📞 0347-4434130  ', style: pw.TextStyle(fontSize: 10)),
                      pw.Text('🌐 facebook.com/qztours', style: pw.TextStyle(fontSize: 10)),
                    ],
                  ),
                  pw.SizedBox(height: 15),
                  pw.Divider(thickness: 2),

                  // Confirmation Bill title
                  pw.Center(
                    child: pw.Text(
                      'Confirmation Bill',
                      style: pw.TextStyle(
                        fontSize: 16,
                        color: PdfColors.red,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 10),

                  // Receipt Info
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Receipt Number(17)', style: pw.TextStyle(fontSize: 12)),
                      pw.Text('Date: 1/9/2024', style: pw.TextStyle(fontSize: 12)),
                    ],
                  ),
                  pw.SizedBox(height: 10),

                  // Customer Details
                  pw.Text('Customer Details:', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 5),
                  pw.Text('Name: Mr. Ameer Hamza', style: pw.TextStyle(fontSize: 12)),
                  pw.Text('Phone Number: 0335-3544443', style: pw.TextStyle(fontSize: 12)),
                  pw.SizedBox(height: 10),

                  // Rental Details
                  pw.Text('Rental Details:', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Transport: Corolla / Down Model Prado', style: pw.TextStyle(fontSize: 12)),
                  pw.Text('Rental Start Date: 3/9/2024', style: pw.TextStyle(fontSize: 12)),
                  pw.Text('Rental End Date: 7/9/2024', style: pw.TextStyle(fontSize: 12)),
                  pw.Text('Rental Type: (With Fuel)', style: pw.TextStyle(fontSize: 12)),

                  pw.SizedBox(height: 10),

                  // Charges Table
                  pw.Table(
                    border: pw.TableBorder.all(width: 1, color: PdfColors.black),
                    children: [
                      pw.TableRow(
                        decoration: pw.BoxDecoration(color: PdfColors.red),
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('Description', style: pw.TextStyle(color: PdfColors.white)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('Rate Per Day', style: pw.TextStyle(color: PdfColors.white)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('Days', style: pw.TextStyle(color: PdfColors.white)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('Quantity', style: pw.TextStyle(color: PdfColors.white)),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('Amount', style: pw.TextStyle(color: PdfColors.white)),
                          ),
                        ],
                      ),
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('Down Model Prado'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('31,000 PKR'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('1'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('1'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('31,000 PKR'),
                          ),
                        ],
                      ),
                      pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('Basho Valley Jeep'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('17,000 PKR'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('1'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('1'),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('17,000 PKR'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),

                  // Total Amount
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total Amount:', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                      pw.Text('48,000 PKR', style: pw.TextStyle(fontSize: 12)),
                    ],
                  ),
                  pw.SizedBox(height: 15),

                  // Advance Payment Information and Signature side by side
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      // Advance Payment Information Table
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            // Advance Payment Information header (not red, regular black text)
                            pw.Text('Advance Payment Information:', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),

                            // Table with red header for "Description" and "Amount Paid"
                            pw.Table(
                              border: pw.TableBorder.all(width: 1, color: PdfColors.black),
                              children: [
                                // Red header for the table
                                pw.TableRow(
                                  decoration: pw.BoxDecoration(color: PdfColors.red),
                                  children: [
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.all(5),
                                      child: pw.Text('Description', style: pw.TextStyle(color: PdfColors.white)),
                                    ),
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.all(5),
                                      child: pw.Text('Amount Paid', style: pw.TextStyle(color: PdfColors.white)),
                                    ),
                                  ],
                                ),
                                // Data rows in the table
                                pw.TableRow(
                                  children: [
                                    pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text('Advance Payment')),
                                    pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text('1,000 PKR')),
                                  ],
                                ),
                                pw.TableRow(
                                  children: [
                                    pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text('Date of Payment')),
                                    pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text('1/9/2024')),
                                  ],
                                ),
                                pw.TableRow(
                                  children: [
                                    pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text('Payment Method')),
                                    pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text('Jazz Cash')),
                                  ],
                                ),
                                pw.TableRow(
                                  children: [
                                    pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text('Balance Due')),
                                    pw.Padding(padding: const pw.EdgeInsets.all(5), child: pw.Text('47,000 PKR')),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Signature Image on the right side of the table
                      pw.SizedBox(width: 20), // Add some space between the table and the signature
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Image(pw.MemoryImage(signatureImage), height: 80, width: 180), // Image with proper height and width
                          pw.SizedBox(height: 5),
                          pw.Text('Recipient Signature', style: pw.TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 30),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Save and open the PDF
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'confirmation_bill.pdf');
  }

  // Function to load an image from a given file path
  Future<Uint8List> loadImage(String path) async {
    final file = File(path);
    return await file.readAsBytes(); // Read the image file as bytes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate PDF'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await generateAndOpenPDF();
          },
          child: Text('Generate PDF'),
        ),
      ),
    );
  }
}
