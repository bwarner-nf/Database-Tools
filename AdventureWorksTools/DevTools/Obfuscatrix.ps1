<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.157
	 Created on:   	2/7/2019 9:25 PM
	 Created by:   	bwarner
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>



$svi=@('__SERVER_INSTANCE_NAME__','__SERVER_INSTANCE_NAME__')
$wsv=@('__SERVER_NAME__','__SERVER_NAME__','__SERVER_NAME__','__SERVER_NAME__','__SERVER_NAME__','__SERVER_NAME__')


$TP = 'C:\Users\bwarner\source\repos\Database-Tools\AdventureWorksTools'

gci -LiteralPath $TP -Recurse | %{
switch($_.PSISContainer)
  {
    $true  {  }
    $false {  } 
  }
}




