Notas angular 1.X


<html ng-app="listaTelefonica"> -->utilizacao do modulo pelo angular nessa parte do html

angular.module("listaTelefonica", []); --> criacao do modulo
angular.module("listaTelefonica", []).controller("listaTelefonicaCtrl", function($scope){ --> definicao do controle
       $scope.app = "Lista Telefonica";
});

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
diretivas do angular 

ng-model=" " --> referente a captura de data em um "input" ou "form-control" ou ... 
ng-disabled=" " --> para desabilitar, por exemplo um botao devido a alguma condição
ng-repeat="x in conjunto"> --> para repetir x elementos de um conjunto
ng-click="" --> ao clicar, gera algum evento, geralmente uma função
ng-options --> geralmente associado a um ng-model e acaba
-------------------------------------------------------------------------------------------------------------------------------------------
ng-class --> defino uma "propriedade" no escopo de acordo com a definicao ng-class="propriedade do escopo" que podera ser definida no escopo  mudando o estilo do css por exemplo
exemplo de uso:
<style>
 .selecionado {
            background-color: yellow;
        }
 .negrito {
            font-style: italic; 
        }
</style> 

<tr ng-class="{selecionado: contato.selecionado, negrito: contato.selecionado}" ng-repeat="contato in contatos">
          <td><input type="checkbox" ng-model="contato.selecionado"></td>
          <td>{{contato.nome}}</td>
          <td>{{contato.telefone}}</td>
          <td>{{contato.operadora.nome}}</td>
</tr>
// ao ser selecionado o checkbox contato.selecionado = true e o css vai atuar
--------------------------------------------------------------------------------------------------------------------------------------------
ng-style --> para dar algum efeito mais especifico, principalmente relacionado ao css

<td><div style="width: 20px; height: 20px" ng-style="{'background-color': contato.cor}"></div></td>

// cada contato foi definido no array com uma cor, entao dentro de cada celula sera mostrada uma cor
--------------------------------------------------------------------------------------------------------------------------------------------
ng-show --> verdadeiro, mostra  --nao é interessante usar em termos de performace  Devemos usar o "ng-if"
ng-hide --> verdadeiro, esconde
ng-if --> funciona com if
ng-include --> geralmente adiciona algum componente html
ng-required --> referente ao nao preenchimento de um input
ng-pattern --> para requerer um formato de expressao dentro de um form por exemplo:
                         ng-pattern="/^\d{4,5}-\d{4}$" --> 99999-5555(true), 9999-5555(true), 666-666666(false)

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Declaracoes

array -->

$scope.contatos = [
                    {nome: "A", telefone:"9999 8888"},
                    {nome: "B", telefone:"9999 7777"},
                    {nome: "C", telefone:"9999 6666"},
                    {nome: "D", telefone:"9999 5555"},
                    {nome: "E", telefone:"9999 4444"}
                  ];
 
$scope.operadoras = [
                    {nome: "Oi", codigo:"15", categoria:"Celular"},
                    {nome: "Tim", codigo:"41", categoria:"Celular" },
                    {nome: "Vivo", codigo:"14", categoria:"Celular"},
                    {nome: "GVT", codigo:"36", categoria:"Fixo" },
                    {nome: "NET", codigo:"77", categoria:"Fixo" }
                ];



funcao -->

$scope.adicionarContato = function(contato) {
                    $scope.contatos.push(angular.copy(contato)); --> insere no array
                    delete $scope.contato;
                }

uso de expressoes, foram usados dentro de um <form>
$invalid --> é falso? --> podem ser usados com ng-disabled
$valid --> é verdadeiro?
$dirty --> por exemplo, usamos dentro de um input, se o campo nao é mais virgem(ja foi usado), entao é verdadeiro. Pode ser usado com ng-show ou ng-if
$pristine --> oposto a dirty. é virgem?
$ngMinlength --> tamanho minimo de caracteres a ser preenchido
$ngMaxlenght --> tamanho maximo a ser preenchido
$error --> é acompanhado de um minlenght ou required ou pattern--> tipo: .$error.minlength ou $error.required

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Observaçoes
	- pode-se passar por uma funcao um array diretamente:   
	 $scope.adicionarContato = function(contato) { blabla

	- pode-se criar um outro array, por exemplo: "operadora[{nome:"blabla", codigo="blabla"}]"; -->sendo que eu posso usar a funcao(contato) para exibir e trabalhar o "array operadora".   
            <select ng-model="contato.operadora" ng-options="operadora.nome "group by operadora.categoria" for operadora in                 operadoras" {{contato.operadora.nome}}>
	  <option value="">Selecione uma operadora</option>
          </select>

	- Em uma situacao como a descrita abaixo:
	<form name="contatoForm"><!-- objeto criado -->
            <input class="form-control" type="text" ng-model="contato.nome" name="nome" placeholder="Nome" ng-required="true" />
            <input class="form-control" type="text" ng-model="contato.telefone" name="telefone" placeholder="Telefone" ng-required="true" />
            <select class="form-control" ng-model="contato.operadora" ng-options="operadora.nome for operadora in operadoras">
			<option value="">Selecione uma operadora</option>
		    </select>
        </form>
        <div ng-show="contatoForm.nome.$invalid" class="alert alert-danger"> // poderia utilizar "contatoForm.contato.nome.$invalid", mas devido a criacao da tag name="nome", foi abreviado.
            Por favor, preencha o nome!
        </div>
        <div ng-show="contatoForm.telefone.$invalid" class="alert alert-danger">  // poderia utilizar "contatoForm.contato.telefone.$invalid"
            Por favor, preencha o telefone!
        </div>

	- Em uma situacao para limpar o um form: dica:
	$scope.contatoForm.$setPristine(); // deixa ele virgem novamente

	- Em uma situacao para acompanhar o tamnho minimo de caracteres ou se o campo foi preenchido, podemos usar:
	<div ng-show="contatoForm.nome.$error.required && contatoForm.nome.$dirty" class="alert alert-danger">
            Por favor, preencha o nome!
        </div>
        <div ng-show="contatoForm.nome.$error.minlength" class="alert alert-danger">
            O campo nome deve ter no minimo 10 caracteres!
        </div>

	Exemplo completo de validacao de um form: deve-se injetar a dependencia "angular.module("listaTelefonica", ["ngMessages"]);"
	<form name="contatoForm">
			<input class="form-control" type="text" ng-model="contato.nome" name="nome" placeholder="Nome" ng-required="true" ng-minlength="10"/>
			<input class="form-control" type="text" ng-model="contato.telefone" name="telefone" placeholder="Telefone" ng-required="true" ng-pattern="/^\d{4,5}-\d{4}$/"/>
			<select class="form-control" ng-model="contato.operadora" ng-options="operadora.nome for operadora in operadoras">
				<option value="">Selecione uma operadora</option>
			</select>
		</form>

		<div ng-messages="contatoForm.nome.$error" class="alert alert-danger"> //uso de bb angular-messages.js
			<div ng-message="required">
				Por favor, preencha o campo nome!
			</div>
			<div ng-message="minlength">
				O campo nome deve ter no mínimo 10 caracteres.
			</div>
		</div>
		// sem uso de bibliotecas
		<div ng-show="contatoForm.telefone.$error.required && contatoForm.telefone.$dirty" class="alert alert-danger">
			Por favor, preencha o campo telefone!
		</div>
		<div ng-show="contatoForm.telefone.$error.pattern" class="alert alert-danger">
			O campo telefone deve ter o formato DDDDD-DDDD.
		</div>
		<button class="btn btn-primary btn-block" ng-click="adicionarContato(contato)" ng-disabled="contatoForm.$invalid">Adicionar Contato</button>
		<button class="btn btn-danger btn-block" ng-click="apagarContatos(contatos)" ng-if="isContatoSelecionado(contatos)">Apagar Contatos</button>


<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Uso de bibliotecas do angularjs 
  -no caso de validacao do form, foi usado  a biblioteca do angular-messages.js

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Uso de filtros
{{contato.nome | uppercase}}
{{contato.nome | lowercase}}
{{contato.data | date: 'DD/MM/YYYY'}}

exemplo de uso para busca em uma tabela
<input class="form-control" type="text" ng-model="criterioDeBusca" placeholder="O que você está buscando?"/>
<table>
<tr ng-class="{'selecionado negrito': contato.selecionado}" ng-repeat="contato in contatos | filter:criterioDeBusca |  orderBy:criterioDeOrdenacao:direcaoDaOrdenacao">
				<td><input type="checkbox" ng-model="contato.selecionado"/></td>
				<td>{{contato.nome}}</td>
				<td>{{contato.telefone}}</td>
				<td>{{contato.operadora.nome | lowercase}}</td>
				<td>{{contato.data | date:'dd/MM/yyyy HH:mm'}}</td>
			</tr>
</table>


ng-repeat="contato in contatos | filter:criterioDeBusca --> qualquer dado digitado referente a tabela ele traz. 
ng-repeat="contato in contatos | filter:{nome:criterioDeBusca} --> qualquer dado digitado refente ao nome da tabela
ng-repeat="contato in contatos | filter:criterioDeBusca | orderBy :'nome':true"> --> ordem descendente


usando funnction

ng-repeat="contato in contatos | filter:criterioDeBusca | orderBy:criterioDeOrdenacao:direcaoDaOrdenacao"> //essa direcaoDaOrdenacao vai começar com false e vai se alterando na medida que a funcao for chamada.

$scope.ordenarPor = function (campo) {
				$scope.criterioDeOrdenacao = campo;
				$scope.direcaoDaOrdenacao = !$scope.direcaoDaOrdenacao;
			};

olhar filtro currency --> moedas de outros paises, deve-se importar a biblioteca necessaria
olhar filtro number --> {100 | number:2} --> 100.00
existe o "limitTo" para limitar o numero de busca

Outra maneira para trabalhar no controller
-passa na function do contrller o $filter e no lugar desejado, por ex: $filter('uppercase')("nomedesejado")


>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

--exemplo de css para alert
<style>
	.ui-alert {
    background-color: #F2DEDE;
    padding: 10px;
    border-radius: 5px;
    margin-top: 20px;
    margin-bottom: 20px;
    
    margin-right: 100px;
	}

	.ui-alert-title {
    color: #AF4341;
    font-size: 14px;
    font-weight: bold;

	}
	</style>
</head>
<body ng-controller="listaTelefonicaCtrl">
	<div class="jumbotron">
		<h3>{{app}}</h3>
		
		<!--<div ui-alert></div>-->
		

		<!-- Isso e o css, ja resolve!-->
		<div class="ui-alert">
			<div class="ui-alert-title">
				Email já cadastrado por outro usuário! 
			</div>	
		</div>

--------------------------------------------------------------------------







