from airflow.contrib.operators.spark_submit_operator import SparkSubmitOperator
from hooks.my_spark_submit_hook import MySparkSubmitHook

class MySparkSubmitOperator(SparkSubmitOperator):

  def __init__(self, **kwargs):
    super(MySparkSubmitOperator, self).__init__(**kwargs)
    self._env_path = "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin"

  def execute(self, context):
    self._hook = MySparkSubmitHook(
      conf=self._conf,
      conn_id=self._conn_id,
      files=self._files,
      py_files=self._py_files,
      archives=self._archives,
      driver_class_path=self._driver_class_path,
      jars=self._jars,
      java_class=self._java_class,
      packages=self._packages,
      exclude_packages=self._exclude_packages,
      repositories=self._repositories,
      total_executor_cores=self._total_executor_cores,
      executor_cores=self._executor_cores,
      executor_memory=self._executor_memory,
      driver_memory=self._driver_memory,
      keytab=self._keytab,
      principal=self._principal,
      name=self._name,
      num_executors=self._num_executors,
      application_args=self._application_args,
      env_vars=self._env_vars,
      verbose=self._verbose,
      spark_binary=self._spark_binary
    )
    self._hook.submit(self._application, self._env_path)
