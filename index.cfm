<cfset setLocale("Portuguese (Brazilian)")>

<cfif isDefined("form.operacao") >

    <cfif #form.operacao# eq "editar" >
        <cfquery datasource="vendas_dsn" name="qProdutos">
            UPDATE produtos
            SET  nomeproduto="#form.nomeproduto#"
                ,descricao="#form.descricao#"
                ,preco_unitario="#form.preco_unitario#"
                ,quantidade =#form.quantidade#
            WHERE id="#form.id#"
        </cfquery>

        <cfset  form.operacao = "">
    </cfif>


    <cfif #form.operacao# eq "adicionar" >
        <cfquery datasource="vendas_dsn" name="qProdutos">
            INSERT into produtos (nomeproduto,descricao,preco_unitario,quantidade) 
            values ("#form.nomeproduto#","#form.descricao#",#form.preco_unitario#,#form.quantidade#)           
        </cfquery>

        <cfset  form.operacao = "">

    </cfif>    

</cfif>



<cfquery datasource="vendas_dsn" name="qProdutos">
    SELECT id, nomeproduto, descricao, preco_unitario, quantidade FROM produtos
</cfquery>

<!DOCTYPE html>
<html>

    <head>
        <title>
            Gestão de Estoque
        </title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" 
              href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" 
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" 
              crossorigin="anonymous">
    </head>
    
    <body>
        <header>
            <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
                <div>
                    <a href="#" class="navbar-brand">Gest&atilde;o de Estoque</a>
                </div>
                
                <ul class="navbar-nav">
                    <li>
                        <a href="/crud_produto" class="nav-link">
                            Produtos
                        </a>
                    </li>
                </ul>
            </nav>
        </header>
        


        <div class="row">
            <!-- 
            <div class="alert alert-success" *ngIf='message'>{{message}}</div>
            -->
            <div class="container">
                <h3 class="text-center">
                    Listagem de Produtos
                </h3>
                <p>
                <a href="produto-form.cfm" class="btn btn-primary">
                    Novo Produto 
                </a>
                </p>
                

			    <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th> Código </th>
                            <th> Nome do Produto </th>
                            <th> Descrição </th>
                            <th> Pre&ccedil;o </th>
                            <th> Quantidade </th>
                            <th> </th>
                        </tr>
                    </thead>
                    <tbody>
                    
                        <cfoutput query="qProdutos">
                        
                            <tr>
                                <td scope="row"> #qProdutos.id# </td>
                                <td> #qProdutos.nomeproduto# </td>
                                <td> #qProdutos.descricao#  </td>
                                <td> #lsCurrencyFormat(qProdutos.preco_unitario)#  </td>
                                <td> #qProdutos.quantidade#  </td>
                                <td> 
                                
                                    <a href="produto-form.cfm?id=#qProdutos.id#" class="btn btn-primary">
                                        Editar
                                    </a>                                      

                                      <button type='button' class='btn btn-danger' data-toggle='modal' data-target='##exampleModal' onclick='$(".delete_id").val(#qProdutos.id#)'>Apagar</button>
                                </td>

                            </tr>
                            
                        </cfoutput>
                    </tbody>
                </table>

                <!-- Modal -->
                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <input type="hidden" name="delete_id" class="delete_id">

                                <h5 class="modal-title" id="exampleModalLabel">Deseja realmente apagar o registro?</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Não</button>
                                <button type="submit" class="btn btn-danger" onclick="deleteRecord()">Sim</button>                                
                            </div>
                        </div>
                    </div>
                </div>                
        </div>
    </div>


        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


            <script>
                function deleteRecord() {
                    var id = $(".delete_id").val();

                    $.ajax({
                        url:"http://localhost:8500/crud_produto/produto-delete.cfm",
                        method:"POST",
                        data:{
                            id: id,
                        },

                        success:function(response) {
                            location.reload();
                        },
                });
                } 
            </script>
            
            <script>
                if ( window.history.replaceState ) {
                    window.history.replaceState( null, null, window.location.href );
                }
            </script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" 
                integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" 
                crossorigin="anonymous">
        </script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" 
                integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" 
                crossorigin="anonymous">
        </script>
    </body>
</html>