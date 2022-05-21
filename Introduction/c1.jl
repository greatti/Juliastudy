println("im excited to learn Julia!") #thats how you print things in Julia hehe

variable = 42 #thats how you assign a value to a variable, you just need a name and a value
println(variable, typeof(variable)) #thats how you evaluate the type of ur variable

#= 
for multiple comment lines
we can use this 
=#

a = 10^2 #potencia
b = 101%2 #resto
c = 101/10 #divisao total

days = 365 
days_f = float(days)
days_s = string(days)

s1 = "im a string." #thats how you define a string
typeof(s1)

s2 = 'a' 
typeof(s2) #notice that this is not a string, there is a diference between '' and "", the first one defines a String and the second one defines a Char

#= INTERPOLATING STRINGS =# 

name = "Grazi"
pets_grazi = 4
pets_brenno = 1

println("Oi, meu nome é $name e eu tenho $pets_grazi pets e o Brenin tem $pets_brenno pet, juntos a gnt tem $(pets_brenno + pets_grazi) pets hehe")

#Perceba que conseguimos concatenar de uma forma muito fácil variáveis Str com Int usando simplesmente o comando $

s3 = "Oie meu nome é "
s4 = "Grazi"

string(s3, s4) #É um jeito de concatenar strings
string("Oie meu nome é ", name) #Outro jeito de concatenar
s3*s4 #MULTIPLICAR STRINGS? SIMMMM

#= REPEAT FUNCTION =#

long = repeat("Grazi ", 10) #É uma função capaz de repetir sua string quantas vezes voce quiser
