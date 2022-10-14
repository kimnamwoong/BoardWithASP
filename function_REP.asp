<%
function ReplaceTag2Text(str)
   Dim text
      text = replace(str, "&", "&amp;")
      text = replace(text, "<", "&lt;")
      text = replace(text, ">", "&gt;")
      ReplaceTag2Text = text
End Function
%>