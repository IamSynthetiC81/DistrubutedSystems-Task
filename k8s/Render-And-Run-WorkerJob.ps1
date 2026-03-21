param(
    [Parameter(Mandatory = $true)]
    [string]$JobId,

    [Parameter(Mandatory = $true)]
    [int]$TaskIndex,

    [Parameter(Mandatory = $true)]
    [ValidateSet("map", "reduce")]
    [string]$Role,

    [string]$Namespace = "mapreduce",
    [string]$TemplateConfigMap = "mr-worker-job-template",
    [string]$TemplateKey = "worker-job-template.yaml",
    [string]$OutputPath,
    [switch]$RenderOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-TemplateText {
    param(
        [string]$CmName,
        [string]$Ns,
        [string]$Key
    )

    $cmJson = kubectl get configmap $CmName -n $Ns -o json
    if (-not $cmJson) {
        throw "Failed to read ConfigMap $CmName in namespace $Ns."
    }

    $cm = $cmJson | ConvertFrom-Json
    $property = $cm.data.PSObject.Properties[$Key]
    if (-not $property) {
        throw "Template key '$Key' was not found in ConfigMap $CmName."
    }

    return [string]$property.Value
}

function Render-Template {
    param(
        [string]$Template,
        [string]$Job,
        [int]$Index,
        [string]$WorkerRole
    )

    $rendered = $Template
    $rendered = $rendered -replace '\{\{JOB_ID\}\}', [string]$Job
    $rendered = $rendered -replace '\{\{TASK_INDEX\}\}', [string]$Index
    $rendered = $rendered -replace '\{\{ROLE\}\}', [string]$WorkerRole

    return $rendered
}

if (-not (Get-Command kubectl -ErrorAction SilentlyContinue)) {
    throw "kubectl is not installed or not in PATH."
}

if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    $OutputPath = Join-Path $env:TEMP ("mr-worker-{0}-{1}.yaml" -f $JobId, $TaskIndex)
}

$templateText = Get-TemplateText -CmName $TemplateConfigMap -Ns $Namespace -Key $TemplateKey
$renderedYaml = Render-Template -Template $templateText -Job $JobId -Index $TaskIndex -WorkerRole $Role

Set-Content -Path $OutputPath -Value $renderedYaml -Encoding utf8
Write-Host "Rendered worker job manifest: $OutputPath"

if ($RenderOnly) {
    Write-Host "RenderOnly enabled. Skipping kubectl apply."
    exit 0
}

kubectl apply -f $OutputPath
if ($LASTEXITCODE -ne 0) {
    throw "kubectl apply failed."
}

Write-Host "Worker job submitted successfully."
