package com.example.nhatkyduonghuyet.ui.dashboard

import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.foundation.layout.*
import androidx.compose.ui.unit.dp
import com.example.nhatkyduonghuyet.viewmodel.MainViewModel
import com.example.nhatkyduonghuyet.data.model.LogEntry
import com.example.nhatkyduonghuyet.ai.HealthAI

@Composable
fun DashboardScreen(vm: MainViewModel) {

    var glucose by remember { mutableStateOf("") }
    var suggestion by remember { mutableStateOf("") }

    Column(Modifier.padding(16.dp)) {

        Text("Dashboard", style = MaterialTheme.typography.headlineMedium)

        OutlinedTextField(
            value = glucose,
            onValueChange = { glucose = it },
            label = { Text("Glucose") }
        )

        Button(onClick = {
            val g = glucose.toFloatOrNull() ?: 0f
            suggestion = HealthAI.suggest(g)

            vm.save(LogEntry("Now", g, 0f, ""))
        }) {
            Text("Save")
        }

        Text("AI: $suggestion")
    }
}
