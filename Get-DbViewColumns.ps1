#requires -modules dbatools

function Get-DbViewColumns {
    param (
      [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string] $SqlInstance,
      [parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        [string] $Database
    )
    $excluded = ('RowError','RowState','Table','ItemArray','HasErrors')
    try {
        $views = Get-DbaDbView -SqlInstance $SqlInstance -Database $Database -ExcludeSystemView -ErrorAction Stop | 
            Select -ExpandProperty Name | 
                Sort-Object Name -CaseSensitive
        $vw = $views | Out-GridView -Title "ConfigMgr SQL View" -OutputMode Single
        if ($vw) {
            $dataset = @(Invoke-DbaQuery -SqlInstance $SqlInstance -Database $Database -Query "select top(1) * from $vw" -ErrorAction SilentlyContinue)
            $dataset[0].psobject.Properties | %{
                $x = [ordered]@{
                    ColumnName = $_.Name 
                    DataType   = $_.TypeNameOfValue
                }
                New-Object PSObject -Property $x
            }
        }
    }
    catch {
        Write-Warning "Major Pukesville says: Your request has been denied, silly Earthling:"
        Write-Warning $($Error[0].Exception.Message -join ';')
    }
}
