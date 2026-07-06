package com.example.nhatkyduonghuyet.viewmodel

import androidx.lifecycle.ViewModel
import com.example.nhatkyduonghuyet.data.model.LogEntry
import com.example.nhatkyduonghuyet.data.repository.HealthRepository

class MainViewModel : ViewModel() {

    private val repo = HealthRepository()

    fun save(entry: LogEntry) = repo.save(entry)

    fun load(callback: (List<LogEntry>) -> Unit) =
        repo.getAll(callback)
}
