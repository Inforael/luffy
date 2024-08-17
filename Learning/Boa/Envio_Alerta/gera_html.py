# -*- coding: utf-8 -*-

def gera_html_log(dados_json, thead_html):

    texto_email    = ''
    status_error   = ''
    status_warning = ''
    status_sucess  = ''
    
    texto_email += '''<!DOCTYPE html>
    <html>
        <head>
        </head>
        <body class="body" style="padding:0 !important; margin:0 !important; display:block !important; min-width:100% !important; width:100% !important; background:#999999; -webkit-text-size-adjust:none;">
        <center>
        <br>       
        <div>        
            <table width="50%" border="0" cellspacing="0" cellpadding="0"  >
                  <tr>
                    <td style="color:#ffffff; font-family:'Arial'; font-size:30px;  text-align:center; padding-bottom:25px;  padding-top:25px;" bgcolor="#e86826">
                        '''  +  thead_html + '''  
                    </td>
                </tr>
                <tr>
                    <td border="0" style="color:#ffffff; font-size:25px;  text-align:center; padding-bottom:20px;" bgcolor="#ffffff">
                    </td>
                </tr>
                <tr>
                    <td align="center" style=" padding-bottom:50px;" bgcolor="#ffffff">
    '''

    for a in dados_json:
        if dados_json[a]["Status"] == "Failed":
            status = "#FF6347" 
            
            status_error += '''                 
                        <table margin="50px"  width="90%" style = "border:1px solid gray;" cellspacing="1" cellpadding="5"> 
                            <tr>
                                <th style=" font-family:'Arial'; color:#black; font-size:20px; text-align:center; padding-bottom:10px; padding-top:10px;" bgcolor="#C0C0C0" colspan="2"> 
                                    ''' + str(a) + '''
                                </th > 
                            </tr> 
                            <tr bgcolor="''' + status + '''">
                                <td style=" font-family:'Arial'; color:#black; font-size:15px; text-align:center; padding:10px; line-height:20px;" colspan="2">
                                    Failed 
                                </td>
                            </tr>
            ''' 
            for k,v in dados_json[a].items():   
                status_error +='''   
                                <tr bgcolor="#ffffff" border = "0" > 
                                    <td  style="color:#666666; font-family:'Arial'; font-size:18px; line-height:24px; text-align:left; ">
                                        ''' + k + ''' 
                                    </td>
                                    <td  style="color:#666666;  font-size:18px; line-height:24px; text-align:right; padding-right:50px;">
                                        ''' + str(v) + ''' 
                                    </td>
                                </tr>
                ''' 
            status_error += '''  
                            </table> 
                            <br>         
            '''           
        elif dados_json[a]["Status"] == "Unknown":
            status = "#F0E68C"

            status_warning += '''                 
                            <table margin="50px"  width="90%" style = "border:1px solid gray;" cellspacing="1" cellpadding="5"> 
                                <tr>
                                    <th style=" font-family:'Arial'; color:#black; font-size:20px; text-align:center; padding-bottom:10px; padding-top:10px;" bgcolor="#C0C0C0" colspan="2"> 
                                        ''' + str(a) + '''
                                    </th > 
                                </tr> 
                                <tr bgcolor="''' + status + '''">
                                    <td style=" font-family:'Arial'; color:#black; font-size:15px; text-align:center; padding:10px; line-height:20px;" colspan="2">
                                        Unknown 
                                    </td>
                                </tr>
                ''' 
            for k,v in dados_json[a].items():   
                status_warning +='''   
                                    <tr bgcolor="#ffffff" border = "0" > 
                                        <td  style="color:#666666; font-family:'Arial'; font-size:18px; line-height:24px; text-align:left; ">
                                            ''' + k + ''' 
                                        </td>
                                        <td  style="color:#666666;  font-size:18px; line-height:24px; text-align:right; padding-right:50px;">
                                            ''' + str(v) + ''' 
                                        </td>
                                    </tr>
                    ''' 
                
            status_warning += '''  
                                </table> 
                                <br>         
                    '''       
        else: 
            status = "#00FA9A"
            
            status_sucess += '''                 
                            <table margin="50px"  width="90%" style = "border:1px solid gray;" cellspacing="1" cellpadding="5"> 
                                <tr>
                                    <th style=" font-family:'Arial'; color:#black; font-size:20px; text-align:center; padding-bottom:10px; padding-top:10px;" bgcolor="#C0C0C0" colspan="2"> 
                                        ''' + str(a) + '''
                                    </th > 
                                </tr> 
                                <tr bgcolor="''' + status + '''">
                                    <td style=" font-family:'Arial'; color:#black; font-size:15px; text-align:center; padding:10px; line-height:20px;" colspan="2">
                                        Complete 
                                    </td>
                                </tr>
                ''' 
            for k,v in dados_json[a].items():   
                status_sucess +='''   
                                    <tr bgcolor="#ffffff" border = "0" > 
                                        <td  style="color:#666666; font-family:'Arial'; font-size:18px; line-height:24px; text-align:left; ">
                                            ''' + k + ''' 
                                        </td>
                                        <td  style="color:#666666;  font-size:18px; line-height:24px; text-align:right; padding-right:50px;">
                                            ''' + str(v) + ''' 
                                        </td>
                                    </tr>
                    ''' 
            status_sucess += '''  
                                </table> 
                                <br>         
                '''        

    texto_email += status_error + status_warning + status_sucess 

    texto_email +=  '''
                        <table width="100%" border="0" bgcolor="#ffffff">
                            <tr>
                                <td style="color:#666666; font-family:'Arial'; font-size:13px; line-height:70px; text-align:center; padding-bottom:0px;" >
                                    <a style = " text-align:center">Por favor não responda esse email. Esta é uma mensagem automática.</a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br>
        </div>
        </center> 
        </body>
    </html>
    '''
    file1 = open("myfile.html","w") 
    file1.write(texto_email)
    file1.close()
    return(texto_email)