let
  Source = Excel.Workbook(File.Contents("C:\Users\ASUS\OneDrive\Desktop\Cybersoft\DA\buoi8\Dataset\Customer\US_Customer_Master_2026.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "Sheet1", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers",{{"Customer_ID", type text}, {"Customer_Name", type text}, {"DOB", type date}, {"Gender", type text}, {"City", type text}, {"State", type text}, {"Zip_Code", Int64.Type}, {"Join_Date", type date}, {"Phone", type text}, {"Acquisition_Channel", type text}}),
    #"Removed Errors" = Table.RemoveRowsWithErrors(#"Changed column type", {"DOB"}),
    #"Replaced Value" = Table.ReplaceValue(#"Removed Errors",null,"Non-Binary",Replacer.ReplaceValue,{"Gender"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value","M","Male",Replacer.ReplaceValue,{"Gender"}),
    #"Replaced Value2" = Table.ReplaceValue(#"Replaced Value1","F","Female",Replacer.ReplaceValue,{"Gender"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Replaced Value2",{{"Annual_Income", Int64.Type}}),
    #"Replaced Value3" = Table.ReplaceValue(#"Changed Type",null,"Unknown",Replacer.ReplaceValue,{"Acquisition_Channel"}),
    #"Capitalized Each Word" = Table.TransformColumns(#"Replaced Value3",{{"Customer_Name", Text.Proper, type text}}),
    #"Replaced Value4" = Table.ReplaceValue(#"Capitalized Each Word","Non-binary","Non-Binary",Replacer.ReplaceValue,{"Gender"}),
    #"Removed Duplicates" = Table.Distinct(#"Replaced Value4", {"Customer_ID"})
in
    #"Removed Duplicates"