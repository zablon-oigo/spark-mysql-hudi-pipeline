FROM jupyter/pyspark-notebook:x86_64-spark-3.5.0

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV KAFKA_BOOTSTRAP=kafka:9092
ENV KAFKA_TOPIC=globalmart.retail.products
ENV HUDI_BASE_PATH=/data/hudi/products_hudi
ENV CHECKPOINT_PATH=/data/checkpoints/products

ENV PYSPARK_SUBMIT_ARGS="\
--packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.5.0,\
org.apache.hudi:hudi-spark3.5-bundle_2.12:0.15.0 \
--conf spark.serializer=org.apache.spark.serializer.KryoSerializer \
pyspark-shell"

USER ${NB_UID}