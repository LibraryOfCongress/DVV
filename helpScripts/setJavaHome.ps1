
$jre = "hklm:\software\JavaSoft\Java Runtime Environment"
$jdk = "hklm:\software\JavaSoft\Java Development Kit"

$jreEntries = Get-ChildItem -ErrorAction ignore $jre
$jdkEntries = Get-ChildItem -ErrorAction ignore $jdk
$entries = ""

if($jreEntries){
  $entries = $jreEntries
}
ElseIf($jdkEntries){
  $entries = $jdkEntries
}
Else{
  throw "Not able to find Java entry in the registry. Is Java version 7 or higher installed?"
}

$installDir = (Get-ItemProperty -Path $entries[0].pspath -Name JavaHome).JavaHome}
[environment]::SetEnvironmentVariable('JAVA_HOME', $installDir, 'user')
