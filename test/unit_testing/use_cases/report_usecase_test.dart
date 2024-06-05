import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:proyecto_aplicacion_soporte/domain/models/report.dart';
import 'package:proyecto_aplicacion_soporte/domain/use_case/report_usecase.dart';
import '../../mocks/report_test.mock.mocks.dart';

void main() {
  late MockIReportRepository mockReportRepository;
  late ReportUseCase reportUseCase;

  setUp(() {
    mockReportRepository = MockIReportRepository();
    reportUseCase = ReportUseCase(mockReportRepository);
  });

  group('getReports', () {
    test('should return a list of reports from the repository', () async {
      // Arrange
      final expectedReports = <Report>[
        Report(id: 1, title: 'Report 1', description: 'Description 1', startTime: 1234567890, duration: 60, userId: 1, supportId: 1),
        Report(id: 2, title: 'Report 2', description: 'Description 2', startTime: 1234567891, duration: 70, userId: 2, supportId: 2),
      ];
      when(mockReportRepository.getReports()).thenAnswer((_) async => expectedReports);

      // Act
      final reports = await reportUseCase.getReports();

      // Assert
      expect(reports, equals(expectedReports));
      verify(mockReportRepository.getReports()).called(1);
    });
  });

  group('addReport', () {
    test('should add a report to the repository', () async {
      // Arrange
      final reportToAdd = Report(id: 1, title: 'New Report', description: 'New Description', startTime: 1234567890, duration: 60, userId: 1, supportId: 1);
      when(mockReportRepository.addReport(reportToAdd)).thenAnswer((_) async => true);

      // Act
      final result = await reportUseCase.addReport(reportToAdd);

      // Assert
      expect(result, isTrue);
      verify(mockReportRepository.addReport(reportToAdd)).called(1);
    });
  });

  group('updateReport', () {
    test('should update a report in the repository', () async {
      // Arrange
      final reportToUpdate = Report(id: 1, title: 'Updated Report', description: 'Updated Description', startTime: 1234567890, duration: 60, userId: 1, supportId: 1);
      when(mockReportRepository.updateReport(reportToUpdate)).thenAnswer((_) async => true);

      // Act
      final result = await reportUseCase.updateReport(reportToUpdate);

      // Assert
      expect(result, isTrue);
      verify(mockReportRepository.updateReport(reportToUpdate)).called(1);
    });
  });

  group('deleteReport', () {
    test('should delete a report from the repository', () async {
      // Arrange
      final reportIdToDelete = 1;
      when(mockReportRepository.deleteReport(reportIdToDelete)).thenAnswer((_) async => true);

      // Act
      final result = await reportUseCase.deleteReport(reportIdToDelete);

      // Assert
      expect(result, isTrue);
      verify(mockReportRepository.deleteReport(reportIdToDelete)).called(1);
    });
  });

  group('getReportsBySupportId', () {
    test('should return a list of reports filtered by support ID from the repository', () async {
      // Arrange
      final supportId = 1;
      final expectedReports = <Report>[
        Report(id: 1, title: 'Report 1', description: 'Description 1', startTime: 1234567890, duration: 60, userId: 1, supportId: supportId),
        Report(id: 2, title: 'Report 2', description: 'Description 2', startTime: 1234567891, duration: 70, userId: 2, supportId: supportId),
      ];
      when(mockReportRepository.getReportsBySupportId(supportId)).thenAnswer((_) async => expectedReports);

      // Act
      final reports = await reportUseCase.getReportsBySupportId(supportId);

      // Assert
      expect(reports, equals(expectedReports));
      verify(mockReportRepository.getReportsBySupportId(supportId)).called(1);
    });
  });
}
