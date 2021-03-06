# Easy OPA installation instructions

## Things to install
You will need to download and install the following:

- [SQLXLM 4 SP 1](https://www.microsoft.com/en-us/download/details.aspx?id=30403)
  - Download the x64 executable when asked to select the one to download

> <p style="color:red;font-weight:bold">WARNING</p>
> <p style="color:red">Turn on .NET Framwork 3.5 in Windows Features</p>

- [Microsoft SQL Server 2017 (default installation) Developer Edition](https://my.visualstudio.com/Downloads?q=SQL%20Server%202017)

## Uplift instructions

1. Copy the previous years file in the ./Easy OPA/Shell/Assets folder and name it the
   current year.
> <p style="color:red;font-weight:bold">WARNING</p>
> <p style="color:red">Make sure that all the files are set to "Copy If Newer" in Visual Studio</p>
2. Take the current ILR file and place it:
   - ./Easy OPA/Shell/Assets
   - ./Easy OPA/Shell/Assets/{period}/Production/ILRSchema
3. Copy the bulkloadSchema file of the previous year and add and remove sections
   based on the ILR specification. This file deals with the mapping between the
   ILR file and what fields are created in the database.
2. Update the following files
   - relationships.xml
      - Copy the previous <Schema></Schema> and update the namespace to the current year
   - rulebase.cfg
      - Copy the set of rulebases from the previous year and find and replace the
        year. e.g. 1920 --> 2021
   - schemamap.cfg
      - Copy the previous <SchemaMap></SchemaMap> and update:
         - <BulkLoad> file name
         - <Message> file name
         - <Namespace> current year
         - <PeriodStartDate> current year start date
         - <Year> current period date
    - sqlbatch.cfg
       - copy the set of <Batch> sections and update the file path to the new current year.

# Key Items to Look at
Currently Supported Rules

- [ ] (ILR) Field Validation
- [ ] (ILR) Main Validation
- [ ] (ILR) Destinations and Progressions Validation
- [ ] (ILR) Derived Values Calculation
- [ ] (ILR) Apprenticeship Earnings Calculation
- [ ] (ILR) Loans Bursary
- [ ] (ILR) FM25 Calculation
- [ ] (ILR) FM25/FM35 Periodisation
- [ ] (ILR) ESF Funding Calculation
- [ ] (ILR) ESF Validation
- [ ] (ILR) FM35 Calculation
- [x] (ILR) Trailblazer Funding Calculation

## Executing Rules

When running the rules the method that orchestrates the process in
ExecutionCoordinator.RunRules. This takes 2 argurments, the
IContainSessionConfiguration and the IContainSessionContext. The Configuration is an interface
containing data of the rules to run and the Input location. The Context contains
the informaiton for the locations in the database to retreve information. Each
Rule has the same operations run on it with the output put into the same output
location. This will be a schema with the same name as the ILR file that has been
input. 

Steps when processing a rules
1. StartLog (not important, just sets up outputtign to the log file)
2. PrepareRun
   - Creates the processing data store using the prepare method in the
     DataStoreFactory.
   - This will resolve the ProcessingDataStoreFactory which will get all the
     batches from the sqlbatch.cfg file that resolves to the
     Enum:BatchProcessName.BuildProcessingDataStore
   - This will run a series of SQL scripts to create the schemas and tables for
     the processing.
   - There is also a clone step the clones the dbo tables to the Input schema
     that was just created.
3. RunRuleBaseSet (Validation)
   - Runs the Validation rules in this section
4. TransformInput
   - Transforms the input into Valid/Invalid/Input
5. RunRulebaseSet (Calculation)
   - Runs the calculation rules
6. CompleteRun
   - Takes the output of the rules and inserts it into a separate schema
7. RunReport (this does nothing)
