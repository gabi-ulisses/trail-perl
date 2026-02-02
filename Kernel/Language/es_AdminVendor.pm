# --
# Kernel/Language/es_GoogleSSO.pm
# Copyright (C) 2019 Service Up, http://www.serviceup.com.br
#
# written/edited by:
# * gsantos@serviceup.com.br
# --

package Kernel::Language::es_AdminVendor;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    $Self->{Translation}->{'Add New Vendor'}          = 'Agregar nuevo proveedor';
    $Self->{Translation}->{'Edit Vendor'}             = 'Editar proveedor';
    $Self->{Translation}->{'Vendor'}                  = 'Proveedor';
    $Self->{Translation}->{'was saved successfully!'} = 'fue guardado con éxito!';
    $Self->{Translation}->{'Vendor Name'}             = 'Nombre del proveedor';
    $Self->{Translation}->{'Service Type'}            = 'Tipo de servicio';
    $Self->{Translation}->{'This field is required.'} = 'Este campo es obligatorio.';
    $Self->{Translation}->{'Please select a value.'}  = 'Por favor, seleccione un valor.';
    $Self->{Translation}->{'Save and finish'}         = 'Guardar y finalizar';
    $Self->{Translation}->{'Save'}                    = 'Guardar';
    $Self->{Translation}->{'Cancel'}                  = 'Cancelar';

    return 1;
}

1;