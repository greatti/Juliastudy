using BenchmarkTools
using DataFrames
using DelimitedFiles
using CSV
using XLSX
using Downloads
using JLD
using NPZ
using RData
using MAT
using RCall

#Vamos usar o arquivo CSV "programming_languages.csv" contido em C:\Users\USER\Desktop\DataScience

P,H = readdlm("C:/Users/USER/Desktop/DataScience/programming_languages.csv", ','; header=true) 
#vamos ler o csv, separando os dados por virgula e ativar o titulo
print(P) #data
print(H) #header

#Podemos também ler o arquivo CSV usando a biblioteca CSV
df = CSV.read("C:/Users/USER/Desktop/DataScience/programming_languages.csv", DataFrame)
typeof(df) #Veja que o tipo da nossa variável agora é DataFrame
println(df[1:10,:]) #Estamos plotando da linha 1 à 10 e todas as Colunas
println(df.year) #plotando apenas a coluna de anos
println(df.language) #plotando apenas a coluna de linguagens
println(names(df)) #plota os nomes das colunas do DataFrame
println(describe(df)) #Nos da uma breve ideia de como é o DataFrame

#= 
Em termos de velocidade de código, CSV Package é bem mais rapido do que o READDLM, então é bom dar prioridade
ao CSV 
Se temos um arquivo com Missing Values ou Colunas sem nada ou Linhas sem nada, a biblioteca ideal para se usar
será a XLSX, pois quando ela encontra um valor faltando ela, de qualquer forma, vai olhar além e ver se existe 
algo ainda depois
=#

#Aqui temos uma função para ler EXCEL q é muito boa se voce sabe o range que voce quer olhar
matrix_xlsx = XLSX.readdata("C:/Users/USER/Desktop/DataScience/data/zillow_data_download_april2020.xlsx", #path
 "Sale_counts_city", #what is the sheet of the excel file
 "A1:F9") #range 

#Se voce não sabe o range, então o melhor a se usar é: 
matrix_xlsx_1 = XLSX.readtable("C:/Users/USER/Desktop/DataScience/data/zillow_data_download_april2020.xlsx", 
"Sale_counts_city")

matrix_xlsx_1[1] #data
matrix_xlsx_1[2] #header
matrix_xlsx_1[1][1][1:10] #Os primeiros 10 dados da primeira coluna
matrix_xlsx_1[2][1:10] #Os primeiros 10 titulos 

#A nossa variável em XLSX atualmente é uma MATRIZ, mas podemos transforma-la em um dataframe: 
df_xlsx_1 = DataFrame(matrix_xlsx_1...)
println(df_xlsx_1)

#Podemos obter um pequeno resumo desse DataFrame que foi criado: 
combine(groupby(df_xlsx_1,:StateName), size) #Essa linha irá juntar nosso dataframe a partir dos nomes dos estados, e, pela função 'combine' 

comidas = ["maçã", "pepino", "tomate","banana"]
calorias = [105,47,22,105]
preço = [0.85, 1.6, 0.8, 0.6]
df_cal = DataFrame(item=comidas,calorias=calorias)
df_preço = DataFrame(item=comidas,preço=preço)

DF = innerjoin(df_cal,df_preço, on = :item) #Fizemos uma Junção de Intersecção a partir dos "items" adicionado a df_cal tudo aquilo que estava em df_preço, sem repetir


#= HOW TO IMPORT DATA FROM YOUR COMPUTER=#

#Vamos importar dados em JLD NPZ R and MATLAB
jld_data = JLD.load("C:/Users/USER/Desktop/DataScience/data/mytempdata.jld")
npz_data = npzread("C:/Users/USER/Desktop/DataScience/data/mytempdata.npz")
R_data = RData.load("C:/Users/USER/Desktop/DataScience/data/mytempdata.rda")
Matlab_data = matread("C:/Users/USER/Desktop/DataScience/data/mytempdata.mat")

#Vamos salvar dados em JLD NPZ R and MATLAB
save("C:/Users/USER/Desktop/DataScience/data/mywrite.jld", "A", jld_data) #Estamos fazendo um arquivo de dados JLD igual ao jld_data
npzwrite("C:/Users/USER/Desktop/DataScience/data/mywrite.npz", npz_data)
matwrite("C:/Users/USER/Desktop/DataScience/data/mywrite.mat", Matlab_data)


### VAMOS CRIAR ALGUMAS FUNÇÕES PARA BRINCAR COM MATRIZES ###


typeof(P)
function yc(P, language::String) #vamos criar uma função para descobrir o ano que foi criada certa linguagem na matriz P, e determinamos que a entrada sera uma String
    loc = findfirst(P[:,2] .== language) #Vamos procurar pela primeira vez que a linguagem vai aparecer na segunda coluna 
    return P[loc,1] #retornar o valor que estiver na coluna de Ano na localização encontrada por loc
end

yc(P,"Julia")


function yce(P, language::String)
    loc = findfirst(P[:,2] .== language) #todas as linhas na segunda coluna
    !isnothing(loc) && return P[loc,1] #Se language existir em algum lugar, vai retornar o ano, se não vai retornar um erro ISSO É TIPO UM IF/ELSE
    error("Error : Language not found")
end
yce(P, "Python")
yce(P, "W")


function how_many(P, year::Int64) #seu parametro será um Inteiro e ele vai procurar nessa matriz P
    year_count = length(findall(P[:,1] .== year)) #vai armazenar na variável year_count o numero devezes que encontrou uma linguagem criada em certo ano, todas as Linhas
    #na primeira coluna
    return year_count 
end

how_many(P,2011)


### AGORA VAMOS TRABALHAR COM AS MESMAS FUNÇÕES POREM COM DATAFRAMES ###


#Nesse caso ja temos nosso dataframe df 
println(df) #para verificar

function year_df(df, language::String) #Estamos definindo uma função para descobrir o ano de certa linguagem no dataframe df 
    loc = findfirst(df.language .== language) #A linguagem que quisermos será procurada na coluna de linguagens 
    return df.year[loc] #e retornar o ano daquela linguagem  específica 
end 
year_df(df,"R") 
year_df(df,"w") #Não existe 

function year_df_error(df, language::String)
    loc = findfirst(df.language .== language)
    !isnothing(loc) && return df.year[loc]
    error("Error: n existe bocó ")
end 

year_df_error(df,"Julia") 
year_df_error(df,"w") #Não existe 

function num_year(df, year::Int64)
    year_count = length(findall(df.year .== year)) #contar quantos 'year' existem na coluna de anos do dataframe
    return year_count 
end 

num_year(df, 2012)


### AGORA VAMOS TRABALHAR COM DICIONARIOS ###

A = Dict([("A", 1), ("B", 2)]) #As keys são Strings e os values são Integers
B = Dict("A" => 1, "B" => 2) #Outro jeito

A_1 = Dict([("A", 1), ("B", 2), ("J", [1,2])]) #Agora ao invés de um dos values ser Int, será um Vector 

#Vamos começar a declarar um novo DICIONÁRIO 
P_Dict = Dict{Integer, Vector{String}}() #Estamos definindo que nosso P_Dict somente aceitará como key, inteiros e como value, vetores de string 
P_Dict[01] = ["julia", "2020"] #Por ser mutável, estamos adicionando um elemento 
println(P_Dict)
#Mas se tentarmos fugir dessa regra pre estabelecida, ele não vai deixar
P_Dict["um"] = ["python", "2018"] #Porque tentamos adicionar uma key String, quando deveriamos adicionar uma Key Int


#Vamos fazer uma função para POPULAR esse dicionário com as linguagens e os anos que foram criadas (usando a matrix P)
dict = Dict{Integer, Vector{String}}() 
for i = 1:size(P,1)
    year,lang = P[i,:]
    if year in keys(dict)
        dict[year] = push!(dict[year],lang)
    else
        dict[year] = [lang]
    end
end
println(dict)

#vamos criar a função pro dicionário agora

dict
function year_created(dict, language::String)
    keys_vec = collect(keys(dict))
    lookup = map(keyid -> findfirst(dict[keyid] .== language), keys_vec)
    return keys_vec[findfirst((!isnothing).(lookup))]
end

year_created(dict, "Julia")

#Para descobrir quantas linguagens foram desenvolvidas em certo ano, em DICT isso é muito simples
#Basta usarmos a função do dataframe 
num_year(dict, year::Int64) = length(dict[year])
num_year(dict,2011)

#Vamos supor agora um Missing Value 
df
#vamos adicionar um missing value
P[1,1] = missing 
P_df = DataFrame(year = P[:,1], language = P[:2])
P_df
P_df = dropmissing(P_df) #atualizamos P_df
P_df