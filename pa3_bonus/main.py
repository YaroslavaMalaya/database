import mysql.connector

db_connection = mysql.connector.connect(
  host="localhost",
  user="yarrochka",
  passwd="password12345",
  database="beauty_salon"
)

cursor = db_connection.cursor()

insert_query = "INSERT INTO services (name, description, duration, price) VALUES (%s, %s, %s, %s)"
insert_values = ("Deep Cleansing", "Deep facial cleansing service", 90, 1500.00)
cursor.execute(insert_query, insert_values)
db_connection.commit()
print(f"Inserted service ID: {cursor.lastrowid}")

select_query = "SELECT * FROM services WHERE price > %s"
cursor.execute(select_query, (1000,))
for service in cursor.fetchall():
    print(service)

update_query = "UPDATE services SET price = %s WHERE name = %s"
cursor.execute(update_query, (1600.00, "Deep Cleansing"))
db_connection.commit()

delete_query = "DELETE FROM services WHERE name = %s"
cursor.execute(delete_query, ("Deep Cleansing",))
db_connection.commit()

cursor.close()
db_connection.close()
