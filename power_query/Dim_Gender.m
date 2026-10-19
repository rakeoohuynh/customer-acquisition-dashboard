let
    Source = Base_Customer_Cleaned,
    #"Removed Other Columns" = Table.SelectColumns(Source,{"Gender"}),
    #"Removed Duplicates" = Table.Distinct(#"Removed Other Columns"),
    #"Added Index" = Table.AddIndexColumn(#"Removed Duplicates", "Index", 1, 1, Int64.Type),
    #"Reordered Columns" = Table.ReorderColumns(#"Added Index",{"Index", "Gender"})
in
    #"Reordered Columns"