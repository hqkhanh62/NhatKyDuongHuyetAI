package com.example.nhatkyduonghuyet.data.remote

import com.google.firebase.firestore.FirebaseFirestore
import com.example.nhatkyduonghuyet.data.model.LogEntry

class FirebaseService {
    private val db = FirebaseFirestore.getInstance()

    fun save(entry: LogEntry) {
        db.collection("logs").add(entry)
    }

    fun getAll(onResult: (List<LogEntry>) -> Unit) {
        db.collection("logs").get().addOnSuccessListener {
            val data = it.toObjects(LogEntry::class.java)
            onResult(data)
        }
    }
}
