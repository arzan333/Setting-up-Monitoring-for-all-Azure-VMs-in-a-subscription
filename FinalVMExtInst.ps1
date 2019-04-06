#List all locations where VMs exsists
$x = (Get-AzVM).Location 
# Sorting the list for unique enteries
$UsedLocations = $x | Select-Object -Unique 
#Creates new Resource Group
$RG = New-AzResourceGroup -Name DiagnosticsOnly -Location "centralus" 
#Creates storage accounts in locations required
foreach($UsedLocation in $UsedLocations) 
{
$d = get-date -DisplayHint DateTime
$d = "seyc-diag-"+$d 
$d = $d -replace '[^a-zA-Z0-9]', ''
$storageaccount = New-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" -Name $d -SkuName Standard_LRS -Location "$UsedLocation"
}
#Group all VMs region wise
$EastUSVMs = Get-AzVM | where Location -eq "eastus"
$BrazilSouthVMs = Get-AzVM | where Location -eq "brazilsouth"
$AusSEVMs = Get-AzVM | where Location -eq "australiasoutheast"
$CentralUSVMs = Get-AzVM | where Location -eq "centralus"
$NorthEuropeVMs = Get-AzVM | where Location -eq "northeurope"
$WestEuropeVMs = Get-AzVM | where Location -eq "westeurope"
$CanadaCentralVMs = Get-AzVM | where Location -eq "canadacentral"
$UKWestVMs =  Get-AzVM | where Location -eq "ukwest"
$SouthCentralUSVMs = Get-AzVM | where Location -eq "southcentralus"
$WestUSVMs = Get-AzVM | where Location -eq "westus"
$SoutheastAsiaVMs = Get-AzVM | where Location -eq "southeastasia"
$FranceCentralVMs = Get-AzVM | where Location -eq "francecentral"
$EastUS2VMs = Get-AzVM | where Location -eq "eastus2"
$UKSouthVMs = Get-AzVM | where Location -eq "uksouth"
$WestUS2VMs = Get-AzVM | where Location -eq "westus2"
# Enabling Diagnostics settings in Australia South East
foreach($AusSEVM in $AusSEVMs)
{ 
$AusSEStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "australiasoutheast"
$AusSESA = ($AusSEStorage).StorageAccountName
$AusSESARG = "DiagnosticsOnly"
$AusSESAKey = (Get-AzStorageAccountKey -ResourceGroupName "$AusSESARG" -AccountName "$AusSESA").Value[0]
$AusSEVMName = ($AusSEVM).Name
$AusSEVMRG = ($AusSEVM).ResourceGroupName
$AusSEVMRID = ($AusSEVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$AusSEVMRID"`
       -replace "StorageAccount1", "$AusSESA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$AuSSEVMRG" -VMName "$AusSEVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$AusSESA" -StorageAccountKey "$AusSESAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in Central US
foreach($CentralUSVM in $CentralUSVMs)
{ 
$CentralUSStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "centralus"
$CentralUSSA = ($CentralUSStorage).StorageAccountName
$CentralUSSAKey = (Get-AzStorageAccountKey -ResourceGroupName "DiagnosticsOnly" -AccountName "$CentralUSSA").Value[0]
$CentralUSVMName = ($CentralUSVM).Name
$CentralUSVMRG = ($CentralUSVM).ResourceGroupName
$CentralUSVMRID = ($CentralUSVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$CentralUSVMRID"`
       -replace "StorageAccount1", "$CentralUSSA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$CentralUSVMRG" -VMName "$CentralUSVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$CentralUSSA" -StorageAccountKey "$CentralUSSAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in EastUS
foreach($AusSEVM in $AusSEVMs)
{ 
$AusSEStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "australiasoutheast"
$AusSESA = ($AusSEStorage).StorageAccountName
$AusSESARG = "DiagnosticsOnly"
$AusSESAKey = (Get-AzStorageAccountKey -ResourceGroupName "$AusSESARG" -AccountName "$AusSESA").Value[0]
$AusSEVMName = ($AusSEVM).Name
$AusSEVMRG = ($AusSEVM).ResourceGroupName
$AusSEVMRID = ($AusSEVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$AusSEVMRID"`
       -replace "StorageAccount1", "$AusSESA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$AuSSEVMRG" -VMName "$AusSEVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$AusSESA" -StorageAccountKey "$AusSESAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in EastUS
foreach($EastUSVM in $EastUSVMs)
{ 
$EastUSStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "eastus"
$EastUSSA = ($EastUSStorage).StorageAccountName
$EastUSSARG = "DiagnosticsOnly"
$EastUSSAKey = (Get-AzStorageAccountKey -ResourceGroupName "$EastUSSARG" -AccountName "$EastUSSA").Value[0]
$EastUSVMName = ($EastUSVM).Name
$EastUSVMRG = ($EastUSVM).ResourceGroupName
$EastUSVMRID = ($EastUSVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$EastUSVMRID"`
       -replace "StorageAccount1", "$EastUSSA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$EastUSVMRG" -VMName "$EastUSVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$EastUSSA" -StorageAccountKey "$EastUSSAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in Brazil South
foreach($BrazilSouthVM in $BrazilSouthVMs)
{ 
$BrazilSouthStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "brazilsouth"
$BrazilSouthSA = ($BrazilSouthStorage).StorageAccountName
$BrazilSouthSARG = "DiagnosticsOnly"
$BrazilSouthSAKey = (Get-AzStorageAccountKey -ResourceGroupName "$BrazilSouthSARG" -AccountName "$BrazilSouthSA").Value[0]
$BrazilSouthVMName = ($BrazilSouthVM).Name
$BrazilSouthVMRG = ($BrazilSouthVM).ResourceGroupName
$BrazilSouthVMRID = ($BrazilSouthVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$BrazilSouthVMRID"`
       -replace "StorageAccount1", "$BrazilSouthSA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$BrazilSouthVMRG" -VMName "$BrazilSouthVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$BrazilSouthSA" -StorageAccountKey "$BrazilSouthSAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in North Europe
foreach($NorthEuropeVM in $NorthEuropeVMs)
{ 
$NorthEuropeStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "northeurope"
$NorthEuropeSA = ($NorthEuropeStorage).StorageAccountName
$NorthEuropeSARG = "DiagnosticsOnly"
$NorthEuropeSAKey = (Get-AzStorageAccountKey -ResourceGroupName "$NorthEuropeSARG" -AccountName "$NorthEuropeSA").Value[0]
$NorthEuropeVMName = ($NorthEuropeVM).Name
$NorthEuropeVMRG = ($NorthEuropeVM).ResourceGroupName
$NorthEuropeVMRID = ($NorthEuropeVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$NorthEuropeVMRID"`
       -replace "StorageAccount1", "$NorthEuropeSA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$NorthEuropeVMRG" -VMName "$NorthEuropeVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$NorthEuropeSA" -StorageAccountKey "$NorthEuropeSAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in West Europe
foreach($WestEuropeVM in $WestEuropeVMs)
{ 
$WestEuropeStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "westeurope"
$WestEuropeSA = ($WestEuropeStorage).StorageAccountName
$WestEuropeSARG = "DiagnosticsOnly"
$WestEuropeSAKey = (Get-AzStorageAccountKey -ResourceGroupName "$WestEuropeSARG" -AccountName "$WestEuropeSA").Value[0]
$WestEuropeVMName = ($WestEuropeVM).Name
$WestEuropeVMRG = ($WestEuropeVM).ResourceGroupName
$WestEuropeVMRID = ($WestEuropeVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$WestEuropeVMRID"`
       -replace "StorageAccount1", "$WestEuropeSA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$WestEuropeVMRG" -VMName "$WestEuropeVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$WestEuropeSA" -StorageAccountKey "$WestEuropeSAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in Canada Central
foreach($CanadaCentralVM in $CanadaCentralVMs)
{ 
$CanadaCentralStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "canadacentral"
$CanadaCentralSA = ($CanadaCentralStorage).StorageAccountName
$CanadaCentralSARG = "DiagnosticsOnly"
$CanadaCentralSAKey = (Get-AzStorageAccountKey -ResourceGroupName "$CanadaCentralSARG" -AccountName "$CanadaCentralSA").Value[0]
$CanadaCentralVMName = ($CanadaCentralVM).Name
$CanadaCentralVMRG = ($CanadaCentralVM).ResourceGroupName
$CanadaCentralVMRID = ($CanadaCentralVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$CanadaCentralVMRID"`
       -replace "StorageAccount1", "$CanadaCentralSA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$CanadaCentralVMRG" -VMName "$CanadaCentralVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$CanadaCentralSA" -StorageAccountKey "$CanadaCentralSAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in UK West
foreach($UKWestVM in $UKWestVMs)
{ 
$UKWestStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "ukwest"
$UKWestSA = ($UKWestStorage).StorageAccountName
$UKWestSARG = "DiagnosticsOnly"
$UKWestSAKey = (Get-AzStorageAccountKey -ResourceGroupName "$UKWestSARG" -AccountName "$UKWestSA").Value[0]
$UKWestVMName = ($UKWestVM).Name
$UKWestVMRG = ($UKWestVM).ResourceGroupName
$UKWestVMRID = ($UKWestVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$UKWestVMRID"`
       -replace "StorageAccount1", "$UKWestSA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$UKWestVMRG" -VMName "$UKWestVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$UKWestSA" -StorageAccountKey "$UKWestSAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in South Central US
foreach($SouthCentralUSVM in $SouthCentralUSVMs)
{ 
$SouthCentralUSStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "southcentralus"
$SouthCentralUSSA = ($SouthCentralUSStorage).StorageAccountName
$SouthCentralUSSARG = "DiagnosticsOnly"
$SouthCentralUSSAKey = (Get-AzStorageAccountKey -ResourceGroupName "$SouthCentralUSSARG" -AccountName "$SouthCentralUSSA").Value[0]
$SouthCentralUSVMName = ($SouthCentralUSVM).Name
$SouthCentralUSVMRG = ($SouthCentralUSVM).ResourceGroupName
$SouthCentralUSVMRID = ($SouthCentralUSVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$SouthCentralUSVMRID"`
       -replace "StorageAccount1", "$SouthCentralUSSA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$SouthCentralUSVMRG" -VMName "$SouthCentralUSVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$SouthCentralUSSA" -StorageAccountKey "$SouthCentralUSSAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in West US
foreach($WestUSVM in $WestUSVMs)
{ 
$WestUSStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "westus"
$WestUSSA = ($WestUSStorage).StorageAccountName
$WestUSSARG = "DiagnosticsOnly"
$WestUSSAKey = (Get-AzStorageAccountKey -ResourceGroupName "$WestUSSARG" -AccountName "$WestUSSA").Value[0]
$WestUSVMName = ($WestUSVM).Name
$WestUSVMRG = ($WestUSVM).ResourceGroupName
$WestUSVMRID = ($WestUSVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$WestUSVMRID"`
       -replace "StorageAccount1", "$WestUSSA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$WestUSVMRG" -VMName "$WestUSVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$WestUSSA" -StorageAccountKey "$WestUSSAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in South East Asia
foreach($SoutheastAsiaVM in $SoutheastAsiaVMs)
{ 
$SoutheastAsiaStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "southeastasia"
$SoutheastAsiaSA = ($SoutheastAsiaStorage).StorageAccountName
$SoutheastAsiaSARG = "DiagnosticsOnly"
$SoutheastAsiaSAKey = (Get-AzStorageAccountKey -ResourceGroupName "$SoutheastAsiaSARG" -AccountName "$SoutheastAsiaSA").Value[0]
$SoutheastAsiaVMName = ($SoutheastAsiaVM).Name
$SoutheastAsiaVMRG = ($SoutheastAsiaVM).ResourceGroupName
$SoutheastAsiaVMRID = ($SoutheastAsiaVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$SoutheastAsiaVMRID"`
       -replace "StorageAccount1", "$SoutheastAsiaSA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$SoutheastAsiaVMRG" -VMName "$SoutheastAsiaVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$SoutheastAsiaSA" -StorageAccountKey "$SoutheastAsiaSAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in France Central
foreach($FranceCentralVM in $FranceCentralVMs)
{ 
$FranceCentralStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "francecentral"
$FranceCentralSA = ($FranceCentralStorage).StorageAccountName
$FranceCentralSARG = "DiagnosticsOnly"
$FranceCentralSAKey = (Get-AzStorageAccountKey -ResourceGroupName "$FranceCentralSARG" -AccountName "$FranceCentralSA").Value[0]
$FranceCentralVMName = ($FranceCentralVM).Name
$FranceCentralVMRG = ($FranceCentralVM).ResourceGroupName
$FranceCentralVMRID = ($FranceCentralVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$FranceCentralVMRID"`
       -replace "StorageAccount1", "$FranceCentralSA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$FranceCentralVMRG" -VMName "$FranceCentralVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$FranceCentralSA" -StorageAccountKey "$FranceCentralSAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in EastUS 2
foreach($EastUS2VM in $EastUS2VMs)
{ 
$EastUS2Storage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "eastus2"
$EastUS2SA = ($EastUS2Storage).StorageAccountName
$EastUS2SARG = "DiagnosticsOnly"
$EastUS2SAKey = (Get-AzStorageAccountKey -ResourceGroupName "$EastUS2SARG" -AccountName "$EastUS2SA").Value[0]
$EastUS2VMName = ($EastUS2VM).Name
$EastUS2VMRG = ($EastUS2VM).ResourceGroupName
$EastUS2VMRID = ($EastUS2VM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$EastUS2VMRID"`
       -replace "StorageAccount1", "$EastUS2SA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$EastUS2VMRG" -VMName "$EastUS2VMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$EastUS2SA" -StorageAccountKey "$EastUS2SAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in UK South
foreach($UKSouthVM in $UKSouthVMs)
{ 
$UKSouthStorage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "uksouth"
$UKSouthSA = ($UKSouthStorage).StorageAccountName
$UKSouthSARG = "DiagnosticsOnly"
$UKSouthSAKey = (Get-AzStorageAccountKey -ResourceGroupName "$UKSouthSARG" -AccountName "$UKSouthSA").Value[0]
$UKSouthVMName = ($UKSouthVM).Name
$UKSouthVMRG = ($UKSouthVM).ResourceGroupName
$UKSouthVMRID = ($UKSouthVM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$UKSouthVMRID"`
       -replace "StorageAccount1", "$UKSouthSA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$UKSouthVMRG" -VMName "$UKSouthVMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$UKSouthSA" -StorageAccountKey "$UKSouthSAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
# Enabling Diagnostics settings in West US 2
foreach($WestUS2VM in $WestUS2VMs)
{ 
$WestUS2Storage = Get-AzStorageAccount -ResourceGroupName "DiagnosticsOnly" | where Location -eq "westus2"
$WestUS2SA = ($WestUS2Storage).StorageAccountName
$WestUS2SARG = "DiagnosticsOnly"
$WestUS2SAKey = (Get-AzStorageAccountKey -ResourceGroupName "$WestUS2SARG" -AccountName "$WestUS2SA").Value[0]
$WestUS2VMName = ($WestUS2VM).Name
$WestUS2VMRG = ($WestUS2VM).ResourceGroupName
$WestUS2VMRID = ($WestUS2VM).Id
(Get-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml")) | Foreach-Object {
    $_ -replace "VMRID","$WestUS2VMRID"`
       -replace "StorageAccount1", "$WestUS2SA"
    } | Set-Content ("C:\Users\AAmaria\DiagnosticConfigFile.xml") -force
Set-AzVMDiagnosticsExtension -ResourceGroupName "$WestUS2VMRG" -VMName "$WestUS2VMName" -DiagnosticsConfigurationPath "DiagnosticConfigFile.xml" -StorageAccountName "$WestUS2SA" -StorageAccountKey "$WestUS2SAKey"
Remove-Item -Path "C:\Users\AAmaria\DiagnosticConfigFile.xml"
Copy-Item -Path "C:\Users\AAmaria\Documents\DiagnosticConfigFile.xml" -Destination "C:\Users\AAmaria"
}
