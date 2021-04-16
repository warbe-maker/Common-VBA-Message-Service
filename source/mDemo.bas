Attribute VB_Name = "mDemo"
Option Explicit

Public Sub FirstTry()
          
    Dim Message As TypeMsgText
    
    Message.Text = "Any message"
    Message.FontColor = rgbRed
    Message.FontBold = True
    
    With fMsg
        .MsgTitle = "Any title"
        .MsgButtons = vbYesNoCancel
        .MsgText(1) = Message
        .Setup
        .show
        Select Case .ReplyValue ' obtaining it unloads the form !
            Case vbYes:     MsgBox "Button ""Yes"" clicked"
            Case vbNo:      MsgBox "Button ""No"" clicked"
            Case vbCancel:  MsgBox "Button ""Cancel"" clicked"
        End Select
   End With
   
End Sub

Public Sub Demo_Dsply()

    Dim sTitle  As String
    Dim Message    As TypeMsg
    Dim cll     As New Collection
    Dim i, j    As Long
    
    With fMsg
        .MaxFormWidthPrcntgOfScreenSize = 45    ' for this demo to enforce a vertical scroll bar
        .MaxFormHeightPrcntgOfScreenSize = 75   ' for this demo to enbforce a vertical scroll bar for the message section
    End With
   
    sTitle = "Usage demo: Full featured multiple choice message"
    Message.Section(1).Label.Text = "1. Demonstration:"
    Message.Section(1).Text.Text = "Use of all 3 message sections, all with a label and use of all 7 reply buttons, in a 2-2-2-1  order."
    Message.Section(2).Label.Text = "2. Demonstration:"
    Message.Section(2).Text.Text = "The impact of the specified maximimum message form with, which for this test has been reduced to " _
                          & fMsg.MaxFormWidthPrcntgOfScreenSize & "% of the screen size (the default is 80%)." & vbLf & vbLf _
                          & "Because this message section is very tall (for this demo specifically) the total message " _
                          & "area's height exceeds the specified maximum message form height." & vbLf _
                          & "When it is reduced to its limit the whole message area is provided with a vertical scroll bar." & vbLf & vbLf & _
                            "By this, the alternative MsgBox has in fact no message size limit."
    Message.Section(3).Label.Text = "3. Demonstration:"
    Message.Section(3).Text.Text = "This part of the message demonstrates the mono-spaced option and the impact it " _
                          & "has on the width of the message form, which is determined by its longest line " _
                          & "because mono-spaced message sections are not ""word wrapped"". However, because " _
                          & "the specified maximum message form width is exceed a vertical scroll bar is applied " _
                          & "- in practice it hardly will ever happen. I.e. even for a mono-spaced text section " _
                          & "there is no width limit."
    Message.Section(4).Label.Text = "Attention!"
    Message.Section(4).Text.Text = "The result is re-displayed until the ""Ok"" button is clicked!"
   
   '~~ Prepare the buttons collection
   For j = 1 To 3
        For i = 1 To 3
            cll.Add "Multiline reply" & vbLf & "button caption" & vbLf & "Button-" & j & "-" & i
        Next i
        cll.Add vbLf
    Next j
    cll.Add "Ok"
    
    While mMsg.Dsply(dsply_title:=sTitle _
                   , dsply_msg:=Message _
                   , dsply_buttons:=cll _
                   , dsply_min_width:=600 _
                    ) <> cll(cll.Count)
    Wend
    
End Sub

Public Sub Test_Dsply()
' ---------------------------------------------------------
' Displays a message with 3 sections, each with a label and
' 7 reply buttons ordered in rows 3-3-1
' ---------------------------------------------------------
    Const B1 = "Caption Button 1"
    Const B2 = "Caption Button 2"
    Const B3 = "Caption Button 3"
    Const B4 = "Caption Button 4"
    Const B5 = "Caption Button 5"
    Const B6 = "Caption Button 6"
    Const B7 = "Caption Button 7"
    
    Dim vMsg    As TypeMsg                      ' structure of the message
    Dim cll     As New Collection                   ' specification of the displayed buttons
    Dim vReturn As Variant
           
    ' Preparing the message
    With vMsg.Section(1)
        .Label.Text = "Any label 1"
        .Text.Text = "Any section text 1"
    End With
    With vMsg.Section(2)
        .Label.Text = "Any label 2"
        .Text.Text = "Any section 2 text"
        .Text.Monospaced = True ' Just to demonstrate
    End With
    With vMsg.Section(3)
        .Label.Text = "Any label 3"
        .Text.Text = "Any section text 3"
   End With
       
   vReturn = Dsply(dsply_title:="Any title", _
                   dsply_msg:=vMsg, _
                   dsply_buttons:=mMsg.Buttons(vbAbortRetryIgnore, vbLf, B1, B2, B3, vbLf, B4, B5, B6, vbLf, B7) _
                  )
   MsgBox "Button """ & mMsg.ReplyString(vReturn) & """ had been clicked"
   
End Sub
