package com.chopeks

import antlr.QspLexer
import org.antlr.v4.runtime.CharStreams
import org.antlr.v4.runtime.CommonTokenStream
import java.io.File

fun main(args: Array<String>) {
    if (args.size < 2) {
        println("Usage: scapper.jar \"path/to/locations\" \"path to file\" format")
        println("format is optional, default: text")
        println("possible formats: text, kotlin")
        return
    }

    val set = hashSetOf<String>()
    val map = mutableMapOf<String, String>()
    File(args[0]).listFiles()?.forEach {
        val lexer = QspLexer(CharStreams.fromStream(it.inputStream()))
        val tokens = CommonTokenStream(lexer)
        //    val log = File("log.txt")
        //    log.writeText("")
        //    for (i in 0 until tokens.numberOfOnChannelTokens) {
        //        log.appendText(tokens[i].toString() + '\n')
        //    }
        // we are looking for combo: Identifier operator (identifier or string or int), so 3 tokens at once
        for (i in 0 until tokens.numberOfOnChannelTokens - 3) {
            if (tokens[i].type == QspLexer.Identifier) {
                if (tokens[i + 1].type == QspLexer.ASSIGNMENT_OPERATORS) {
                    if (tokens[i + 2].run { type == QspLexer.Identifier || type == QspLexer.StringLiteral || type == QspLexer.IntegerLiteral }) {
                        if (tokens[i].text.toLowerCase() in set) {
                            map[tokens[i].text.toLowerCase()] = tokens[i].text
                        }
                        set.add(tokens[i].text.toLowerCase())
                    }
                }
            }
        }
        // also, we are looking for array access
        for (i in 0 until tokens.numberOfOnChannelTokens - 2) {
            if (tokens[i].type == QspLexer.Identifier) {
                if (tokens[i + 1].type == QspLexer.LSQUARE) {
                    if (tokens[i].text.toLowerCase() in set) {
                        map[tokens[i].text.toLowerCase()] = tokens[i].text
                    }
                    set.add(tokens[i].text.toLowerCase())
                }
            }
        }
    }
    when (args[2].toLowerCase().trim()) {
        "kotlin" -> File(args[1]).writeText(map.values.sorted().joinToString("\n") {
            if (it.startsWith("$")) "var `$it`: Any = 0" else "var $it: Any = 0"
        })
        else -> File(args[1]).writeText(map.values.sorted().joinToString("\n"))
    }

}
