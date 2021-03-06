#!/bin/bash
#######################################################################################################
#Scrip para download e manipulação de arquivos refentes aos filiados partidários do estado da Paraíba.#
#######################################################################################################

echo -e "Processo iniciado.\n"

#Download dos arquivos no site do tse

for x in $(cat partidos.txt) #Substituir o aquivo txt por uma array/lista
do wget http://agencia.tse.jus.br/estatistica/sead/eleitorado/filiados/uf/filiados_${x}_pb.zip
done


mkdir zipados

mv *.zip zipados/

cd zipados/

###Descompactar arquivos zip###
echo "Descompactando arquivos..."

ls *.zip
echo " "
for x in $(ls *.zip)
do unzip $x
done

###converter codificação###

cd <diretório B> ; pwd

rm <arquivo> #Remover arquivos desnecessários

rename 's/a+//' *.csv #Renomear multiplos arquivos

echo "Convertendo codificação dos arquivos para UTF-8."

for x in $(ls *.csv)
do iconv -f ISO-8859-1 -t UTF-8 $x > _$x
done

rm -v p #Remover arquivos desnecessários

mv *.csv /<diretórios> #Mover multiplos arquivos csv

cd <diretório C> ; pwd

echo "Ajustando colunas dos arquivos"

for x in $(ls /<diretorio>/*.csv)
do  for i in $(cat arquivo.txt)
    do grep -iw "$i" $x > arq.csv
    cut -d ";" -f1-5,8-19 arq.csv >> "$i".csv

    done
done

rm -v arq.csv

echo "Processo finalizado."
