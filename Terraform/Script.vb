Option Explicit

Sub SaveAsCSVFile()
'updateby Extendoffice 20160530

    Dim xCell As Range
    Dim xStr As String
    Dim xSep As String

    Dim xName As Variant
    On Error Resume Next
    If ActiveWindow.RangeSelection.Count > 1 Then
      xTxt = ActiveWindow.RangeSelection.AddressLocal
    Else
      xTxt = ActiveSheet.UsedRange.AddressLocal
    End If
    Set xRg = Application.InputBox("Please select the data range:", "Sheet to CSV for Excel", xTxt, , , , , 8)
    If xRg Is Nothing Then Exit Sub
    xName = Application.GetSaveAsFilename("", "CSV File (*.csv), *.csv")
    xSep = Application.International(xlListSeparator)
    Open xName For Output As #1
    For Each xRow In xRg.rows
        xStr = ""
        For Each xCell In xRow.Cells
            xStr = xStr & """" & xCell.value & """" & xSep
        Next
        While Right(xStr, 1) = xSep
            xStr = Left(xStr, Len(xStr) - 1)
        Wend
        Print #1, xStr
    Next
    Close #1
    If Err = 0 Then MsgBox "The file has saved to: " & xName, vbInformation, "Kutools for Excel"
End Sub

Sub CreateInstances()
    Dim fso As New FileSystemObject
    Dim szTemplate As String
    Dim szRoot As String
    Dim szPath As String
    Dim szOutPath As String
    
    
    Dim a As Variant
    Dim rows As Integer
    Dim cols As Integer
    Dim rowIndex As Integer
    Dim colIndex As Integer
    Dim token As String
    Dim resource As String

    
    szRoot = "C:\Users\josep\source\repos\AWS\Terraform\example\vms"
    szPath = fso.BuildPath(szRoot, "instance.template")
    
    a = GetRange()
    rows = UBound(a, 1)
    cols = UBound(a, 2)
    
    For rowIndex = 2 To rows
        szTemplate = fso.OpenTextFile(szPath, ForReading).ReadAll
        resource = a(rowIndex, 10)
        If resource = "VM" Then
            For colIndex = 1 To cols
            
                token = "{Row}"
                szTemplate = Replace(szTemplate, token, CStr(rowIndex))
            
                If a(1, colIndex) = "" Then
                    Exit Sub
                End If
                token = "{" & Replace(a(1, colIndex), "*", "") & "}"
                szTemplate = Replace(szTemplate, token, a(rowIndex, colIndex))
                
                If a(1, colIndex) = "OS Drive(GB)" Then
                
                    Set_Root_Block_Device szTemplate, CStr(a(rowIndex, colIndex))
                    
                End If
                
                If a(1, colIndex) = "Aux Drives (GB)" Then
                    
                    Add_EBS_Block_Devices szTemplate, CStr(a(rowIndex, colIndex))

                End If
                                
            Next
            
            szOutPath = fso.BuildPath(szRoot, "row-" & rowIndex & ".tf")
            fso.OpenTextFile(szOutPath, ForWriting, True).Write (szTemplate)
        End If
    Next
         
    
End Sub
Function GetRange() As Variant
    Dim xTxt As String
    Dim xRg As Range
    Dim a As Variant
    
    If ActiveWindow.RangeSelection.Count > 1 Then
      xTxt = ActiveWindow.RangeSelection.AddressLocal
    Else
      xTxt = ActiveSheet.UsedRange.AddressLocal
    End If
    Set xRg = Nothing
    Set xRg = Application.InputBox("Please select the data range:", "Terraform for Excel", xTxt, , , , , 8)
    If xRg Is Nothing Then End
    
    GetRange = xRg.Value2
    
    
End Function
Sub Set_Root_Block_Device(ByRef szTemplate As String, cellData As String)
    
    Dim a As Variant
    Dim volumeType As String

    a = Split(cellData, ",")
    
    Select Case Trim(a(0))
        Case "SSD"
            volumeType = "gp2"
        Case "PSSD"
            volumeType = "io1"
        Case "HDD"
            volumeType = "st1"
    End Select
    
    
    szTemplate = Replace(szTemplate, "{rootVolumeType}", volumeType)
    szTemplate = Replace(szTemplate, "{rootVolumeSize}", Trim(a(1)))
                    
End Sub
Sub Add_EBS_Block_Devices(ByRef szTemplate As String, cellData As String)
        ' ebs_block_device{
        '   device_name = "xvdb"
        '   volume_type = "{rootVolumeType}"
        '   volume_size = "{rootVolumeSize}"
        '   iops                  = "{iops}" #(Optional) The amount of provisioned IOPS. This must be set with a volume_type of "io1/io2".
        '   delete_on_termination = True
        '   # encrypted = false
        '   # kms_key_id = false
        ' }
        Dim auxdrives As Variant
        Dim auxdrive As Variant
        Dim volumeType As String
        Dim volumeSize As String
        Dim ebs As String
        Dim iops As String
        Dim i As Integer
        
        cellData = Replace(cellData, "-", "")
        auxdrives = Split(cellData, Chr(10))
        If UBound(auxdrives) >= 0 Then
        
            For i = 0 To UBound(auxdrives)
                auxdrive = Split(auxdrives(i), ",")
                Select Case Trim(auxdrive(0))
                    Case "SSD"
                        volumeType = "gp2"
                       iops = ""
                   Case "PSSD"
                        volumeType = "io1"
                        iops = "25000"
                   Case "HDD"
                        volumeType = "st1"
                       iops = ""
                End Select
            
                volumeSize = Trim(auxdrive(1))

                      ebs = "ebs_block_device {" + vbCrLf
                ebs = ebs + "    device_name = ""xvd" + Chr(98 + i) + """" + vbCrLf
                ebs = ebs + "    volume_type = """ + volumeType + """" + vbCrLf
                ebs = ebs + "    volume_size = """ + volumeSize + """" + vbCrLf
                If Len(iops) > 0 Then
                    ebs = ebs + "    iops        = """ + iops + """" + vbCrLf '(Optional) The amount of provisioned IOPS. This must be set with a volume_type of "io1/io2".
                End If
                ebs = ebs + "    delete_on_termination = true" + vbCrLf
                ebs = ebs + "    # encrypted = false" + vbCrLf
                ebs = ebs + "    # kms_key_id = false" + vbCrLf
                ebs = ebs + vbTab + "}" + vbCrLf
                
                szTemplate = Replace(szTemplate, "tags", ebs + vbCrLf + vbTab + "tags")
            Next

            
        End If

End Sub
