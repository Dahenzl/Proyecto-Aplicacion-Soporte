import 'package:proyecto_aplicacion_soporte/data/repositories/report_repository.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/report.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mocks/report_test.mock.mocks.dart';

void main() {
  late ReportRepository reportRepository;
  late MockIReportDataSource mockReportDataSource;

  setUp(() {
    mockReportDataSource = MockIReportDataSource();
    reportRepository = ReportRepository(mockReportDataSource);
  });

  group('ReportRepository Tests', () {
    test('getReports should retrieve reports from the data source', () async {
      // Arrange
      when(mockReportDataSource.getReports()).thenAnswer((_) async => <Report>[]);

      // Act
      var reports = await reportRepository.getReports();

      // Assert
      verify(mockReportDataSource.getReports()).called(1);
      expect(reports, isA<List<Report>>());
    });

    test('addReport should forward the addReport call to the data source', () async {
      // Arrange
      Report newReport = Report(
        id: 1,
        title: 'reporte1',
        rating: 5.0,
        userId: 1,
        duration: 95,
        startTime: 452,
        supportId: 1,
        description: 'mi descripción',
      );
      when(mockReportDataSource.addReport(any)).thenAnswer((_) async => true);

      // Act
      bool result = await reportRepository.addReport(newReport);

      // Assert
      verify(mockReportDataSource.addReport(newReport)).called(1);
      expect(result, isTrue);
    });

    test('updateReport should forward the updateReport call to the data source', () async {
      // Arrange
      Report updatedReport = Report(
        id: 1,
        title: 'reporte1 actualizado',
        rating: 4.0,
        userId: 1,
        duration: 100,
        startTime: 500,
        supportId: 1,
        description: 'descripción actualizada',
      );
      when(mockReportDataSource.updateReport(any)).thenAnswer((_) async => true);

      // Act
      bool result = await reportRepository.updateReport(updatedReport);

      // Assert
      verify(mockReportDataSource.updateReport(updatedReport)).called(1);
      expect(result, isTrue);
    });

    test('deleteReport should forward the deleteReport call to the data source', () async {
      // Arrange
      int reportId = 1;
      when(mockReportDataSource.deleteReport(any)).thenAnswer((_) async => true);

      // Act
      bool result = await reportRepository.deleteReport(reportId);

      // Assert
      verify(mockReportDataSource.deleteReport(reportId)).called(1);
      expect(result, isTrue);
    });

    test('getReportsBySupportId should retrieve reports by supportId from the data source', () async {
      // Arrange
      int supportId = 1;
      when(mockReportDataSource.getReportsBySupportId(any)).thenAnswer((_) async => <Report>[]);

      // Act
      var reports = await reportRepository.getReportsBySupportId(supportId);

      // Assert
      verify(mockReportDataSource.getReportsBySupportId(supportId)).called(1);
      expect(reports, isA<List<Report>>());
    });
  });
}
