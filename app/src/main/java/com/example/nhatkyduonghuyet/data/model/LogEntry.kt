package com.example.nhatkyduonghuyet.data.model

data class LogEntry(
    val id: String = "",
    val date: String,
    val session: String,

    val medType: String? = null,
    val dose: String? = null,
    val time: String? = null,

    val heartRate: Int? = null,
    val bpSys: Int? = null,
    val bpDia: Int? = null,

    val bgBefore: Double? = null,
    val bgAfter: Double? = null,

    val note: String? = null,
    val createdAt: Long = System.currentTimeMillis()
)
