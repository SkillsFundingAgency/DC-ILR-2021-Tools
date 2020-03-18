TRUNCATE TABLE Report.ViolationSummaryReport

INSERT INTO Report.ViolationSummaryReport
SELECT * FROM Report.ILR_RuleViolationSummaryView
