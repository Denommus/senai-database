import pandas as pd
import MySQLdb as sql

def select_or_insert(cursor, db, table, id_field, name_field, name):
    cursor.execute("SELECT %s, %s FROM %s WHERE %s='%s'" % (id_field, name_field, table, name_field, name))
    result = cursor.fetchone()

    if not result:
        cursor.execute("INSERT INTO %s (%s) VALUES ('%s')" % (table, name_field, name))
        db.commit()
        cursor.execute("SELECT %s, %s FROM %s WHERE %s='%s'" % (id_field, name_field, table, name_field, name))
        result = cursor.fetchone()

    result

def main():
    with sql.connect(host="127.0.0.1", user="root", password="qualquercoisa", database="netflix") as db:
        with db.cursor() as cursor:

            dataset = pd.read_csv("netflix_titles.csv", sep=",")

            for (index, row) in dataset.iterrows():
                show_type = select_or_insert(cursor, db, 'show_types', 'type_id', 'type_name', row['type'])

                rating = None
                if row['rating'] and isinstance(row['rating'], str):
                    rating = select_or_insert(cursor, db, 'ratings', 'rating_id', 'rating_name', row['rating'])

                if row['director'] and isinstance(row['director'], str):
                    directors = row['director'].split(', ')
                else:
                    directors = []

                if row['cast'] and isinstance(row['cast'], str):
                    actors = row['cast'].split(', ')
                else:
                    actors = []

                if row['country'] and isinstance(row['country'], str):
                    countries = row['country'].split(', ')
                else:
                    countries = []


if __name__ == "__main__":
    main()
