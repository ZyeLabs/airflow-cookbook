import os
from airflow.contrib.hooks.spark_submit_hook import SparkSubmitHook

class MySparkSubmitHook(SparkSubmitHook):

  # def __init__(self, **kwargs):
  #   super(MySparkSubmitHook, self).__init__(**kwargs)
  #   self._env_path= kwargs.pop('env_path', None)

  def submit(self, application="", env_path=None, **kwargs):
    if env_path is not None:
      os.environ['PATH'] = env_path
    super(MySparkSubmitHook, self).submit(application,**kwargs)