import os
import mysql.connector
from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

def get_db_connection():
    return mysql.connector.connect(
        host=os.environ['DB_HOST'],
        user=os.environ['DB_USER'],
        password=os.environ['DB_PASS'],
        database=os.environ['DB_NAME']
    )

@app.route('/health')
def health():
    return jsonify({"status": "ok"}), 200

@app.route('/items')
def items():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM items")
    results = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify({"items": results}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)