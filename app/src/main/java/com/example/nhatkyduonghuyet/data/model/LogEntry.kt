package com.example.nhatkyduonghuyet.data.model

data class LogEntry(
    val time: String = "",
    val glucose: Float = 0f,
    val insulin: Float = 0f,
    val note: String = ""
)
