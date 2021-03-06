#!/bin/bash

##########################
# PROGRAMA BOLSA FAMÍLIA #
##########################
#
# bfamilia.sh - Extrai dados do Portal da Transparência do Governo Federal de beneficiários do Programa Bolsa Família.
#
# Autor  :Edson Sales <sales_eds@hotmail.com>
#
#-----------------------------------------------------------------------------------------
# Este programa realiza o download da relação de beneficiários do Programa Bolsa Família,
# disponível no Portal da Tranparência do Governo Federal <http://www.transparencia.gov.br/>.
# O programa descompacta o arquivo baixado, faz ajustes de formatação, filtra os dados conforme 
# municípios selecionados e outros critérios e, por fim, gera um arquivo com as modificações estabelecidas.
# Para o funcionamento, o programa necessita do link dos dados e relação de municpios de interesse.
#-----------------------------------------------------------------------------------------
#
# Licença: GPL
#
##################################################################################CÓDIGO:

if [ -e /usr/bin/figlet ]; then

   figlet Programa
   figlet Bolsa Familia

fi

echo "Beneficiários do Prgrama Bolsa Família."
echo "Processo de extração de dados iniciado..."

touch auxiliar.txt

#baixar arquivos
for x in $(cat periodo.txt)
do echo -e "\nExecutando download..."

   if [ -e ./$x.zip ]; then

   echo O arquivo $x.zip já existe.

   else
   wget --show-progress  http://www.portaltransparencia.gov.br/download-de-dados/bolsa-familia-pagamentos/${x}.zip

   echo -e "\nDescompactando arquivo..."
   unzip $x.zip
   echo "Arquivo descompactado."

   echo -e "\nFiltrando dados do  arquivo..."
   for i in $(cat munics.txt)
   do grep -iw "$i" *.csv  > arq.txt
      cat arq.txt >> auxiliar.txt
   done

  echo -e "\nRemovendo arquivos desnecessários..."
  rm -vr *.csv
  rm -vr arq.txt

  fi

done

#O trecho de código abaixo necessita ser melhorado.

echo -e "\nCriando arquivo com os resultados..."

grep -iw "pb" auxiliar.txt > beneficiarios.txt

sed -i 's/,/./g' beneficiarios.txt
sed -i 's/.$//g' beneficiarios.txt
sed -i 's/CRUZ DO ESPIRITO SANTO//g' beneficiarios.txt
sed -i 's/JURUPIRNGA/2/g' beneficiarios.txt
sed -i 's/MARI/3/g' beneficiarios.txt
sed -i 's/3A/MARIA/g' beneficiarios.txt
sed -i 's/PILAR/4/g' beneficiarios.txt
sed -i 's/RIACHAO DO POCO/5/g' beneficiarios.txt
sed -i 's/SAO JOSE DOS RAMOS/6/g' beneficiarios.txt
sed -i 's/SAO MIGUEL DE TAIPU/7/g' beneficiarios.txt
sed -i 's/SAPE/8/g' beneficiarios.txt
sed -i 's/SOBRADO/9/g' beneficiarios.txt

echo "Arquivo com resultados criado."

echo -e "\nMovendo aquivos .zip..."
mv *.zip ./compactados/
mv beneficiarios.txt ./resultados/
echo -e "\nArquivos movidos."

echo -e "\nRemovendo auxiliar.txt..."
rm -vr auxiliar.txt

echo -e "\nProcesso finalizado!"

##################################################################################FIM.
