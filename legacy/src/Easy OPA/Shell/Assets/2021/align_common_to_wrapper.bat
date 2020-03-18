@echo off

rem i'm built from three asset source folders in the ILR{year} repository
rem Common comes from:				ILR{1718}/source/ILR/Common
rem Artifacts comes from:			ILR{1718}/source/ILR.BinaryTask/Artifacts
rem Process Submission comes from:	ILR{1718}/source/ILR/Process Submission

if not exist Common\NUL (
	echo The Common folder is missing, nothing to do
	pause
	exit 1
)

if not exist Artifacts\NUL (
	echo The Artifacts folder is missing, unable to complete job
	pause
	exit 1
)

if exist Production.old\NUL (
	echo ===================== !! ERROR !! ====================================
	echo An old copy of the Production stuff already exists.
	echo You need to clear this down before the process can continue...
	echo ======================================================================
	pause
	exit 1
)

if exist Production\NUL (
	echo Production already exists, it will be renamed once complete you will to delete it
	pause
	cd "Production"
	for /R "[directory]" %%f in ([*.*]) do (
		attrib -r "%%f"
	)

	for /D %%d in (*) do (
		cd "%%d"
		for /R "[directory]" %%f in ([*.*]) do (
			attrib -r "%%f"
		)
		cd ..
	)

	cd ..
	ren "Production" "Production.old"
)

ren "Common" "Production"
ren "Artifacts" "OPAConfig"

cd "OPAConfig"
del "CleanOutputTables.sql"
del "LearnerLearningDeliveryProjectionQuery.sql"
cd ..

move /y "OPAConfig" "Production\OPAConfig"
cd "Production"

rmdir /s /q "Libraries"
rmdir /s /q "Mock Data"
rmdir /s /q "Validation rules"
rmdir /s /q "XSDs"

ren "Populate Reference Data" "Reference"
ren "Schema Definitions" "ILRSchema"
ren "Scripts" "Supplemental"

cd "Rulebases"
for /D %%d in (*) do (
    cd "%%d"
    if exist Pre\NUL (
        rmdir /s /q "Pre"
    )
    if exist Post\NUL (
        rmdir /s /q "Post"
    )

    cd ..
)
cd ..

cd "Reports"
rmdir /s /q "Report Object Graphs"
cd ..

rem cd "Supplemental"
rem del AddNamespaceError.sql
rem del CopyToWorkingSchema.sql
rem del DisableSnapshotIsolation.sql
rem del InsertFileDetails.sql
rem del Truncate_Rulebase_Schema.sql
rem cd ..

cd "Schema"
cd "dbo"
ren "Tables" "01 Tables"
ren "Views" "02 Views"
ren "Stored Procedures" "03 Procedures"
ren "Functions" "04 Functions"
cd "03 Procedures"
ren "01 ImportFilenames.sql" "03 ImportFilenames.sql"
ren "03_logging.sql" "04 Logging.sql"
ren "TransformInputToInvalid.sql" "01 TransformInputToInvalid.sql"
cd ..
cd ..

cd "Reference"
cd "Tables"
ren "CreateReferenceDataTables.sql" "02 CreateReferenceTables.sql"
cd ..
ren "Tables" "01 Tables"
mkdir "02 Views"
cd ..

cd "Report"
ren "Tables" "01 Tables"
ren "Views" "02 Views"
ren "Stored Procedures" "03 Procedures"
ren "Functions" "04 Functions"
cd ..

cd "Rulebase"
ren "Tables" "01 Tables"
ren "Views" "02 Views"
ren "Stored Procedures" "03 Procedures"
cd ..

cd "Valid"
ren "Tables" "01 Tables"
ren "Views" "02 Views"
cd ..

cd "Invalid"
ren "Tables" "01 Tables"
ren "Views" "02 Views"
cd ..

cd "Input"
ren "Tables" "01 Tables"
ren "Views" "02 Views"
cd ..

cd "Static"
ren "Tables" "01 Tables"
cd ..
cd ..
cd ..

copy "Process Submission\Populate Reference Data\*.*" "Production\Reference\*.*"
copy "Process Submission\Populate Reference Data\Calculation\*.*" "Production\Reference\*.*"
copy "Process Submission\Schema\Reference\Tables\*.*" "Production\Schema\Reference\01 Tables\*.*"
copy "Process Submission\Schema\Reference\Views\*.*" "Production\Schema\Reference\02 Views\*.*"
copy "Process Submission\Schema\Report\Tables\*.*" "Production\Schema\Report\01 Tables\*.*"
copy "Process Submission\Schema\Report\Views\*.*" "Production\Schema\Report\02 Views\*.*"
copy "Process Submission\Schema\Report\Stored Procedures\*.*" "Production\Schema\Report\03 Procedures\*.*"
copy "Process Submission\Schema\Report\Functions\*.*" "Production\Schema\Report\04 Functions\*.*"
copy "Process Submission\Schema\Rulebase\Tables\*.*" "Production\Schema\Rulebase\01 Tables\*.*"
copy "Process Submission\Schema\Rulebase\Stored Procedures\*.*" "Production\Schema\Rulebase\03 Procedures\*.*"

rmdir /s /q "Process Submission"

cd "Production\Reference"
ren "08 FCS_Deliverable_DescriptionSetup .sql" "08 FCS_Deliverable_DescriptionSetup.sql"
ren "InsertReferenceDataSQL_1.sql" "PreValidationReferenceData1.sql"
ren "InsertReferenceDataSQL_3.sql" "PreValidationReferenceData2.sql"
ren "InsertReferenceDataSQL_2.sql" "PostValidationReferenceData.sql"

cd ..

rem pause