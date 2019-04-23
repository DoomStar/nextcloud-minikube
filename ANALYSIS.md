# Further Improvements

### Amazon

* Use **Amazon RDS** instead of postgresql helm chart
* Use **Amazon ElastiCache** instead of redis helm chart
* Use **S3** instead of minio helm chart

### Private Cloud

* Use **Postgres Operator** or VMs with **stolon** instead of postgresql helm chart
* Use **Redis Operator** instead of redis helm chart
* Use **OpenStack swift** or **Distributed Minio**

### Image

I'm using kubernetes default implementation on  docker for windows.  On AWS persistent volume claims will work without declaring persistent volumes first.
Can't run more then one replica of application now. Problem is that it stores its version on disk. Also it detects clean volume as fresh install and tryes to perform installation process which is unsuccessful because of 'admin user is already exists in database' error. To solve this problem the entrypoint.sh has to be refactored:

* Store current version in external storage (database or s3 bucket)
* put version.php to the path where application expects it to be

Additional application plugins could be integrated into the image.

### IaC

* Use **terraform** for managing all cloud services