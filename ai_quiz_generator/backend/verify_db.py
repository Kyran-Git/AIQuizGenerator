import pymssql
import os

# CONFIGURATION
DB_CONFIG = {
    'server': 'localhost',
    'user': 'sa',
    'password': os.getenv('DB_PASSWORD', 'YourStrongPasswordHere'),
    'database': 'AiQuizGenerator'
}

def list_tables_and_keys():
    conn = None
    try:
        conn = pymssql.connect(**DB_CONFIG)
        cursor = conn.cursor()

        print("\nDATABASE STRUCTURE FOR: AiQuizGenerator")
        print("=" * 60)

        # 1. Get all Table Names
        cursor.execute("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'")
        tables = [row[0] for row in cursor.fetchall()]

        for table in tables:
            print(f"\nTABLE: {table}")
            print("-" * 60)
            print(f"{'KEY':<5} | {'COLUMN NAME':<25} | {'TYPE':<15} | {'NULLABLE'}")
            print("-" * 60)

            # 2. Get Columns and Join with Constraints to find PK/FK
            query = f"""
                SELECT 
                    c.COLUMN_NAME, 
                    c.DATA_TYPE, 
                    c.IS_NULLABLE,
                    tc.CONSTRAINT_TYPE
                FROM 
                    INFORMATION_SCHEMA.COLUMNS c
                LEFT JOIN 
                    INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu 
                    ON c.TABLE_NAME = kcu.TABLE_NAME AND c.COLUMN_NAME = kcu.COLUMN_NAME
                LEFT JOIN 
                    INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc 
                    ON kcu.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
                WHERE 
                    c.TABLE_NAME = '{table}'
                ORDER BY 
                    c.ORDINAL_POSITION
            """
            cursor.execute(query)
            columns = cursor.fetchall()

            for col in columns:
                col_name = col[0]
                dtype = col[1]
                nullable = col[2]
                constraint = col[3]

                # Determine Key Symbol
                key_symbol = ""
                if constraint == 'PRIMARY KEY':
                    key_symbol = "🔑 PK"
                elif constraint == 'FOREIGN KEY':
                    key_symbol = "🔗 FK"

                print(f"{key_symbol:<5} | {col_name:<25} | {dtype:<15} | {nullable}")

        print("\n" + "=" * 60)
        print("End of Schema")

    except Exception as e:
        print(f"Error: {e}")
    finally:
        if conn: conn.close()

if __name__ == "__main__":
    list_tables_and_keys()