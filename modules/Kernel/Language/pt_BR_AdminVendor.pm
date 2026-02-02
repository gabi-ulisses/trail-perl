# --
# Kernel/Language/pt_BR_AdminVendor.pm
# Copyright (C) 2019 Service Up, http://www.serviceup.com.br
#
# written/edited by:
# * gsantos@serviceup.com.br
# --

package Kernel::Language::pt_BR_AdminVendor;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    $Self->{Translation}->{'Add New Vendor'}          = 'Adicionar Novo Fornecedor';
    $Self->{Translation}->{'Edit Vendor'}             = 'Editar Fornecedor';
    $Self->{Translation}->{'Vendor'}                  = 'Fornecedor';
    $Self->{Translation}->{'was saved successfully!'} = 'foi salvo com sucesso!';
    $Self->{Translation}->{'Vendor Name'}             = 'Nome do Fornecedor';
    $Self->{Translation}->{'Service Type'}            = 'Tipo de Serviço';
    $Self->{Translation}->{'This field is required.'} = 'Este campo é obrigatório.';
    $Self->{Translation}->{'Please select a value.'}  = 'Por favor, selecione um valor.';
    $Self->{Translation}->{'Save and finish'}         = 'Salvar e finalizar';
    $Self->{Translation}->{'Save'}                    = 'Salvar';
    $Self->{Translation}->{'Cancel'}                  = 'Cancelar';

    return 1;
}

1;