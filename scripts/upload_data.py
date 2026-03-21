import boto3
from botocore.client import Config

# Ρυθμίσεις σύνδεσης (minioadmin/minioadmin από το YAML)
s3 = boto3.resource('s3',
                    endpoint_url='http://localhost:9000',
                    aws_access_key_id='minioadmin',
                    aws_secret_access_key='minioadmin',
                    config=Config(signature_version='s3v4'),
                    region_name='us-east-1')

def upload_to_minio(bucket_name, file_path, object_name):
    # Δημιουργία bucket αν δεν υπάρχει
    if s3.Bucket(bucket_name) not in s3.buckets.all():
        s3.create_bucket(Bucket=bucket_name)
        print(f"Bucket {bucket_name} created.")

    # Ανέβασμα αρχείου
    s3.Bucket(bucket_name).upload_file(file_path, object_name)
    print(f"File {file_path} uploaded as {object_name}.")

# Παράδειγμα χρήσης
upload_to_minio('input-data', 'test_data.txt', 'input_file_1.txt')