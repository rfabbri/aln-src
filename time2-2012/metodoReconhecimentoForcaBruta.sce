//metodo de reconhecimento baseado na distancia da img teste para a...
//...minima distancia de cada pessoa

//***********************ajustes************************
//img teste
//imgteste = ts(1);
//imgteste = is(2)(9);

//******************************************************

//calculando distancia para cada pessoa
//dist(p)(i)=distancia da imgteste para a img i da pessoa p
    dist = list();
    for p=1:n_pessoas
        dist(p) = list();
        for i=1:n_imgs_por_pessoa
          dist(p)(i) = norm(imgteste-is(p)(i));
        end
    end
    
//calculando min das distancias para cada pessoa
    for p=1:n_pessoas
        d(p) = min(dist(p));
    end

//calculando a min distancia entre as pessoas
[d_min i_min] = min(d);

//as distancias estao proximas?
//obtendo vetor das distancias ordenado
dn=gsort(d,'g','i');

//obtendo subtracao das menores distancias
subfb=dn(2)-dn(1);

//saida do algoritmo
disp('******Saida do algoritmo.******');
disp(i_min,'Pessoa');

//teste
//se a imgteste estiver proxima de 2 pessoas exibe quem sao
if subfb < 0.1*dn(1)
    disp('*Nao ha certeza.*');
    for i=1:n_pessoas
        if d(i)==dn(2) then
            disp(i_min,'e da pessoa',i,'A imagem esta proxima da pessoa');
        end
    end
else if dn(1) < 0.01 then
        disp('A imagem teste pertence ao banco.')
    end
end
