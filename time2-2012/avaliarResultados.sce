//retorna matriz de eficiencia
//se o metodo retornou a pessoa certa, a m_confusao vai ser diagonal composta por 1

m_confusao = zeros(n_pessoas,n_pessoas);
//teste para imagens nao pertencentes ao banco
if usar_pca then
    eficiencia=[-1];
    for n_compress=2:n_imgs_por_pessoa
        m_confusao = zeros(n_pessoas,n_pessoas);
        if usar_imgs_ajustadas then
            for pess=1:n_pessoas
                imgteste = ts(pess+5);
                exec('metodoReconhecimento.sce',-1);
                m_confusao(pess,i_min) = m_confusao(pess,i_min) + 1;
            end
        else
            for pess=1:n_pessoas
                imgteste = ts(pess);
                exec('metodoReconhecimento.sce',-1);
                m_confusao(pess,i_min) = m_confusao(pess,i_min) + 1;
            end
        end
    
        acerto=(sum(diag(m_confusao))/n_pessoas)*100;
        
        eficiencia=[eficiencia acerto];
        clear m_confusao;
    end
    [maximo n_max]=max(eficiencia);
    disp(maximo,'a eficiencia eh=',(n_max),'Usando PCA com n=')
    eficiencia
else
    m_confusao = zeros(n_pessoas,n_pessoas);
    if usar_imgs_ajustadas then
        for pess=1:n_pessoas
            imgteste = ts(pess+5);
            if usar_forcabruta then
                exec('metodoReconhecimentoForcaBruta.sce');
            else
                exec('metodoReconhecimento.sce');
            end
            m_confusao(pess,i_min) = m_confusao(pess,i_min) + 1;
        end
    else
        for pess=1:n_pessoas
            imgteste = ts(pess);
            if usar_forcabruta then
                exec('metodoReconhecimentoForcaBruta.sce');
            else
                exec('metodoReconhecimento.sce');
            end
            m_confusao(pess,i_min) = m_confusao(pess,i_min) + 1;
        end
        
    end

    acerto=(sum(diag(m_confusao))/n_pessoas)*100;

    disp(acerto,'A porcentagem de acerto foi de:');
    m_confusao
end
