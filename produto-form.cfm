<cfset setLocale("Portuguese (Brazilian)")>
<!--- <cfparam name="URL.id" default="0" > --->


<cfif isDefined("URL.id")>
    <cftry>
        <cfquery datasource="vendas_dsn" name="qProdutos">
            SELECT id, nomeproduto, descricao, preco_unitario, quantidade 
            FROM produtos
            WHERE id = <cfqueryparam value="#URL.id#" cfsqltype="cf_sql_integer" >
        </cfquery>

        <cfcatch>
            <cflocation url="index.cfm" >
        </cfcatch>   

    </cftry>
<cfelse>
    <cfset qProdutos = StructNew()>
    <cfset qProdutos.id = 0>
    <cfset qProdutos.nomeproduto = "">
    <cfset qProdutos.descricao = "">
    <cfset qProdutos.preco_unitario = 0>
    <cfset qProdutos.quantidade = 0>
</cfif>


<html lang="pt">

<head>
    <title>Gestão do Estoque</title>
    <link rel="stylesheet"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
        crossorigin="anonymous">
    <meta charset="utf-8">    
</head>

<body>

	<header>
		<nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
			<div>
				<a href="/crud_produto" class="navbar-brand">
					Gestão do Estoque </a>
			</div>

			<ul class="navbar-nav">
				<li><a href="/crud_produto"
					class="nav-link">Produtos</a></li>
			</ul>
		</nav>
	</header>

	<br>
	<div class="container col-md-5">
		<div class="card">
			<div class="card-body">

                <cfif isDefined("URL.id")>
					<form action="index.cfm" method="post">
                    <input type="hidden" name="operacao" value="editar" />                    
				    <h2> Editando Cliente </h2>
                <cfelse>
					<form action="index.cfm" method="post">
                    <input type="hidden" name="operacao" value="adicionar" />                    
				    <h2> Adicionando Cliente </h2>

                </cfif>

                <cfoutput>
                    <cfif isDefined("URL.id")>
                        <input type="hidden" name="id"  value="#qProdutos.id#" />
                    </cfif>

                    <fieldset class="form-group">
                        <label>Nome do produto</label> <input type="text"
                            value="#qProdutos.nomeproduto#" class="form-control"
                            name="nomeproduto" required="required">
                    </fieldset>

                    <fieldset class="form-group">
                        <label>Descrição</label> <input type="text"
                            value="#qProdutos.descricao#" class="form-control"
                            name="descricao">
                    </fieldset>

                    <fieldset class="form-group">
                        <label>Preço unitário</label> R$ <input type="number" step="0.01" min="0.01"
                            value="#qProdutos.preco_unitario#" class="form-control"
                            name="preco_unitario">
                    </fieldset>

                    <fieldset class="form-group">
                        <label>Quantidade</label> <input type="text"
                            value="#qProdutos.quantidade#" class="form-control"
                            name="quantidade">
                    </fieldset>
                </cfoutput>

				<button type="submit" class="btn btn-success">Gravar</button>
				<a href="/crud_produto" class="btn btn-success">Voltar</a>
				
				
				</form>
			</div>
		</div>
	</div>
</body>

</html>