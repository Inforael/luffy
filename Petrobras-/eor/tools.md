# Lista de Como Power Apps
-----------------------------------------------------

# Cmd comando para listar foto na galeria

UsuáriosdoOffice365.UserPhotoV2(ThisItem.NOME.Email)

-----------------------------------------------------

# Cmd criação de Variavel 

UpdateContext({poupsalcad: false})

------------------------------------------------------

# Cmd para ajustar objetos no container 

(Parent.Width - Self.Width )/2
-------------------------------------------------------
(Parent.Height - Self.Height )/2

------------------------------------------------------

SubmitForm(fm_alteracao01);;NewForm(fm_alteracao01);;UpdateContext({poupsalcad: false})

Search(
    bd_lista_eor_v2;
    cxbusca.Text;
    "GERENCIADAEOR"
    
)

Filter(
    'Ações - Mandala SMS - Poços';
    'ID Iniciativa' = galListaIniciativaTCA.Selected.ID
)

https://learn.microsoft.com/pt-br/power-platform/power-fx/reference/function-remove-removeif

UsuáriosdoOffice365.MyProfile().Mail

# --------------------------------------------------------
Cmd if

if ( 
    value(txtnumero.text) < 80; 
     color.Yellow;

    value(txtnumero.text) < 40; 
     color.Red;
   
    color.Green
)

