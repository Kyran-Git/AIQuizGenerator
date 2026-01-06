import pymssql
import os

# Updated credentials matching the Strong Password policy
DB_CONFIG = {
    'server': 'localhost',
    'user': 'sa',
    'password': os.getenv('DB_PASSWORD', 'StrongP@ssw0rd2025!'),
    'database': 'master' # Connect to 'master' first to verify the engine is alive
}

try:
    print("Connecting to SQL Server...")
    conn = pymssql.connect(**DB_CONFIG)
    print("✅ Connection Successful!")
    print("The Python bridge can now talk to the MS SQL Server container.")
    conn.close()
except Exception as e:
    print("❌ Connection Failed.")
    print(f"Error details: {e}")
    print("\nTroubleshooting tips:")
    print("1. Run 'docker ps' to ensure the container is 'Up'.")
    print("2. Ensure you used the correct password when creating the container.")