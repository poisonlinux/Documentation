# Handbook Poison GNU/Linux 1.0
**Escritores**:

* Jefferson Carneiro

**Última Revisão**:
* 14 de Março de 2024

Esta documentação esta disponivel offline no pacote **poison-documentation** e online em: [https://poisonlinux.com.br/handbook.html](https://poisonlinux.com.br/handbook.html)

Caso deseje ajudar nesta documentação e virar um revisor ou escritor acesse: [https://codeberg.org/poison/Documentacao](https://codeberg.org/poison/Documentacao)

Este guia é criado em markdown e convertinone.do para html com o script *generate-documentation.sh*.  
O Código fonte disponivel no repositório do github.

Boa leitura

---

* [**O que é o Poison?**](#poison)
	* [Repositório Sunflower](#sunflower)
* [**Primeiros Passos**](#primeirosPassos)
* [**Como é feito o lançamento?**](#lancamentos)
* [**Atualização do Sistema**](#atualizarSistema)
	- [Forma Manual](#atualizarSistemaManual)
	- [Forma Automatizada](#atualizarSistemaAutomatizado)
* [**Atualização do Kernel Linux, cuidados a se tomar**](#atualizarKernel)

## <a name="poison"></a>O que é Poison
O projeto Poison GNU/Linux é voltado a privacidade para usuários comuns. Hoje otimas distribuicoes GNU/Linux que são voltados a privacidade e anonimato existem, porém em sua maioria são mais extremas para uso comum diario. Por exemplo, na maioria dos casos um usuário final não deseja ficar roteado ao tor em toda sua sessão computacional, somente em certas ocasiões é necessária. Tambem não necessariamente necessita de um sistema em modo live ou um sistema que trabalha com virtualizações.  

Então o Poison foi criado para suprir esta necessidade e alinhar comodidade e privacidade, sempre andando juntas. Sabemos que é dificil ter estes dois andando de mãos dadas, afinal, quanto mais sensivel for o modelo de ameça menos comodida o usuario vai ter.

Entendemos que nem todos tem um modelo de ameaça critico e estão fugindo de governos autoritarios ou coisa do tipo, por isso o projeto é voltado para uma simples pessoa, que quer ter mais privacidade com o sistema, softwares, navegação e comunicaçào e não ter alguem espionando... Seus dados são seus dados.

Focamos em um software por categoria e nem tudo esta presente no repositório OFICIAL, para isto você pode utilizar o nosso repositório comunitário o qual apelidamos de **sunflower**. Você pode usar o próprio slackpkg para fazer instalação normalmente. Só lembre-se que o slackpkg não resolve dependencias de softwares, fica por sua conta resolver, o controle é seu.

Por que Slackware? Esta pergunta sem dúvida você teve, basicamente por que o criador do projeto confia no Slackware como uma base fiel, o qual não segue regras e o modismo. E obrigado Patrick Volkerding por ter criado este belo projeto!

Então agora que você já sabe qual é a visão do Poison, vamos listar brevemente mais algumas coisas:

* Mantenha a filosofia KISS.
* Um aplicativo/software por tarefa no repositorio oficial. Nao empurre de goela abaixo softwares para o usuario.
* Systemd FREE.
* Alinhar melhorias e comodidade voltados a privacidade para usuario final.
* Desenvolvimento aberto e colaborativo.
* Uma boa documentacao sempre atualizada.
* Matenha um kernel sempre mais atualizado e estável.

### <a name="sunflower"></a>Repositório Sunflower
O repositório sunflower é aonde ficam pacotes que movemos do repositório oficial como "httpd", "sqlite", "postfix" entre outros. Tambem serve para comunidade enviar os seus pacotes. O repositório já vem configurado para ser utilizado com slackpkg, mas uma nota importante é que não é resolvido dependencia. Então como exemplo se você deseja instalar o pacote **XX** e o mesmo depende de **YY** você tera que fazer:

<pre>
slackpkg install XX YY
</pre>

Para idenficiar qual dependencia de um software, você precisa navegar até o repositório sunflower e verificar o arquivo com extensão .dep .

## <a name="primeirosPassos"></a>Primeiros Passos
Após instalação é importante verificar se há atualizações a se fazer, um sistema atualizado é um sistema com menos vunerabilidade. Para fazer isto utilize o slackpkg.

<pre>
# slackpkg update gpg
# slackpkg update
# slackpkg upgrade-all
</pre>

Caso deseje fazer instalação de softwares não presentes no nosso repositório oficial ou no sunflower, use o sbopkg ou slackbuilds manualmente, é 100% compativel.

## <a name="lancamentos"></a>Como funciona os lançamentos no Poison?

Não temos dia e nem uma data expecifica para o lançamento de novas versões. Assim como Slackware, atualizamos quando está tudo pronto, sem nenhuma pressa. Como dependemos da base Slackware e o mesmo lançar uma nova versão hoje, vamos lançar uma nova versão com mais calma possivel.

Afinal temos muitas personalizações não presentes no Slackware que deve ter um cuidado extra e precisamos de cautela.

## <a name="atualizarKernel"></a>Atualização do Kernel cuidados a se tomar.
Após o lançamento de cada versão e fechamento da ISO, assim como no Slackware fornecemos patches de segurança corrigindo problemas em qualquer pacote do sistema oficial. Sempre ficando disponibilizado em [https://poisonlinux.com.br/repo/poison64-1.0/patches/](https://poisonlinux.com.br/repo/poison64-1.0/patches/). Cada vez que o kernel for atualizado você **obrigatoriamente** deve executar o comando **geninitrd**, para criar uma imagem initrd.gz que ficará disponivel em /boot/.

Isto acontece pois esta imagem sera descarregada na sua memória ram em cada inicialização e subindo somente os módulos necessários. Diferentemente do Kernel Huge que vamos abordar futuramente nesta documentação.

Caso utilize UEFI/EFI você deve copiar os arquivos: **initrd.gz** e **vmlinuz-generic-VERSAO-KERNEL** para o diretório efi/. Supondo que nosso kernel seja a versão 6.6.21, então fizemos:

<pre>
geninitrd
# cp -v vmlinuz-generic-6.6.21 /boot/efi/EFI/Slackware/vmlinuz
# cp -v initrd.gz /boot/efi/EFI/Slackware/
</pre>

Caso você utilize uma máquina LEGACY com lilo você deve somente rodar o comando lilo após atualizar o kernel.

<pre>
# lilo -v
</pre>

Com legacy é mais simples pois em /boot/ você deve ver que é arquivo vmlinuz-generic é um link simbólico para o último kernel instalado.

<pre>
# ls -l /boot/vmlinuz-generic
lrwxrwxrwx 1 root root 22 mar 12 00:44 /boot/vmlinuz-generic -> vmlinuz-generic-6.6.21
</pre>

## <a name="atualizarSistema"></a>Atualizar o seu sistema.

Você pode fazer a atualização do sistema de duas formas, com slackpkg ou de forma manual. A pessoas que preferem o mêtodo manual por ter uma maior interação com o sistema. Como usamos a base estável do Slackware normalmente os patches de segurança vem com uma frequência mais lenta, a frequência cai ainda mais pois retiramos bastante pacotes.

Vamos mostrar o processo das duas formas e você vê qual a forma mais eficaz para você.

### <a name="atualizarSistemaManual"></a>Forma Manual.

Começamos com a forma mais simples, direta e que exige 100% de interação humana.
Comece acessando o repositório do poison e leia o Changelog, é importante para saber o por que software/pacote está sendo atualizado e você precisa fazer a leitura para saber se o software que você vai atualizar está instalado em seu sistema.

Neste metodo é importante você sempre verificar atualizações semanalmente pois pode se tornar complexo a longo prazo se conter muitas pendências.

Disponivel em [https://poisonlinux.com.br/repo/poison64-1.0/](https://poisonlinux.com.br/repo/poison64-1.0/)

Após a verificação do Changelog.txt você deve conferir os softwares se estão instalados.
Neste exemplo supondo que o screenfetch sofreu uma atualização, vamos fazer a conferencia.

<pre>
$ ls /var/adm/packages/screenfetch-*
</pre>/ 

Se houver um retorno do ls significa que o software esta em seu sistema, então você pode baixar o pacote e fazer atualização.
Para isto no repositório do Poison você deve ir até o diretório patches/ e baixa o pacote. Acessivel em [https://poisonlinux.com.br/repo/poison64-1.0/patches/](https://poisonlinux.com.br/repo/poison64-1.0/patches/)

Entre no diretório que desejar e use o wget para baixar o pacote e o pacote assinado com extensão .asc, neste exemplo usamos o /tmp/

<pre>
$ wget https://poisonlinux.com.br/repo/poison64-1.0/patches/screen-4.9.0-x86_64-1.txz https://poisonlinux.com.br/repo/poison64-1.0/slackware64/ap/screen-4.9.0-x86_64-1.txz.asc
</pre>

Verifique a assinatura antes de fazer atualização do pacote! É importante.

<pre>
$ gpg --verify /tmp/screen-4.9.0-x86_64-1.txz.asc
</pre>

Deve se ter uma saida com **Good Signature**. Então fizemos atualização.

<pre>
# upgradepkg --install-new /tmp/screen-4.9.0-x86_64-1.txz
</pre>

E assim se procede em todos os pacotes.

### <a name="atualizarSistemaAutomatizado"></a>Forma Automática.

A forma automatizada é mais rápida, porém necessário sempre ler o Changelog antes para você ficar no controle do que está sendo atualizado.

Utilizamos o slackpkg e slackpkg+ para fazer instalação/atualização dos pacotes no Poison. Tudo esta configurado e deve funcionar corretamente. Comece atualizando a chave gpg, isto é válido apenas na primeira vez que você for atualizar.


> **!!!! NOTA !!!!**  
Os comandos abaixo são executados como usuário administrativo root.

<pre>
# slackpkg update gpg
</pre>

Após isso atualiza a lista de repositório e se caso houver atualizações, instale.

<pre>
# slackpkg update
# slackpkg upgrade-all
</pre>

Se desejar verificar se existe atualizações você pode usar o parêmetro **check-updates**.

<pre>
# slackpkg check-updates
</pre>
