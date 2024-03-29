Attribute VB_Name = "Module1"
Sub VBA_Scripting_Moderate()

' MAIN SCRIPT

    ' Declare The Variables
    Dim ticker_name As String
    
    Dim ticker_volume As Double
        ticker_volume = 0
        
    Dim summary_ticker_row As Integer
        summary_ticker_row = 2
        
    Dim open_price As Double
        open_price = Cells(2, 3).Value
        
    Dim close_price As Double
    
    Dim yearly_change As Double
    
    Dim percent_change As Double
    
    ' Set flexible last row
    last_row = Cells(Rows.Count, 1).End(xlUp).Row
    
    'Set up Summary Table
    Cells(1, 9).Value = "Ticker"
    Cells(1, 10).Value = "Yearly Change"
    Cells(1, 11).Value = "Percent Change"
    Cells(1, 12).Value = "Total Stock Volume"
    
    ' Before setting the loop, do a manual check that the tickers column
    'is properly formatted andin alphabetical order
    
    ' Ticker Loop
    For i = 2 To last_row
    
        ' search for when the value of the next cell is different than that of
        ' current cell
        If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
        
            ' get the ticker name and volume
            ticker_name = Cells(i, 1).Value
            ticker_volume = ticker_volume + Cells(i, 7).Value
            
            ' print the values in the summary table
            Range("I" & summary_ticker_row).Value = ticker_name
            Range("L" & summary_ticker_row).Value = ticker_volume
            
            ' where to find the closing price
            close_price = Cells(i, 6).Value
            
            ' calculate the yearly change
            yearly_change = (close_price - open_price)
            
            ' print the value in the summary table
            Range("J" & summary_ticker_row).Value = yearly_change
            
                ' set condition for percent calculation
                If (open_price = 0) Then
                    percent_change = 0
                    
                ' calculate percent change
                Else: percent_change = yearly_change / open_price
                
                End If
                
            ' print the value into the summary table & format
            Range("K" & summary_ticker_row).Value = percent_change
            Range("K" & summary_ticker_row).NumberFormat = "0.00%"

            ' reset the row counter
            summary_ticker_row = summary_ticker_row + 1
            
            ' reset the ticker volume
            ticker_volume = 0
            
            ' reset the opening price
            open_price = Cells(i + 1, 3)
            
        ' add up the volume of the ticker
        Else: ticker_volume = ticker_volume + Cells(i, 7).Value
        
        End If
    
    Next i
    
' CONDITIONAL FORMATTING

    ' Set flexible last row of summary table
    last_row_summary_table = Cells(Rows.Count, 9).End(xlUp).Row
    
    ' set formatting loop
    For i = 2 To last_row_summary_table
        
        If Cells(i, 10).Value > 0 Then
            Cells(i, 10).Interior.ColorIndex = 4
            
        Else: Cells(i, 10).Interior.ColorIndex = 3
        
        End If
        
    Next i
    
End Sub

