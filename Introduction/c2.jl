#= Vamos explorar agora TUPLAS, DICIONARIOS e ARRAYS

Tuplas e Arrays são sequencias ORDENADAS de elementos, então podemos INDEXA-LAS
Dicionários e Arrays são MUTÁVEIS

=#

#= TUPLAS =# 
top_animais = ("cachorro", "gato", "chinchila") # É UMA TUPLA 
top_animais[2] #Como é uma TUPLA, é INDEXADO, logo podemos pegar um elemento específico 

#Porém, como uma TUPLA É IMUTÁVEL, não podemos altera-la 

top_animais[2] = "penguim" 


#= NAMEDTUPLES =#

top_materias = (exatas = "física", humanas = "historia", biológicas = "bio") #É uma TUPLA porém cada elemento tem um index específico
top_materias[1] #Ela continua ORDENADA, porque é uma TUPLA
top_materias.exatas #A diferençã é que também podemos acessar cada valor por seu index específico

#= DICTIONARIES 
Assim como a tupla é criada por () um dicionário é criado por Dict(), que é composto por keys e values associados =#

amores = Dict("pai" => "Kelber", "mae" => "Ligia", "mo" => "Grazi")
amores["pai"]
#E como o dicionário é mutável então podemos adicionar mais elementos
amores["pet"] = "Luna"
println(amores)
#podemos também deletar um elemento de um dicionário
pop!(amores, "pai")
println(amores)

#Dicionários NAO SÃO INDEXADOS e por isso não podemos acessar os elementos pelos seus indexes, apenas pelas suas keys
amores[1]

#= ARRAYS 
Arrays são MUTÁVEIS como DICIONÁRIOS e são ORDENADAS como TUPLAS a partir da seguinte sintaxe =# 

myfriends = ["Grazi", "Laurasia", "Mendes", "Mataruco"] #O tipo de um array é Vector, nesse caso é um vetor 1d
random = [1,1,2,3, "Grazi", "Brenin"] #Um array do tipo Vector com elementos do tipo Any, ou seja, variados

#Assim como em Tuplas podemos pegar um elemento de um index específico: 
myfriends[2]
#E também podemos usar o seu index para modificar o Array, assim como em Dicionários
myfriends[2] = "Diniz"

#DIFERENTE DE PYTHON, OS INDEXES EM JULIA COMEÇAM EM 1 E NÃO EM 0, ISSO SIGNIFICA QUE ELA É UMA LINGUAGEM 1-BASED
#Também podemos editar um Array com push! e pop! assim como em Dicionários

push!(myfriends, "Medeirox") #ADICIONA O ELEMENTO AO ULTIMO INDEX DO ARRAY
pop!(myfriends) #REMOVE O ULTIMO ELEMENTO DO ARRAY

#ARRAYS OF ARRAYS 
matrix = [[1, 8, 9], 
[9, 11, 14], 
[9, 12, 2]] #É um ARRAY com 3 elementos, em que cada elemento é mais um ARRAY com 3 elementos cada
typeof(matrix)

#Como criar um array de números aleatórios? 
rand(4,4)
#E como criar mais de um array com números aleatórios?
rand(4,4,3) #Foram criados 3 ARRAYS 4x4 

#= COMO COPIAR ARRAYS

Aqui devemos tomar cuidado, pois diferente de python não basta criar uma cópia de forma "simples", devemos usar uma função para isso, veja: =#

eu = ["legal", "top", "show"]
eu2 = eu #"Copiamos o ARRAY_EU para o ARRAY_EU2
eu2[1] = "chatinho"
println(eu2)
println(eu) #Veja que ao modificar eu2 acabamos também modificando eu, isso porque ambos se tornaram linkados na linha 71 

eu_original = ["legal", "top", "show"]
eu_copia = copy(eu_original) #Agora sim criamos uma copia não linkada 
eu_copia[1] = "uhum"
println(eu_original)
println(eu_copia)


#= DICIONÁRIOS SÃO UM TANTO QUANTO CONFUSOS

Se as keys e values são todas de um tipo só, ela apenas vai reconhecer aquele tipo, e, portanto, voce nao poderá 
adicionar keys ou values de outro tipo =#

phones = Dict("Grazi" => "900", "Laurasia" => "901", "Mendes" => "902")
#vamos tentar agora adicionar um novo elemento com um valor INT ao inves de STRING
phones["Mataruco"] = 903 #Não deu certo
phones["Mataruco"] = "903" #Deu certo 

phones2 = Dict("Grazi" => 900, "Laurasia" => "901")
phones2["Diniz"] = 902 #Deu certo
phones2["Bea30"] = "903" #Deu certo

#Isso aconteceu porque agora tinhamos tipos variados de Keys e Values no nosso Dicionários
