Codigo baseado no original escrito por Dayany Rosa Espíndola Côrtes, Eng. Comp e time 2, 2012
IPRJ/UERJ - Nova Friburgo
Sob prof. Ricardo Fabbri


TODO, MELHORAR:

- suporte a numero de imagens diferente por pessoa na base de dados
- modularizar mais com o uso de funcoes
- validacao cruzada mais completa



**************************************************
*            Algebra Linear Numerica             *
*                    Time 2                      *
**************************************************
1- Extraia a pasta Reconhecimento para o diretório de preferência.

2- Abra os arquivos criacaoBancoImgs.sce, metodoReconhecimento.sce e avaliarResultado.sce.

3- Ajuste no arquivo criacaoBancoImgs:
   - Nas linhas 13 a 30 no arquivo criacaoBancoImgs é possível configurar o funcionamento do programa.
   - Linha 13: troque '/home/dayanyrec/Documentos/ALN' pelo caminho do diretório onde foi feita a extração (1).

     - Ajustes finos:
       - Linha 19: informe o numero de pessoas presentes no banco.
       - Linha 21: informe numero de imagens por pessoa presentes no banco.
       - Linha 23: usar_imgs_ajustadas=%t >> usa a base de dados com as imagens cortadas e rotacionadas.
       - Linha 25: subtrair_media=%t >> usa o metodo com subtracao da media. Retira informacao comum (media) de cada imagem.
       - Linha 27: usar_forcabruta=%t >> usa o metodo da força bruta. Calculos feitos com a menor distancia de cada pessoa.
       - Linha 29: usar_pca=%t >> usa o metodo do pca para compressão do banco de imagens.

4- Se o objetivo for testar automaticamente a eficiencia do metodo usando todas as imagens teste, basta executar o arquivo criacaoBancoImgs, com os ajustes finos devidamente feitos, seguido do arquivo avaliarResultado.
Ele retornará a porcentagem de eficiencia do metodo. Chamando eficiencia ao término da execução é possível ver a porcentagem de eficiencia para cada n_compress.

5- Se o objetivo for testar uma imagem por vez, execute o arquivo criacaoBancoImgs, com os ajustes finos devidamente feitos. 
Ajuste no arquivo metodoReconhecimento 
   - Linha 6: defina usar_pca assim como em 3.
   - Linha 8: se usar_pca=%t, n_compress define a compressão a ser utilizada (numero de autovalores a serem utilizados na compressão do banco de imagens).
   - Linha 11: passe para o método a imgteste. As imagens teste carregadas podem ser chamadas através ts(i).
Ao executar, retornará em Saida do metodo:
   - quem é a pessoa da imagem ts.
   - se a imagem teste é parecida com duas pessoas.
   - se a imagem teste pertence ao banco de imagens.
Chamando d ao fim da execução é possível ver a distancia da projeção da imagem teste no subplano de cada pessoa e a propria teste.


*Observações:
   - eficiencia(1) = -1 significa que o teste com n_compress=1 não foi feito. Isso ocorre porque sva(AA(p),1) retorna o svd completo de AA(p) assim como n_compress = 9.


*Erros comuns
- Erro 1 - ms(p) = ms(p) + is(p)(i);
                                   !--error 8 
	   Adição incoerente.
	 - Ocorre quando as imagens usadas não estão do mesmo tamanho.
	 - Solução: resize pela linha de comando


- Erro 2 - O programa avaliarResultado retorna a mesma pessoa para todos os testes.
	 - Ocorre quando imgteste está definido em metodoReconhecimento e avaliarResultados é executado.
