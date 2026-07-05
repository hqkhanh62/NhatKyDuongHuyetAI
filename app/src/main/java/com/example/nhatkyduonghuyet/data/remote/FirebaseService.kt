package com.example.nhatkyduonghuyet.data.remote

import com.google.firebase.firestore.FirebaseFirestore
import com.example.nhatkyduonghuyet.data.model.LogEntry

class FirebaseService {

    private val db = FirebaseFirestore.getInstance()

    fun saveLog(entry: LogEntry) {
        val id = if (entry.id.isEmpty()) db.collection("logs").document().id else entry.id
        db.collection("logs")
            .document(id)
            .set(entry.copy(id = id))
    }

    fun getLogsByDate(date: String, onResult: (List<LogEntry>) -> Unit) {
        db.collection("logs")
            .whereEqualTo("date", date)
            .get()
            .addOnSuccessListener { result ->
                val list = result.mapNotNull {
                    it.toObject(LogEntry::class.java)
                }
                onResult(list)
            }
    }

    fun getAllLogs(onResult: (List<LogEntry>) -> Unit) {
        db.collection("logs")
            .get()
            .addOnSuccessListener { result ->
                val list = result.mapNotNull {
                    it.toObject(LogEntry::class.java)
                }
                onResult(list)
            }
    }
}
