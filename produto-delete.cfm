<cfset setLocale("Portuguese (Brazilian)")>

<cfif isDefined("form.id")>
    <cfquery datasource="vendas_dsn" name="qProdutos">
        DELETE FROM produtos WHERE id=#form.id#
    </cfquery>
</cfif>


<cflocation url="index.cfm" >

