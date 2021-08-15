# XXX How to import this module:
#
#     Import-Module contour-integration -Force

$orig_prompt = (Get-Item "function:prompt").ScriptBlock

function Prompt {
	# set vertical line mark
	Write-Host -NoNewLine "`e[>M"

	# chain into original Prompt function
	$orig_prompt.Invoke("Call")
}

Export-ModuleMember -Function Prompt
