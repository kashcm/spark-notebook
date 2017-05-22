# Ispark ® :sparkles::bowtie: 

* [Docker Image](https://hub.docker.com/r/kashcm/ispark/) 

## Features

* Spark-2.0.0 preconfigured as a kernel with Jupyter notebook.
* Python3 kernel.
* Popular anaconda, Scikit and machine learning libraries included.

## How to run it

```
$ docker run -d --name ispark -p 8888:8888 -p 4040:4040 -v <mothership>:/notebooks kashcm/ispark:2.0.0
```



