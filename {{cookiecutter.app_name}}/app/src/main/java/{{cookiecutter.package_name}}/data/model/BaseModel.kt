package {{cookiecutter.package_name}}.data.model

import java.io.Serializable

/**
 * Base model implement common [com.google.gson.annotations.SerializedName] for retrofit request
 **/
abstract class BaseModel : Serializable