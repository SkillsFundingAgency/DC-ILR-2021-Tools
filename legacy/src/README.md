# Easy OPA installation instructions

## Things to install
You will need to download and install the following:

- [SQLXLM 4 SP 1](https://www.microsoft.com/en-us/download/details.aspx?id=30403)
  - Download the x64 executable when asked to select the one to download

> <p style="color:red;font-weight:bold">WARNING</p>
> <p style="color:red">Turn on .NET Framwork 3.5 in Windows Features</p>

- [Microsoft SQL Server 2017 (default installation) Developer Edition](https://my.visualstudio.com/Downloads?q=SQL%20Server%202017)

## Uplift instructions

1. Copy the previous years file in the ./Shell/Assets folder and name it the
   current year.
> <p style="color:red;font-weight:bold">WARNING</p>
> <p style="color:red">Make sure that the files are set to "Copy If Newer" in Visual Studio</p>
2. Take the current ILR file and place it:
  - ./Shell/Assets
  - ./Shell/Assets/{period}/Production/ILRSchema
3. Copy the bulkloadSchema file of the previous year and add and remove sections
   based on the ILR specification. This file deals with the mapping between the
   ILR file and what fields are created in the database.
2. Update the following files
  - relationships.xml
    - Copy the previous <Schema></Schema> and update the namespace to the
      current year
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
    - copy the set of <Batch> sections and update the file path to the new
      current year.
