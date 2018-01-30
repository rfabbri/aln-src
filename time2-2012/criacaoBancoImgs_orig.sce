//**************************************************
//*            Algebra Linear Numerica             *
//*                    Time 2                      *
//**************************************************

SIPVIEWER='display';
stacksize(160000000);
sip_quiet;


//***********************ajustes************************
//caminho onde foi feita a extracao da pasta Reconhecimento
caminho_extracao = '/home/rfabbri/f/time2/' + '/Reconhecimento';
caminho_imgs_banco = string(caminho_extracao) + '/BaseDados';
caminho_imgs_ajustadas = string(caminho_extracao) + '/BaseDadosCortada';
caminho_imgs_teste = string(caminho_extracao) + '/Teste';

//numero de pessoas presentes no banco
n_pessoas = 5

// -----------------------------------------------------
// TODO XXX ALUNOS: MELHORAR ISTO PARA 
// SUPORTAR NUMERO DIFERENTE DE IMAGENS POR PESSOAS
// numero de imgs por pessoa 
n_imgs_por_pessoa = 9;
// -----------------------------------------------------


//usar imgs ajustadas    
usar_imgs_ajustadas=%f;
//usar metodo de subtracao da media - retira informacao comum (media) de cada img
subtrair_media = %f;
//usar metodoReconhecimentoForcaBruta
usar_forcabruta = %f;
//usar pca para obter base de dados com informacoes mais importantes
usar_pca = %t;

//******************************************************


//carregando banco de imagens
    if usar_imgs_ajustadas then
        cd(caminho_imgs_ajustadas);
    else
        cd(caminho_imgs_banco);
    end
    
    //carregando o rotulo de todas as imgs
    rotulo=ls('*.jpg');

    //ordenando rotulo
    rotulo=gsort(rotulo,'lr','i');
    
    //carregando imgs para lista is
    //carregando imgs teste para ts
    //carregando media para ms
    is = list();
    ts = list();
    ms = list();
    k=1;
    for p=1:n_pessoas
        is(p) = list();
        ms(p) = zeros(100,100); 
        for i=1:n_imgs_por_pessoa
          is(p)(i) = normal(gray_imread(rotulo(k)));
          //is(p)(i) = mogrify(is(p)(i), ['-resize', '100x100','-normalize']);
          ms(p) = ms(p) + is(p)(i);
          k=k+1;
        end
        ms(p) = normal(ms(p)/n_imgs_por_pessoa);
    end
    clear rotulo; clear k;

//carregando banco de testes
    cd (caminho_imgs_teste);
    
    //carregando o rotulo das imgs teste
    rotulo=ls('*.jpg');
    
    //ordenando rotulo
    rotulo=gsort(rotulo,'lr','i');
    for p=1:size(rotulo,1)
        ts(p) =  normal(gray_imread(rotulo(p)));
    end
    clear rotulo;
    
//subtrair a media da pessoa de cada img
    if subtrair_media then
        for p=1:n_pessoas
            for i=1:n_imgs_por_pessoa
                is(p)(i) = is(p)(i) - ms(p);
            end
        end
    else
        clear ms;
    end

//carregando lista para cada pessoa AA(p)
    AA = list();
    //carregando matriz com imagens da mesma pessoa na coluna AA(p)(:,i)
    for p=1:n_pessoas
        AA(p) = zeros(10000,n_imgs_por_pessoa);
        for i=1:n_imgs_por_pessoa
            AA(p)(:,i) = is(p)(i)(:);
        end
    end

//if (~usar_forcabruta) then
//    clear is;
//end


cd (caminho_extracao);
//exec('avaliarResultado.sce',-1);

//exec('metodoReconhecimentoForcaBruta.sci');



