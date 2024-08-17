
# BASE DE CONHECIMENTO 

## MY DOC

========================================================================================
> Documentação Dax 
>[https://learn.microsoft.com/pt-br/dax/]
>[https://dax.guide/]

> Documentação M
>[https://learn.microsoft.com/pt-br/dax/]
>[https://dax.guide/]

> Pesquisar em outro momento
> link [https://learn.microsoft.com/pt-br/power-bi/transform-model/calculation-groups]
>[https://learn.microsoft.com/pt-br/dax/dax-queries]
>NATURALINNERJOIN = [https://learn.microsoft.com/pt-br/dax/naturalinnerjoin-function-dax]
========================================================================================

========================================================================================

## FÓRMULA DAX 

### Contexto em fórmulas DAX
> Link
> Power Query M formula language [https://learn.microsoft.com/en-us/powerquery-m/]
> Videos: [https://www.youtube.com/watch?v=RrMq8t6Gy8Q&list=PLVt5okzyYGy-Pa_lXf3uSrW_PJ9_FElC7&index=93&t=3846s]
> Artigos : [https://support.microsoft.com/pt-br/office/contexto-em-f%C3%B3rmulas-dax-2728fae0-8309-45b6-9d32-1d600440a7ad#]

#### Função Related 
> Link Artigos Função Related : [https://dax.guide/related/]

> Cmd 
> Função Related 


=======================================================================================

### Dax View 
> link
> videos: [https://www.youtube.com/watch?v=m62xSc9w1-8]
> videos: [https://www.youtube.com/watch?v=oPGGYLKhTOA] 
> DAX query view: [https://powerbi.microsoft.com/en-us/blog/dax-query-view-introduces-new-info-dax-functions/]
> Work with DAX query view: [https://learn.microsoft.com/en-us/power-bi/transform-model/dax-query-view]
> Deep dive into DAX query : [https://powerbi.microsoft.com/en-us/blog/deep-dive-into-dax-query-view-and-writing-dax-queries/]



=========================================================================================================

## Fórmulas M

### Linguagem M 

#### CMD
> link
> videos: [https://www.youtube.com/watch?v=RrMq8t6Gy8Q&list=PLVt5okzyYGy-Pa_lXf3uSrW_PJ9_FElC7&index=93&t=3846s]
> artigos : [https://support.microsoft.com/pt-br/office/contexto-em-f%C3%B3rmulas-dax-2728fae0-8309-45b6-9d32-1d600440a7ad#]

> Cmd 

> linguagem M
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

> links
[https://learn.microsoft.com/pt-br/powerquery-m/m-spec-introduction]

[https://learn.microsoft.com/pt-br/powerquery-m/]

[https://learn.microsoft.com/pt-br/powerquery-m/understanding-power-query-m-functions]

> Combinar dados [https://learn.microsoft.com/pt-br/power-bi/transform-model/desktop-combine-binaries]


> videos [https://learn.microsoft.com/pt-br/training/modules/automate-data-cleaning-power-query/1-introduction]

***************************************************
> cmd 

let  
    AddOne = (x as number) as number => x + 1,  
    //additional expression steps  
    CalcAddOne = AddOne(5)  
in  
    CalcAddOne
***************************************************
Cmd Let
> [https://learn.microsoft.com/pt-br/powerquery-m/expressions-values-and-let-expression#tableIndex]
> = Text.Proper(" Vamos fazer a consulta M ")

Record = dicionario do python

> Record Um Registro é um conjunto de campos. 
> Um campo é um par de nome/valor em que o nome é um valor de texto exclusivo dentro do registro do campo. 
> A sintaxe para valores de registro permite que os nomes sejam gravados sem aspas, uma forma também conhecida como identificadores. Um identificador pode ter as duas formas a seguir:

let Source =
    [
          OrderID = 1,
          CustomerID = 1,
          Item = "Fishing rod",
          Price = 100.00
    ]
in 
   Source[Item] //equals "Fishing rod"

chamada com o colchetes 

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Lista
Uma lista é uma => {"sequência ordenada"}
com base em zero de valores entre chaves { }. 
As chave { } também são usadas para recuperar um item de uma lista por posição de índice. 
Confira [List value](#_List_value).

> {{1, 2, 3},{4, 5, 6}}{0}{1} 

=  {
     {1, 2, 3},
     {4, 5, 6}
   } {1}{1} 

result = 5 

Tabela
Uma Tabela é um conjunto de valores organizados em colunas e linhas nomeadas. O tipo de coluna pode ser implícito ou explícito. Você pode usar #table para criar uma lista de nomes de coluna e lista de linhas. Uma Tabela de valores é uma Lista em uma Lista. Os caracteres de chave {} também são usados para recuperar uma linha de uma Tabela por posição de índice

let
    Source = #table(
    type table [OrderID = number, CustomerID = number, Item = text, Price = number],
        {
              {1, 1, "Fishing rod", 100.00},
              {2, 1, "1 lb. worms", 5.00}
         }
    )
in
    Source{1}

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



> estruturados adicionais

let
    Source =
{
   1,
   "Bob",
   DateTime.ToText(DateTime.LocalNow(), "yyyy-MM-dd"),
   [OrderID = 1, CustomerID = 1, Item = "Fishing rod", Price = 100.0]
}
in
    Source


= Excel.Workbook(File.Contents("C:\Capco\Squad Analytics\Doc\Learning\Power BI\Power Query\All_PowerQuery_Files\PQ\S03\InvoiceData.xlsx"), null, true)
[[Data]] {1}    

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


> link [https://learn.microsoft.com/pt-br/powerquery-m/m-spec-introduction]

"A" & "BC"              // text concatenation: "ABC" 
{1} & {2, 3}            // list concatenation: {1, 2, 3} 
[ a = 1 ] & [ b = 2 ]   // record merge: [ a = 1, b = 2 ]

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

let 
    Sales2007 =  
        [  
            Year = 2007,  
            FirstHalf = 1000,  
            SecondHalf = 1100, 
            Total = FirstHalf + SecondHalf // 2100 
        ], 
    Sales2008 =  
        [  
            Year = 2008,  
            FirstHalf = 1200,  
            SecondHalf = 1300, 
            Total = FirstHalf + SecondHalf // 2500 
        ] 
  in Sales2007[Total] + Sales2008[Total] // 4600


> lisk [https://learn.microsoft.com/pt-br/powerquery-m/table-fromrecords]

let
    Consulta2 = [ 
    Sales =  
        {  
            [  
                Year = 2007,  
                FirstHalf = 1000,  
                SecondHalf = 1100, 
                Total = FirstHalf + SecondHalf // 2100 
            ], 
            [  
                Year = 2008,  
                FirstHalf = 1200,  
                SecondHalf = 1300, 
                Total = FirstHalf + SecondHalf // 2500 
            ]  
        }, 
    TotalSales = Sales{0}[Total] + Sales{1}[Total] // 4600 
]
in
    Consulta2
    
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

if 2 > 1 then
    2 + 2
else  
    1 + 1

> try : 

let Sales = 
    [ 
        Revenue = 2000, 
        Units = 1000, 
        UnitPrice = if Units = 0 then error "No Units"
                    else Revenue / Units 
    ], 
    UnitPrice = try Number.ToText(Sales[UnitPrice])
in "Unit Price: " & 
    (if UnitPrice[HasError] then UnitPrice[Error][Message]
    else UnitPrice[Value])

 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   

 > link [https://learn.microsoft.com/pt-br/powerquery-m/m-spec-consolidated-grammar]
 [https://learn.microsoft.com/pt-br/powerquery-m/table-profile]


 > Table.SelectColumns
 > link [https://learn.microsoft.com/pt-br/powerquery-m/table-selectcolumns?source=recommendations]
> [https://learn.microsoft.com/pt-br/powerquery-m/understanding-power-query-m-functions?source=recommendations]
 

 > comentario [https://learn.microsoft.com/pt-br/powerquery-m/comments]

 > Fução de tabela

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

> link [https://learn.microsoft.com/pt-br/powerquery-m/power-query-m-function-reference]


> Table.ApproximateRowCount	 - Retorna o número de linhas aproximado na tabela.
> Table.ColumnCount	         - Retorna o número de colunas em uma tabela.
> Table.IsEmpty	             - Retornará true se a tabela não contiver nenhuma linha.
> Table.Profile	             - Retorna um perfil das colunas de uma tabela.
> Table.RowCount	         - Retorna o número de linhas em uma tabela.
> Table.Schema	             - Retorna uma tabela contendo uma descrição das colunas (ou seja, o esquema) da tabela  especificada.
> Tables.GetRelationships	 - Retorna os relacionamentos entre um conjunto de tabelas.

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

> link [https://learn.microsoft.com/pt-br/powerquery-m/comments]


let
    TableAddColumn = Table.AddColumn(
    Table.FromRecords({
        [OrderID = 1, CustomerID = 1, Item = "Fishing rod", Price = 100.0, Shipping = 10.00],
        [OrderID = 2, CustomerID = 1, Item = "1 lb. worms", Price = 5.0, Shipping = 15.00],
        [OrderID = 3, CustomerID = 2, Item = "Fishing net", Price = 25.0, Shipping = 10.00]
    }),
    "TotalPrice",
    each [Price] + [Shipping],
    type number

),
    #"Personalização Adicionada02" = Table.AddColumn(TableAddColumn, "Perso", each [TotalPrice] + 1),
    #"Personalização Adicionada" = Table.AddColumn(#"Personalização Adicionada02", "test", each [Perso] + 2),
    #"Personalização Adicionada1" = Table.AddColumn(#"Personalização Adicionada", "test02", each [TotalPrice] +3)
in
    #"Personalização Adicionada1"


>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

tabelas

> link [https://learn.microsoft.com/pt-br/powerquery-m/sharptable?source=recommendations#about]

> #table({}, {})
> #table(null, {{"Betty", 90.3}, {"Carl", 89.5}})
> #table(2, {{"Betty", 90.3}, {"Carl", 89.5}})
> #table({"Name", "Score"}, {{"Betty", 90.3}, {"Carl", 89.5}})
> #table(type table [Name = text, Score = number], {{"Betty", 90.3}, {"Carl", 89.5}})


Documetação
> [https://learn.microsoft.com/pt-br/power-query/]

> Teclade atalho
>link [https://learn.microsoft.com/pt-br/power-query/keyboard-shortcuts#query-editor]


