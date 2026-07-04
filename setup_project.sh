#!/bin/bash

echo "Creating project structure..."

mkdir -p app/src/main/java/com/example/nhatkyduonghuyet/{ai,data/model,data/remote,data/repository,ui/dashboard,ui/detail,ui/navigation,viewmodel}
mkdir -p app/src/main/res/values

# AndroidManifest
cat > app/src/main/AndroidManifest.xml <<EOF
<manifest package="com.example.nhatkyduonghuyet">
    <application
        android:allowBackup="true"
        android:label="Nhật ký đường huyết"
        android:theme="@style/Theme.Material3.DayNight.NoActionBar">
        <activity android:name=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

# MainActivity
cat > app/src/main/java/com/example/nhatkyduonghuyet/MainActivity.kt <<EOF
package com.example.nhatkyduonghuyet

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.example.nhatkyduonghuyet.ui.navigation.AppNav

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { AppNav() }
    }
}
EOF

# MODEL
cat > app/src/main/java/com/example/nhatkyduonghuyet/data/model/LogEntry.kt <<EOF
package com.example.nhatkyduonghuyet.data.model

data class LogEntry(
    val time: String = "",
    val glucose: Float = 0f,
    val insulin: Float = 0f,
    val note: String = ""
)
EOF

# FIREBASE SERVICE
cat > app/src/main/java/com/example/nhatkyduonghuyet/data/remote/FirebaseService.kt <<EOF
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
EOF

# REPOSITORY
cat > app/src/main/java/com/example/nhatkyduonghuyet/data/repository/HealthRepository.kt <<EOF
package com.example.nhatkyduonghuyet.data.repository

import com.example.nhatkyduonghuyet.data.model.LogEntry
import com.example.nhatkyduonghuyet.data.remote.FirebaseService

class HealthRepository {
    private val service = FirebaseService()

    fun save(entry: LogEntry) = service.save(entry)

    fun getAll(callback: (List<LogEntry>) -> Unit) =
        service.getAll(callback)
}
EOF

# AI
cat > app/src/main/java/com/example/nhatkyduonghuyet/ai/HealthAI.kt <<EOF
package com.example.nhatkyduonghuyet.ai

object HealthAI {
    fun suggest(glucose: Float): String {
        return when {
            glucose > 180 -> "⚠️ Đường cao, nên giảm carb"
            glucose < 70 -> "⚠️ Đường thấp, cần ăn nhẹ"
            else -> "✅ Ổn định"
        }
    }
}
EOF

# VIEWMODEL
cat > app/src/main/java/com/example/nhatkyduonghuyet/viewmodel/MainViewModel.kt <<EOF
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
EOF

# DASHBOARD UI
cat > app/src/main/java/com/example/nhatkyduonghuyet/ui/dashboard/DashboardScreen.kt <<EOF
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

        Text("AI: \$suggestion")
    }
}
EOF

# NAVIGATION
cat > app/src/main/java/com/example/nhatkyduonghuyet/ui/navigation/AppNav.kt <<EOF
package com.example.nhatkyduonghuyet.ui.navigation

import androidx.compose.runtime.Composable
import androidx.lifecycle.viewmodel.compose.viewModel
import com.example.nhatkyduonghuyet.viewmodel.MainViewModel
import com.example.nhatkyduonghuyet.ui.dashboard.DashboardScreen

@Composable
fun AppNav() {
    val vm: MainViewModel = viewModel()
    DashboardScreen(vm)
}
EOF

echo "DONE ✅"