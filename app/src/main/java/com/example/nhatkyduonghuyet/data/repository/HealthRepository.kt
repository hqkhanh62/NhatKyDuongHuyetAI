package com.example.nhatkyduonghuyet.data.repository

import com.example.nhatkyduonghuyet.data.model.LogEntry
import com.example.nhatkyduonghuyet.data.remote.FirebaseService

class HealthRepository {
    private val service = FirebaseService()

    fun save(entry: LogEntry) = service.save(entry)

    fun getAll(callback: (List<LogEntry>) -> Unit) =
        service.getAll(callback)
}
