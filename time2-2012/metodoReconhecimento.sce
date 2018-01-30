//programa q retorna a id da pessoa mais proxima da imagem teste
//utilizando sistema Ax=b onde A eh a base de imagens da pessoa e b eh a nova imagem

//***********************ajustes************************
//usar pca para obter base de dados com informacoes mais importantes
//usar_pca = %f;
//numero de autovalores
//n_compress = 7; 

//img teste
//imgteste = ts(5);
//imgteste = is(3)(5); //teste usando imagem do banco

//******************************************************

if usar_pca then
    atil = list();
    for p=1:n_pessoas
       [u,s] = sva(AA(p),n_compress);
       atil(p) = u*s;
       clear u; clear s;
    end
end

A = list();
if usar_pca then
   A = atil;
   clear atil;
else
   A = AA;
end

//transformando imagem teste em coluna
imgteste = imgteste(:);

//resolvendo o sistema Ax=b para cada pessoa
x = list();
for p = 1:n_pessoas
    x(p) = A(p)\imgteste;
end

//a aproximacao eh a projecao da imagem teste...
//...no plano das imagens da pessoa i
aproximacao = list();
for p = 1:n_pessoas
    aproximacao(p) = A(p)*x(p);
end

//distancia entre a imagem teste e a aproximacao
for p = 1:n_pessoas
    d(p) = norm(aproximacao(p)-imgteste);
end

//obtendo distancia minima d_min e id da d_min
//o i_min eh o id da pessoa que o metodo reconheceu
[d_min i_min]=min(d);

//obtendo a img aproximada
img_aprox = list();
for p = 1:n_pessoas
    img_aprox(p) = (matrix(aproximacao(p),100,100));
end

//plotando imagem aproximada
//    for p = 1:n_pessoas
//        imshow(img_aprox(p),[]);
//    end

//as distancias estao proximas?
//obtendo vetor das distancias ordenado
dn=gsort(d,'g','i');

//obtendo subtracao das menores distancias
sub=dn(2)-dn(1);

//saida do algoritmo
disp('******Saida do metodo.******');
disp(i_min,'Pessoa');

//teste
//se a imgteste estiver proxima de 2 pessoas exibe quem sao
if sub < 0.1*dn(1)
    disp('*Nao ha certeza.*');
    for i=1:n_pessoas
        if d(i)==dn(2) then
            disp(i_min,'e da pessoa',i,'A imagem esta proxima da pessoa');
        end
    end
else if dn(1) < 0.01 then
        disp('A imagem teste pertence ao banco.');
   end
end
