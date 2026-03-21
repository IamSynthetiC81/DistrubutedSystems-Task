import os
import time

# Προσομοίωση επεξεργασίας δεδομένων
worker_id = os.getenv("HOSTNAME", "unknown-worker")
print(f"Worker {worker_id} is starting...")

# Εδώ στο μέλλον θα καλείται ο Mapper ή ο Reducer
time.sleep(5) 

print(f"Worker {worker_id} finished processing successfully.")