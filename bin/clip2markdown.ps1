[console]::inputencoding=[text.encoding]::ascii
$outputencoding=[console]::outputencoding=[text.encoding]::utf8

# ref: https://gyrojeff.top/index.php/archives/powershell-%E5%89%AA%E5%88%87%E6%9D%BF%E8%8E%B7%E5%8F%96%E4%B8%AD%E6%96%87%E4%B9%B1%E7%A0%81%E9%97%AE%E9%A2%98/
Add-Type -Assembly PresentationCore
$clipboard = [Windows.Clipboard]::GetData([Windows.DataFormats]::Html)

# ref: https://gist.github.com/diogotito/028003d49c84f09f5f232f8d76aa378d
$ofs = "`n"
$html_fragment = ("$clipboard" -split '<!--StartFragment-->|<!--EndFragment-->')[1]

$html_fragment | pandoc -f html -t org --wrap=none | pandoc -f org -t markdown --wrap=none
