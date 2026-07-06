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
