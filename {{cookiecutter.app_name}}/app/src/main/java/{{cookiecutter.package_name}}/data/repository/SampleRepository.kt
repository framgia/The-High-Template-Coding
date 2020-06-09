package {{cookiecutter.package_name}}.data.repository

import {{cookiecutter.package_name}}.data.model.Post

/**
 * Main entry point for accessing data.
 */
interface SampleRepository {
    suspend fun getPosts(): List<Post>
}
