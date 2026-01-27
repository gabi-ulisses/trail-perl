use v5.34;               # Requer Perl 5.34+

use strict;              # Exige declaração de variáveis
use warnings;            # Mostra avisos de possíveis problemas

use FindBin qw($Bin);    # Pega o diretório onde o script está
use lib "$Bin/lib";      # Adiciona a pasta lib ao caminho de módulos

use HelloWorld qw(hello);# Importa a função hello do módulo HelloWorld

my $msg = hello();       # Chama hello() e guarda o resultado

print "$msg\n";          # Imprime a mensagem no terminal
