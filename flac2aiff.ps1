# Prompt the user for the input and output directories
$inputDir = Read-Host -Prompt "Enter the input directory path"
$outputDir = Read-Host -Prompt "Enter the output directory path"

if (!(Test-Path -Path $outputDir)) {
    New-Item -Path $outputDir -ItemType Directory | Out-Null
}

# Get the flac files in the input directory
Get-ChildItem -Path $inputDir -Filter *.flac | ForEach-Object {
    $inputFile = Join-Path -Path $inputDir -ChildPath $_.name

    # Make the output file the same name as flac but with .aiff file name
    $outputFile = Join-Path -Path $outputDir -ChildPath ($_.BaseName + ".aiff")
    
    # Run the ffmpeg command
    ffmpeg -i $inputFile -write_id3v2 1 -c:v copy -acodec pcm_s16le -ar 44100 -ac 2 $outputFile
}
