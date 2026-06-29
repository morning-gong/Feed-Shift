package com.feedshift.feedshift

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo

class FeedShiftAccessibilityService : AccessibilityService() {
    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null) return

        val packageName = event.packageName?.toString() ?: return
        if (!targetPackages.contains(packageName)) return

        val root = rootInActiveWindow ?: return
        val texts = linkedSetOf<String>()
        collectText(root, texts)
        val capturedText = texts.joinToString("\n").take(5000)
        latestText = capturedText
        if (capturedText.isBlank()) return

        val timestamp = System.currentTimeMillis()
        val fingerprint = fingerprint(packageName, capturedText)

        synchronized(logs) {
            val existing = logs[fingerprint]
            if (existing == null) {
                logs[fingerprint] = LogRecord(
                    timestamp = timestamp,
                    packageName = packageName,
                    eventType = event.eventType,
                    text = capturedText,
                    count = 1,
                )
            } else {
                logs[fingerprint] = existing.copy(
                    timestamp = timestamp,
                    eventType = event.eventType,
                    text = capturedText,
                    count = existing.count + 1,
                )
            }
            trimLogs()
        }
    }

    override fun onInterrupt() = Unit

    private fun collectText(node: AccessibilityNodeInfo?, out: MutableSet<String>) {
        if (node == null) return

        val text = node.text?.toString()?.trim()
        if (!text.isNullOrBlank()) out.add(text)

        val description = node.contentDescription?.toString()?.trim()
        if (!description.isNullOrBlank()) out.add(description)

        for (i in 0 until node.childCount) {
            collectText(node.getChild(i), out)
        }
    }

    companion object {
        private const val maxLogs = 200
        private val targetPackages = setOf(
            "com.ss.android.ugc.aweme",
            "com.ss.android.ugc.aweme.lite",
            "com.ss.android.ugc.live",
            "com.xingin.xhs",
            "com.smile.gifmaker",
            "com.kuaishou",
            "com.kuaishou.nebula",
            "tv.danmaku.bili",
            "com.bilibili",
            "com.bilibili.app.in",
            "com.sina.weibo",
            "com.zhihu.android",
        )
        private val logs = LinkedHashMap<String, LogRecord>()

        @Volatile
        var latestText: String = ""

        fun latestLogs(): List<Map<String, Any>> = synchronized(logs) {
            logs.values
                .sortedWith(compareByDescending<LogRecord> { it.count }.thenByDescending { it.timestamp })
                .take(maxLogs)
                .map { it.toMap() }
        }

        fun clearLogs() = synchronized(logs) {
            logs.clear()
            latestText = ""
        }

        private fun trimLogs() {
            while (logs.size > maxLogs) {
                val weakestKey = logs.entries
                    .minWithOrNull(compareBy<Map.Entry<String, LogRecord>> { it.value.count }.thenBy { it.value.timestamp })
                    ?.key ?: return
                logs.remove(weakestKey)
            }
        }

        private fun fingerprint(packageName: String, text: String): String {
            val normalized = text
                .lowercase()
                .replace(Regex("\\s+"), " ")
                .take(800)
            return "$packageName:$normalized"
        }
    }

    private data class LogRecord(
        val timestamp: Long,
        val packageName: String,
        val eventType: Int,
        val text: String,
        val count: Int,
    ) {
        fun toMap(): Map<String, Any> = mapOf(
            "timestamp" to timestamp,
            "packageName" to packageName,
            "eventType" to eventType,
            "text" to text,
            "count" to count,
        )
    }
}
