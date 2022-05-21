using LinearAlgebra
using SparseArrays
using Images
using MAT

A = rand(10,10) #Matriz aleatoria 10x10
B = rand(10,10)
Atranspose = A' #Atranspose será a transposta
A = A*Atranspose #Multiplicando as duas matrizes

# Como uma matriz é armazenada de forma linear na vertical, então cada elemento possui um numero e tambem uma posição: 
A[21]
A[1,3]

#Agora vamos trabalhar com vetor, não matriz
b = rand(10)
x = A\b #É a solição para a equação matricial "Ax = b" tal que o "backslash" resolve uma equação linear 

typeof(A)
typeof(b)
typeof(x)
typeof(Atranspose)nt

sizeof(A)
sizeof(Atranspose)

#LU FACTORIZATION: L*U = P*A
luA = lu(A)
luA.L #triangular inferior
luA.U #triangular superior
luA.P #alguma matriz-fator 
#this is a factorization that respects : L*U - P*A = 0
norm(luA.L*luA.U - luA.P*A) #deve ser proximo de 0 

#QR FACTORIZATION: Q*R = A
qrA = qr(A)
qrA.Q
qrA.R
norm(qrA.Q*qrA.R - A)

#Cholesky Factorization: A deve ser simétrica e positivamente definida
isposdef(A) #mas nossa A não é 
A = Symmetric(A)
isposdef(A)
cholA = cholesky(A)
norm(cholA.L*cholA.U - eigenvalue)

#FACTORIZE OF A
factorize(A) #pega a fatorização mais adequeada
#Se a matriz for hermitiana positivamente definida ele escolherá a Cholesky 

#Matriz identidade: 
I3 = I(3)
Diag = Diagonal([1,2,3])
#Perceba que o tipo dessas funções é "Diagonal" que é diferente de Matrix e Array 


#SparseArrays: 
using SparseArrays
S = sprand(5,5,2/5) #Uma matriz 5x5 com a probabilidade de 2/5 de não serem elementos nulos
S.rowval #são os elementos das linhas que são nao nulos
#E podemos transformar a type : SparseMatrixCSC em Matrix
Matrix(S)

S.nzval #os elementos que são não-nulos
S.m #o grau da matriz 




#IMAGENS: 

X1 = load("C:/Users/USER/Desktop/DataScience/data/khiam-small.jpg")

X1[1,1] #O tipo será RGB porque é um pixel!

Xgray = Gray.(X1)

#Vamos definir os layers vermelho, azul e verde 

R = map(i->X1[i].r, 1:length(X1))
R = Float64.(reshape(R,size(X1)...))

G = map(i->X1[i].g, 1:length(X1))
G = Float64.(reshape(G,size(X1)...))

B = map(i->X1[i].b, 1:length(X1))
B = Float64.(reshape(B,size(X1)...))

Z = zeros(size(R)...)
RGB.(R,Z,Z) #Pegamos a imagem e colocamos nela apenas aquele layer azul definido 

Xgrayvalues = Float64.(Xgray) #os valores da matriz cinza


#vamos pegar os top4 valores da matriz que mais aparecem na composição 
SVD_V = svd(Xgrayvalues) #vamos olhar na matriz pra procurar 

u1 = SVD_V.U[:,1]
v1 = SVD_V.V[:,1]
img1 = SVD_V.S[1]*u1*v1'

i = 2
u1 = SVD_V.U[:,i]
v1 = SVD_V.V[:,i]
img1 += SVD_V.S[i]*u1*v1'

i = 3
u1 = SVD_V.U[:,i]
v1 = SVD_V.V[:,i]
img1 += SVD_V.S[i]*u1*v1'

i = 4
u1 = SVD_V.U[:,i]
v1 = SVD_V.V[:,i]
img1 += SVD_V.S[i]*u1*v1'

Gray.(img1) #será uma aproximação para a nossa imagem


#Vamos usar i(1 -> 100) Agora
i = 1:180
u1 = SVD_V.U[:,i]
v1 = SVD_V.V[:,i]
img1 = u1*spdiagm(0=>SVD_V.S[i])*v1'
Gray.(img1)


M = matread("C:/Users/USER/Desktop/DataScience/data/face_recog_qr.mat")
#Estamos lendo dados de matlab
M.keys
q = reshape(M["V2"][:,1],192, 168)  
Gray.(q)

#como encontrar qual a imagem mais próxima dessa?
b = q[:]

A = M["V2"][:, 2:end] #estamos montando uma matriz com todos os números até o final menos a que Pegamos
x = A\b #para comparar
Gray.(reshape(A*x, 192, 168)) #e a encontramos!
norm(A*x - b) #essa é a diferença entre a nossa imagem e a mais proxima

# A*x - b = 0