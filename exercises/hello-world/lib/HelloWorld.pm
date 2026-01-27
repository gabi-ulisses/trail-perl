# Declara o pacote (nome do módulo)
package HelloWorld;

use v5.34;                 # Requer Perl 5.34+

use Exporter qw<import>;   # Usa Exporter para controlar o que o módulo exporta
our @EXPORT_OK = qw<hello>;# Permite exportar a função hello explicitamente -> use HelloWorld qw(hello);

sub hello () {             # Declara a função hello (sem argumentos)
    return 'Hello, World!';# Retorna a string "Hello, World!"
}

1;                         # Indica sucesso no carregamento do módulo
