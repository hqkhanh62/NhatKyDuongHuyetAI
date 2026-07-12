package com.nhatkyduonghuyetai

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            MaterialTheme {
                Surface {
                    // TODO: thay bằng màn hình chính nhật ký đường huyết của bạn
                    Text(text = "Nhat Ky Duong Huyet AI")
                }
            }
        }
    }
}