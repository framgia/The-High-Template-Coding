package {{cookiecutter.package_name}}.data.local.prefs

import android.content.Context
import androidx.core.content.edit
import com.google.gson.Gson

@Suppress("UNCHECKED_CAST")
class AppPrefs(
    context: Context,
    val gson: Gson
) : PrefsHelper {

    private val sharedPreferences = context.getSharedPreferences(
        context.packageName,
        Context.MODE_PRIVATE
    )

    override fun remove(key: String) {
        sharedPreferences.edit {
            remove(key)
        }
    }

    override fun clear() {
        sharedPreferences.edit { clear() }
    }

    override fun <T> get(key: String, clazz: Class<T>, defaultValue: T): T? {
        when (clazz) {
            String::class.java -> {
                return sharedPreferences.getString(key, defaultValue as String) as T
            }
            Boolean::class.java -> {
                return sharedPreferences.getBoolean(key, defaultValue as Boolean) as T
            }
            Float::class.java -> {
                return sharedPreferences.getFloat(key, defaultValue as Float) as T
            }
            Int::class.java -> {
                return sharedPreferences.getInt(key, defaultValue as Int) as T?
            }
            Long::class.java -> {
                return sharedPreferences.getLong(key, defaultValue as Long) as T
            }
            else -> return gson.fromJson(sharedPreferences.getString(key, ""), clazz)
        }
    }

    override fun <T> put(key: String, data: T) {
        val editor = sharedPreferences.edit()
        when (data) {
            is String -> editor.putString(key, data as String)
            is Boolean -> editor.putBoolean(key, data as Boolean)
            is Float -> editor.putFloat(key, data as Float)
            is Int -> editor.putInt(key, data as Int)
            is Long -> editor.putLong(key, data as Long)
            else -> editor.putString(key, gson.toJson(data))
        }
        editor.apply()
    }
}
