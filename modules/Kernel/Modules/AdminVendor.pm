# --
# Kernel/Modules/AdminVendor.pm
# Copyright (C) 2019 Service Up, http://www.serviceup.com.br
#
# written/edited by:
# * gsantos@serviceup.com.br
# --

package Kernel::Modules::AdminVendor;

use strict;
use warnings;
use utf8;

use Kernel::System::VariableCheck qw(:all);

# desabilita o object manager fixo para usar o dinâmico do znuny 7
our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # aloca novo hash para o objeto
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # instanciando objetos de layout e requisição web
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');

    # ------------------------------------------------------------ #
    # change
    # ------------------------------------------------------------ #
    if ( $Self->{Subaction} eq 'Change' ) {
        # captura o id para buscar os dados de edição
        my $ID = $ParamObject->GetParam( Param => 'ID' ) || '';

        # dados estáticos para testar a tela de edição
        my %Data = (
            VendorID   => $ID,
            VendorName => 'Fornecedor de Teste',
            ServiceType => 'Software',
        );

        my $Output = $LayoutObject->Header();
        $Output .= $LayoutObject->NavigationBar();
        
        # chama a função interna para montar o formulário
        $Self->_Edit(
            Action => 'Change',
            %Data,
        );

        $Output .= $LayoutObject->Output(
            TemplateFile => 'AdminVendor',
            Data         => \%Param,
        );
        $Output .= $LayoutObject->Footer();
        return $Output;
    }

    # ------------------------------------------------------------ #
    # change action
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'ChangeAction' ) {

        # valida o token de segurança
        $LayoutObject->ChallengeTokenCheck();

        # captura os parâmetros enviados pelo formulário
        my ( %GetParam, %Errors );
        for my $Parameter (qw(ID VendorName ServiceType)) {
            $GetParam{$Parameter} = $ParamObject->GetParam( Param => $Parameter ) || '';
        }

        # validação de campo obrigatório no servidor
        if ( !$GetParam{VendorName} ) {
            $Errors{VendorNameInvalid} = 'ServerError';
        }

        if ( !%Errors ) {
            # gera a url com o nome para o mock exibir no sucesso
            my $URL = "Action=$Self->{Action};Notify=Success;Name=$GetParam{VendorName}";

            # simulando sucesso: verifica se deve continuar na tela ou voltar
            if ( $ParamObject->GetParam( Param => 'ContinueAfterSave' ) eq '1' ) {
                return $LayoutObject->Redirect( OP => "$URL;Subaction=Change;ID=$GetParam{ID}" );
            }
            return $LayoutObject->Redirect( OP => $URL );
        }

        # caso haja erro, recarrega a página com as notificações
        my $Output = $LayoutObject->Header();
        $Output .= $LayoutObject->NavigationBar();
        $Output .= $LayoutObject->Notify( Priority => 'Error' );
        $Self->_Edit(
            Action => 'Change',
            Errors => \%Errors,
            %GetParam,
        );
        $Output .= $LayoutObject->Output( TemplateFile => 'AdminVendor', Data => \%Param );
        $Output .= $LayoutObject->Footer();
        return $Output;
    }

    # ------------------------------------------------------------ #
    # add
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'Add' ) {
        # renderiza a tela de cadastro vazia
        my $Output = $LayoutObject->Header();
        $Output .= $LayoutObject->NavigationBar();
        $Self->_Edit(
            Action => 'Add',
        );
        $Output .= $LayoutObject->Output(
            TemplateFile => 'AdminVendor',
            Data         => \%Param,
        );
        $Output .= $LayoutObject->Footer();
        return $Output;
    }

    # ------------------------------------------------------------ #
    # add action
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'AddAction' ) {

        # valida o token de segurança
        $LayoutObject->ChallengeTokenCheck();

        # captura parâmetros do novo fornecedor
        my ( %GetParam, %Errors );
        for my $Parameter (qw(VendorName ServiceType)) {
            $GetParam{$Parameter} = $ParamObject->GetParam( Param => $Parameter ) || '';
        }

        # validação server-side
        if ( !$GetParam{VendorName} ) {
            $Errors{VendorNameInvalid} = 'ServerError';
        }

        if ( !%Errors ) {
            # redireciona passando o nome para o mock
            return $LayoutObject->Redirect( 
                OP => "Action=$Self->{Action};Notify=Success;Name=$GetParam{VendorName}" 
            );
        }

        # retorno em caso de erro no cadastro
        my $Output = $LayoutObject->Header();
        $Output .= $LayoutObject->NavigationBar();
        $Output .= $LayoutObject->Notify( Priority => 'Error' );
        $Self->_Edit(
            Action => 'Add',
            Errors => \%Errors,
            %GetParam,
        );
        $Output .= $LayoutObject->Output( TemplateFile => 'AdminVendor', Data => \%Param );
        $Output .= $LayoutObject->Footer();
        return $Output;
    }

    # ------------------------------------------------------------ #
    # overview
    # ------------------------------------------------------------ #
    else {
        # tela inicial do módulo
        my $Output = $LayoutObject->Header();
        $Output .= $LayoutObject->NavigationBar();
        
        # chama o _edit antes para ativar o bloco pai (overview)
        $Self->_Edit(   
            Action => 'Add',
        );

        # ativa o bloco de sucesso se vier de um redirect positivo
        if ( $ParamObject->GetParam( Param => 'Notify' ) eq 'Success' ) {
            # captura o nome vindo da url
            my $SavedName = $ParamObject->GetParam( Param => 'Name' ) || 'Novo';

            $LayoutObject->Block( 
                Name => 'NotifySuccess',
                Data => { VendorName => $SavedName } 
            );
        }
        
        $Output .= $LayoutObject->Output( TemplateFile => 'AdminVendor', Data => \%Param );
        $Output .= $LayoutObject->Footer();
        return $Output;
    }
}

sub _Edit {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # ativa o bloco container no template
    $LayoutObject->Block( Name => 'Overview' );

    # constrói o dropdown de tipos de serviço
    $Param{ServiceTypeOption} = $LayoutObject->BuildSelection(
        Data => {
            'Software'    => 'Software',
            'Hardware'    => 'Hardware',
            'Consultoria' => 'Consultoria',
        },
        Name       => 'ServiceType',
        SelectedID => $Param{ServiceType} || '',
        Class      => 'W50pc Validate_Required',
    );

    # envia os dados e erros para o bloco de formulário
    $LayoutObject->Block(
        Name => 'OverviewUpdate',
        Data => {
            %Param,
            %{ $Param{Errors} || {} },
        },
    );

    return 1;
}

1;