// CharConverter - 文字コンバートツール
// Unicode文字変換機能

// 引数チェック
if (args.length != 3) {
    println "使用方法: CharConverter.groovy <文字設定ファイル> <入力ファイル> <出力ファイル>"
    System.exit(1)
}

def mappingFile = args[0]
def inputFile = args[1]
def outputFile = args[2]

println "CharConverter 開始"
println "文字設定ファイル: ${mappingFile}"
println "入力ファイル: ${inputFile}"
println "出力ファイル: ${outputFile}"

try {
    // 文字マッピングを読み込み
    def characterMap = [:]
    new File(mappingFile).withReader('UTF-8') { reader ->
        reader.eachLine { line ->
            line = line.trim()
            if (line && line.contains(',')) {
                def parts = line.split(',')
                if (parts.length == 2) {
                    def sourceCode = Integer.parseInt(parts[0].trim(), 16)
                    def targetCode = Integer.parseInt(parts[1].trim(), 16)
                    def sourceChar = new String(Character.toChars(sourceCode))
                    def targetChar = new String(Character.toChars(targetCode))
                    characterMap[sourceChar] = targetChar
                    println "マッピング追加: ${sourceChar} (U+${parts[0].trim()}) -> ${targetChar} (U+${parts[1].trim()})"
                }
            }
        }
    }
    
    if (characterMap.isEmpty()) {
        println "警告: 有効な文字マッピングが見つかりませんでした"
    }
    
    // 入力ファイルを読み込み、文字を変換して出力ファイルに書き込み
    def convertedCount = 0
    new File(inputFile).withReader('UTF-8') { reader ->
        new File(outputFile).withWriter('UTF-8') { writer ->
            reader.eachLine { line ->
                def convertedLine = ""
                for (int i = 0; i < line.length(); i++) {
                    String currentChar = line.charAt(i) as String
                    if (characterMap.containsKey(currentChar)) {
                        convertedLine += characterMap[currentChar]
                        convertedCount++
                    } else {
                        convertedLine += currentChar
                    }
                }
                writer.writeLine(convertedLine)
            }
        }
    }
    
    println "変換完了: ${convertedCount}文字を変換しました"
    
} catch (Exception e) {
    println "エラーが発生しました: ${e.message}"
    System.exit(1)
}

println "CharConverter 終了"