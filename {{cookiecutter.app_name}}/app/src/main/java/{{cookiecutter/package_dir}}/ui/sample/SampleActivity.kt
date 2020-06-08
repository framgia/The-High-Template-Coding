package {{cookiecutter.package_name}}.ui.sample

import android.os.Bundle
import android.widget.Toast
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import {{cookiecutter.package_name}}.BR
import {{cookiecutter.package_name}}.R
import {{cookiecutter.package_name}}.databinding.ActivitySampleBinding
import {{cookiecutter.package_name}}.ui.base.BaseActivity
import kotlinx.android.synthetic.sample.activity_sample.*
import org.koin.android.viewmodel.ext.android.viewModel

/**
 * Sample activity
 * Show list post got from URL_END_POINT = https://jsonplaceholder.typicode.com/
 */
class SampleActivity : BaseActivity<ActivitySampleBinding, SampleViewModel>() {
    override val viewModel: SampleViewModel by viewModel()
    override val bindingVariable = BR.viewModel
    override val layoutId = R.layout.activity_sample

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setUpAdapter()
    }

    private fun setUpAdapter() {
        val adapter = SampleAdapter {
            Toast.makeText(this@SampleActivity, "${it.title}", Toast.LENGTH_SHORT).show()
        }
        rvPosts?.apply{
            this.adapter = adapter
            addItemDecoration(DividerItemDecoration(this.context, LinearLayoutManager.VERTICAL))
        }

        viewModel.posts.observe(this, Observer {
            it?.let {
                adapter.submitList(it)
            }
        })
    }
}
