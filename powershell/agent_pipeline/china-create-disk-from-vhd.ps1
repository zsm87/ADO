<#
.EXAMPLE
    $params = @{
        SubscriptionId    = '73c3fef9-f708-43b6-bf09-7eccc45892ea'
        ResourceGroupName = 'core-china-testing'
        Location          = 'northeurope'
        DiskName          = 'build-agent-disk'
        StorageAccountId  = '/subscriptions/73c3fef9-f708-43b6-bf09-7eccc45892ea/resourceGroups/core-china-testing/providers/Microsoft.Storage/storageAccounts/corechinatestingsa'
        VHDUri            = 'https://corechinatestingsa.blob.core.windows.net/images/build-agent-snapshot.vhd'
        ErrorAction       = 'Stop'
    }
    .\china-create-disk-from-vhd.ps1 @params
#>

param
(
	[Parameter(Mandatory)]
	[string] $SubscriptionId,

	[Parameter(Mandatory)]
	[string] $ResourceGroupName,

	[Parameter(Mandatory)]
	[string] $Location,

	[Parameter(Mandatory)]
	[string] $DiskName,

    [Parameter(Mandatory)]
	[string] $StorageAccountId,

    [Parameter(Mandatory)]
	[string] $VHDUri
)

# Service Connection

#$storageType = 'Premium_LRS'
$storageType = 'Standard_LRS'
$diskSize = '260'

$diskConfig = New-AzDiskConfig -AccountType $storageType -Location $Location -CreateOption Import -StorageAccountId $StorageAccountId -SourceUri $VHDUri -DiskSizeGB $diskSize
New-AzDisk -Disk $diskConfig -ResourceGroupName $ResourceGroupName -DiskName $DiskName
