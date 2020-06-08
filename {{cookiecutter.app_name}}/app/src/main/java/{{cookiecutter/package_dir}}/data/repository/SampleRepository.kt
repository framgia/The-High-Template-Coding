package {{cookiecutter.package_name}}.data.repository

import {{cookiecutter.package_name}}.data.model.Post

interface SampleRepository {
    suspend fun getPosts(): List<Post>
}
