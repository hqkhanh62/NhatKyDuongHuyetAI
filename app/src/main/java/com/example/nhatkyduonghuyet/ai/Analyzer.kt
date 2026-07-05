package com.example.nhatkyduonghuyet.ai

object HealthAnalyzer {

    fun analyze(entry: LogEntry): String {
        val bg = entry.bgBefore ?: return "Chưa đủ dữ liệu"

        return when {
            bg > 11 -> "⚠️ Đường huyết rất cao! Cần kiểm tra insulin."
            bg in 8.0..11.0 -> "🔶 Hơi cao. Nên điều chỉnh ăn uống."
            bg in 4.0..7.0 -> "✅ Ổn định"
            bg < 4 -> "🚨 Nguy hiểm! Hạ đường huyết"
            else -> "Không xác định"
        }
    }

    fun weeklyStats(list: List<LogEntry>): Triple<Double, Double, Double> {
        val values = list.mapNotNull { it.bgBefore }
        if (values.isEmpty()) return Triple(0.0, 0.0, 0.0)

        return Triple(
            values.average(),
            values.maxOrNull() ?: 0.0,
            values.minOrNull() ?: 0.0
        )
    }
}